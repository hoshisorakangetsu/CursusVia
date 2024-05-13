using CursusVia.Customer;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class NewRequest : System.Web.UI.Page
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
            
            //if (String.IsNullOrEmpty(tutorId)) { tutorId = "1"; }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            string sql = "INSERT INTO[dbo].[SupportRequests] ([title],[date_send],[description],[status],[tutor_id])VALUES(@Title,@DateSend,@Description,@Status,@TutorId)";
            SqlCommand insert = new SqlCommand(sql, con);

            insert.Parameters.AddWithValue("@Title", txtReqTitle.Text);
            insert.Parameters.AddWithValue("@DateSend", DateTime.Now); // Current date and time
            insert.Parameters.AddWithValue("@Description", txtReqContent.Text);
            insert.Parameters.AddWithValue("@Status", "Processing");
            insert.Parameters.AddWithValue("@TutorId", tutorId);

            int row = insert.ExecuteNonQuery();

            if (row > 0)
            {
                Session["toast"] = new Toast("Request created successfully", "success");
                Response.Redirect("Support.aspx");
                //Response.Write("<script>alert('Request created successfully');window.location = 'Support.aspx';</script>");
            }
            else
            {
                Session["toast"] = new Toast("Request does not created successfully", "fail");
                Response.Redirect("Support.aspx");
                
                //Response.Write("<script>alert('Request does not created successfully');window.location = 'Support.aspx';</script>");
            }
        }
    }
}