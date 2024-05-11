using CursusVia.Customer;
using CursusVia.Models;
using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class UpdateRequest : System.Web.UI.Page
    {
        private string id;
        private string adminId;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                adminId = authTicket.Name;
            }

            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(adminId)) { adminId = "1"; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT [title], [date_send], [description], [tutor_id], [student_id] FROM [SupportRequests] WHERE [id] ='" + id + "'";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblRequestTitle.Text = reader["title"].ToString();
                    lblPostTime.Text = "Posted on:" + reader["date_send"].ToString();
                    lblDescr.Text = reader["description"].ToString();
                }
            }
            con.Close();

            con.Open();

            string replies = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = '" + id + "'";
            SqlDataAdapter adapter = new SqlDataAdapter(replies, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();

            con.Close();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect("SupportRequest.aspx");
        }
    }
}