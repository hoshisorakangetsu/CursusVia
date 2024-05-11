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

namespace CursusVia.Customer
{
    public partial class EditSupport : System.Web.UI.Page
    {
        private string studentId;
        private string requestId;
        protected void Page_Load(object sender, EventArgs e)
        {
            requestId = Request.QueryString["id"];

                

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }
            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(studentId)) { studentId = "1"; }

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string read = "SELECT [title], [description] FROM [SupportRequests] WHERE [id] = '" + requestId + "'";
                con.Open();

                SqlCommand cmd = new SqlCommand(read, con);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        txtReqTitle.Text = reader["title"].ToString();
                        txtReqContent.Text = reader["description"].ToString();
                    }
                }
                con.Close();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            con.Open();
            string update = "UPDATE [dbo].[SupportRequests] SET [title] = @Title, [description] = @Description, [status] = @Status WHERE [id] = @id";

            SqlCommand cmd = new SqlCommand(update, con);
            cmd.Parameters.AddWithValue("@Title", txtReqTitle.Text);
            cmd.Parameters.AddWithValue("@Description", txtReqContent.Text);
            cmd.Parameters.AddWithValue("@Status", "Processing");
            cmd.Parameters.AddWithValue("@id", requestId);

            int row = cmd.ExecuteNonQuery();

            if (row > 0)
            {
                Response.Write("<script>alert('Request edit successfully');window.location = 'Support.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Request does not edit successfully');window.location = 'Support.aspx';</script>");
            }
        }
    }
}