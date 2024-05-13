using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using static CursusVia.Util;

namespace CursusVia.Admin
{
    public partial class UpdateAdminAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdminData(); // Optionally load existing data to be updated
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string newPassword = txtPass.Text;
            string confirmNewPassword = txtConfirmPass.Text;

            if (newPassword != confirmNewPassword)
            {
                lblStatus.Text = "Passwords do not match.";
                lblStatus.Visible = true;
                return;
            }

            string hashedPassword = SecurityHelper.HashPassword(newPassword);
            string connectionString = Global.CS;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string sql = "UPDATE Admins SET Email = @Email, Password = @Password WHERE AdminID = @AdminID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);
                        cmd.Parameters.AddWithValue("@AdminID", Session["AdminID"]);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Redirect("~/Admin/UpdateConfirmation.aspx");
                        }
                        else
                        {
                            lblStatus.Text = "Update failed. No data was changed.";
                            lblStatus.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error updating account: " + ex.Message;
                lblStatus.Visible = true;
            }
        }

        private void LoadAdminData()
        {
            string connectionString = Global.CS; // Global connection string
            string sql = "SELECT username, email FROM Admins WHERE id = @AdminID";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    // the Admin ID is stored in the session upon login
                    cmd.Parameters.AddWithValue("@AdminID", HttpContext.Current.Session["AdminID"]);

                    try
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            { 
                    
                                txtEmail.Text = reader["email"].ToString();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions 
                        Console.WriteLine("Error loading admin data: " + ex.Message);
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Request.UrlReferrer == null)
            {
                Response.Redirect("~/Admin/AdminAccount.aspx");
               
            }
            else
            {
                Response.Redirect(Request.UrlReferrer.ToString());
            }
        }
    }
}
