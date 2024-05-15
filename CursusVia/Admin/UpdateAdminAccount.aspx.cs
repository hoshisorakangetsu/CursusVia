using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using static CursusVia.Util;

namespace CursusVia.Admin
{
    public partial class UpdateAdminAccount : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsAuthenticated())
                {
                    Response.Redirect("~/Admin/Login.aspx"); // Redirect to login if not authenticated
                }
                LoadAdminEmail();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string verificationKey = txtVerify.Text.Trim();
            if (verificationKey != "1996")
            {
                lblStatus.Text = "Invalid verification key.";
                lblStatus.Visible = true;
                return;
            }

            string newPassword = txtPass.Text.Trim();
            string confirmNewPassword = txtConfirmPass.Text.Trim();

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
                    string sql = "UPDATE Admins SET Password = @Password WHERE id = @AdminID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);
                        cmd.Parameters.AddWithValue("@AdminID", GetAdminIdFromCookie());

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

        private void LoadAdminEmail()
        {
            string connectionString = Global.CS;
            string sql = "SELECT email FROM Admins WHERE id = @AdminID";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@AdminID", GetAdminIdFromCookie());
                    try
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtEmail.Text = reader["email"].ToString();
                                txtEmail.ReadOnly = true;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "Error loading admin data: " + ex.Message;
                        lblStatus.Visible = true;
                    }
                }
            }
        }

        private int? GetAdminIdFromCookie()
        {
            HttpCookie authCookie = Request.Cookies["AdminAuth"];
            if (authCookie != null && authCookie.Values["AdminID"] != null)
            {
                if (int.TryParse(authCookie.Values["AdminID"], out int adminId))
                {
                    return adminId;
                }
                else
                {
                    lblStatus.Text = "Invalid session data.";
                    lblStatus.Visible = true;
                }
            }
            else
            {
                lblStatus.Text = "Session not found. Please login again.";
                lblStatus.Visible = true;
            }
            return null; // Return null if the admin ID is not found or invalid
        }

        private bool IsAuthenticated()
        {
            return GetAdminIdFromCookie() != null;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admin/AdminAccount.aspx"); // Redirect back to a safe admin page
        }



    }
}
