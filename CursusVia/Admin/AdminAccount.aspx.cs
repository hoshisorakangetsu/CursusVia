using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using static CursusVia.Util;

namespace CursusVia.Admin
{
    public partial class AdminAccount : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usernameOrEmail = txtUsername.Text;
            string password = txtPassword.Text;
            string hashedPassword = SecurityHelper.HashPassword(password); //hash the password  for security purposes

            string connectionString = Global.CS; // connection string stored globally
            string sql = "SELECT password FROM Admins WHERE username = @username OR email = @username";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@username", usernameOrEmail);
                var dbHashedPassword = cmd.ExecuteScalar() as string;

                if (dbHashedPassword != null && dbHashedPassword == hashedPassword)
                {
                    Session["LoggedIn"] = true;
                    Session["Username"] = usernameOrEmail;
                    lblStatus.Text = "Login successful!";
                    lblStatus.CssClass = "success";
                    Response.Redirect("/Admin/WithdrawalRequest.aspx"); // Redirect to dashboard if login is successful
                }
                else
                {
                    lblStatus.Text = "Invalid username or password.";
                    lblStatus.CssClass = "error";
                    lblStatus.Visible = true;
                }
            }
        }
    }
}
