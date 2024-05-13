using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using static CursusVia.Util;

namespace CursusVia.Admin
{
    public partial class AdminAccount : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Initial page setup can be placed here
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            string authenticatedUserId = AuthenticateAdmin(username, password);

            if (authenticatedUserId != "0")
            {
                FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                    1, // Ticket version
                    authenticatedUserId, // User ID
                    DateTime.Now,
                    DateTime.Now.AddMinutes(60), // Ticket expiration
                    false, 
                    "Admin" 
                );
                string encTicket = FormsAuthentication.Encrypt(ticket);
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket);
                Response.Cookies.Add(authCookie);
                Response.Redirect("~/Admin/WithdrawalRequest.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid username or password');window.location = 'LoginAdmin.aspx';</script>");
            }
        }

        private string AuthenticateAdmin(string username, string password)
        {
            string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string sql = "SELECT id FROM Admins WHERE username=@Username AND password=@Password";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Username", username.Trim());
                cmd.Parameters.AddWithValue("@Password", getHash(password.Trim()));
                con.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? result.ToString() : "0";
            }
        }

        public static string getHash(string inputPassword)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] hashedBytes = sha.ComputeHash(Encoding.UTF8.GetBytes(inputPassword));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        protected void lbtnShowRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAdmin.aspx");
        }

        protected void lbtnForgetPass_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPasswordAdmin.aspx");
        }
    }
}
