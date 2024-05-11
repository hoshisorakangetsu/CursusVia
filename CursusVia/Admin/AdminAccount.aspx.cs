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
            string hashedPassword = SecurityHelper.HashPassword(password); // Ensure password is hashed for security

            string connectionString = Global.CS; // Global connection string
            string sql = "SELECT password, id FROM Admins WHERE username = @Username OR email = @Username";

            SqlConnection con = null;
            SqlCommand cmd = null;
            SqlDataReader reader = null;

            try
            {
                con = new SqlConnection(connectionString);
                con.Open();
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@username", usernameOrEmail);

                reader = cmd.ExecuteReader(); // Execute reader here after command setup

                if (reader.Read())
                {
                    string dbHashedPassword = reader["password"].ToString();
                    int adminId = Convert.ToInt32(reader["id"]); // Retrieve the admin ID

                    if (dbHashedPassword != null && dbHashedPassword == hashedPassword)
                    {
                        Session["LoggedIn"] = true;
                        Session["Username"] = usernameOrEmail;
                        Session["AdminID"] = adminId;  // Storing the AdminID in the session
                        lblStatus.Text = "Login successful!";
                        lblStatus.CssClass = "success";
                        Response.Redirect("/Admin/WithdrawalRequest.aspx"); // Redirect to admin dashboard if login is successful
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
            catch (Exception ex)
            {
                lblStatus.Text = "Error during login: " + ex.Message;
                lblStatus.CssClass = "error";
                lblStatus.Visible = true;
            }
            finally
            {
                // Ensure resources are properly cleaned up
                if (reader != null)
                    reader.Close();
                if (cmd != null)
                    cmd.Dispose();
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }


    }
}
