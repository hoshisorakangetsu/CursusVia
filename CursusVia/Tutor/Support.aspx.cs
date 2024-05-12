using CursusVia.Customer;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class Support : System.Web.UI.Page
    {
        private string tutorId;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                tutorId = authTicket.Name;
            }
            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(tutorId)) { tutorId = "1"; }

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string query = "SELECT [id], [title], [date_send], [description], [status], [tutor_id] FROM [SupportRequests] WHERE [tutor_id] = '" + tutorId + "'";
                con.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(query, con);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);
                Repeater1.DataSource=dataSet;
                Repeater1.DataBind();
                con.Close();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string filter, begin = "", end = "";
            bool isStatus = false;
            bool isStart = false;
            bool isEnd = false;

            DateTime date = Convert.ToDateTime(this.EndDate.Text);
            date = date.AddDays(1);

            filter = ddlStatus.SelectedValue;
            if (!filter.Equals("None"))
                isStatus = true;
            if (startDate.Text.Length > 0)
            {
                begin = startDate.Text;
                isStart = true;
            }
            if (EndDate.Text.Length > 0)
            {
                end = date.ToString("yyyy-MM-dd");
                isEnd = true;
            }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT [id], [title], [date_send], [description], [status], [tutor_id] FROM [SupportRequests] WHERE [tutor_id] = '" + tutorId + "'";
            if (isStatus)
            {
                query = String.Concat(query, " AND [status] = '" + filter + "'");
            }
            if (isStart)
            {
                query = String.Concat(query, " AND [date_send] >= '" +  begin + "'");
            }
            if (isEnd)
            {
                query = String.Concat(query, " AND [date_send] <= '" + end + "'");
            }
            con.Open();
            SqlDataAdapter sql = new SqlDataAdapter(query, con);
            DataSet dt = new DataSet();
            sql.Fill(dt);
            Repeater1.DataSource=dt;
            Repeater1.DataBind();
            con.Close();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            EndDate.Text = "";
            startDate.Text ="";

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT [id], [title], [date_send], [description], [status], [tutor_id] FROM [SupportRequests] WHERE [tutor_id] = '" + tutorId + "'";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }
    }
}