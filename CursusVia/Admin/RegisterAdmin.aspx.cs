using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using static CursusVia.Util;

namespace CursusVia.Admin
{
    public partial class RegisterAdmin : Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtUsername.Focus();
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;
            string sql = "SELECT COUNT(*) FROM Admins WHERE Email = @email";
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                con = new SqlConnection(cs);
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@email", email);

                con.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    // Same email exists, show error message
                    args.IsValid = false;
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Registration failed: " + ex.Message;
                lblStatus.Visible = true;
            }
            finally
            {
                if (cmd != null)
                    cmd.Dispose();
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // Server-side validation passed
            {
                string verificationKey = "1996"; // This should ideally be stored securely
                if (txtVerify.Text == verificationKey)
                {
                    string username = txtUsername.Text;
                    string password = SecurityHelper.HashPassword(txtPass.Text); //hashing the password
                    string email = txtEmail.Text;
                    string sql = "INSERT INTO Admins (username, password, email) VALUES (@Username, @Password, @Email)";

                    SqlConnection con = null;
                    SqlCommand cmd = null;

                    try
                    {
                        con = new SqlConnection(cs);
                        cmd = new SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@Email", email);

                        con.Open();
                        int count = (int)cmd.ExecuteNonQuery();

                        if (count > 0)
                        {
                            // Redirect on success
                            Response.Redirect("/Admin/RegisterConfirmation.aspx");
                        }
                        else
                        {
                            lblStatus.Text = "Registration failed. No rows were inserted.";
                            lblStatus.Visible = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "Registration failed: " + ex.Message;
                        lblStatus.Visible = true;
                    }
                    finally
                    {
                        if (cmd != null)
                            cmd.Dispose();
                        if (con != null)
                        {
                            con.Close();
                            con.Dispose();
                        }
                    }
                }
                else
                {
                    lblStatus.Text = "Invalid verification keyword.";
                    lblStatus.Visible = true;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect to the same page
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}
