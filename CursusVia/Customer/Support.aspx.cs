using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CursusVia.Customer
{
    public partial class Support : System.Web.UI.Page
    {
        private string studentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }
            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(studentId)) { studentId = "1"; }


            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = '" + studentId + "'";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string filter, begin, end;
            filter = ddlStatus.SelectedValue;
            if (filter.Equals("None"))
                filter="";
            if (startDate.Text.Length > 0)
                begin = startDate.Text;
            else
                begin = "";
            if (EndDate.Text.Length > 0)
                end = EndDate.Text;
            else
                end ="";

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query;
            query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = '" + studentId + "'" + " AND [status] = '" + filter + "'";
            // query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = '" + studentId + "'" + " AND [status] = '" + filter + "'";
            //query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = '" + studentId + "'" + " AND [date_send] BETWEEN '" + begin + "' AND '" + end + "'";
            //query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = '" + studentId + "'" + " AND [date_send] BETWEEN '" + begin + "' AND '" + end + "' AND [status] = '" + filter + "'";
            con.Open();
            SqlDataAdapter sql = new SqlDataAdapter(query, con);
            DataSet dt = new DataSet();
            sql.Fill(dt);
            Repeater1.DataSource=dt;
            Repeater1.DataBind();
            con.Close();
        }
    }
}