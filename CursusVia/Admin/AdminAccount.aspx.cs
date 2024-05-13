using System;
using System.Data.SqlClient;
using System.Runtime.Remoting.Messaging;
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
            string hashedPassword = SecurityHelper.HashPassword(password); // Hashing the password for security

            string connectionString = Global.CS; // Using global connection string
            string sql = "SELECT password, id FROM Admins WHERE username = @Username OR email = @Username";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@username", usernameOrEmail);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string dbHashedPassword = reader["password"].ToString();
                                int adminId = Convert.ToInt32(reader["id"]); // Retrieve the admin ID

                                if (dbHashedPassword == hashedPassword)
                                {
                                    // Create a secure cookie with admin ID and login indicator
                                    HttpCookie authCookie = new HttpCookie("AdminAuth");
                                    authCookie.Values["AdminID"] = adminId.ToString();
                                    authCookie.Values["LoggedIn"] = "true";
                                    authCookie.Expires = DateTime.Now.AddDays(1);
                                    authCookie.HttpOnly = true;
                                    Response.Cookies.Add(authCookie);

                                    lblStatus.Text = "Login successful!";
                                    lblStatus.CssClass = "success";
                                    Response.Redirect("/Admin/WithdrawalRequest.aspx");
                                }
                                else
                                {
                                    lblStatus.Text = "Invalid username or password.";
                                    lblStatus.CssClass = "error";
                                    lblStatus.Visible = true;
                                }
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
                catch (Exception ex)
                {
                    lblStatus.Text = "Error during login: " + ex.Message;
                    lblStatus.CssClass = "error";
                    lblStatus.Visible = true;
                }
            }
        }
    }
}
