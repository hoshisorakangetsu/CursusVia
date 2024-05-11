using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class NewRequest : System.Web.UI.Page
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
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            string sql = "INSERT INTO[dbo].[SupportRequests] ([title],[date_send],[description],[status],[student_id])VALUES(@Title,@DateSend,@Description,@Status,@StudentId)";
            SqlCommand insert = new SqlCommand(sql, con); 

            insert.Parameters.AddWithValue("@Title", txtReqTitle.Text);
            insert.Parameters.AddWithValue("@DateSend", DateTime.Now); // Current date and time
            insert.Parameters.AddWithValue("@Description", txtReqContent.Text);
            insert.Parameters.AddWithValue("@Status", "Processing");
            insert.Parameters.AddWithValue("@StudentId", studentId);

            int row = insert.ExecuteNonQuery();

            if (row > 0)
            {
                Response.Write("<script>alert('Request created successfully');window.location = 'Support.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Request does not created successfully');window.location = 'Support.aspx';</script>");
            }
        }
    }
}