using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
	public partial class LoginTutor : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

       

		protected void btnLogin_Click(object sender, EventArgs e)
		{
			string username = txtUsername.Text;
			string password = txtPassword.Text;
			bool rememberMe = cbRememberMe.Checked;

			string authenticatedUserId = AuthenticateTutor(txtUsername.Text, txtPassword.Text);



			 if (authenticatedUserId != "0" && captchacode.Text.ToLower() == Session["sessionCaptcha"].ToString())
			{
				// Redirect the user to the AdminHome  page

				FormsAuthenticationTicket ticketTutor = new FormsAuthenticationTicket(
					1,
				authenticatedUserId,
				DateTime.Now,
				DateTime.Now.AddMinutes(30),
				rememberMe,
				"Tutor"
			 );
				string encTicketTutor = FormsAuthentication.Encrypt(ticketTutor);
				HttpCookie authCookieTutor = new HttpCookie(FormsAuthentication.FormsCookieName, encTicketTutor);
				if (rememberMe)
				{
					authCookieTutor.Expires = DateTime.Now.AddYears(1); // Example: Cookie expires in 1 year
				}

				Response.Cookies.Add(authCookieTutor);
				Response.Redirect("Tutor.aspx");
			}
			else
			{
				if (authenticatedUserId == "0")
				{
					Response.Write("<script>alert('Invalid email or password');window.location = 'LoginTutor.aspx';</script>");

				}

				if (captchacode.Text.ToLower() != Session["sessionCaptcha"].ToString())
				{
					Response.Write("<script>alert('Captcha code incorrect. Please try again ');window.location = 'LoginTutor.aspx';</script>");

				}

			}
		}
		private string AuthenticateTutor(string email, string password)
		{
			string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			using (SqlConnection con = new SqlConnection(CS))
			{
				string sql = "Select id from Tutors where email=@email and password=@password";
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@email", txtUsername.Text.Trim());
				cmd.Parameters.AddWithValue("@password", getHash(txtPassword.Text.Trim()));
				con.Open();
				int matched = Convert.ToInt32(cmd.ExecuteScalar());
				return matched.ToString();
			}
		}
		public static string getHash(string oriPassword)
		{
			//convert password from string > binary
			byte[] binPassoword = Encoding.Default.GetBytes(oriPassword);

			//create hashing function
			SHA256 sha = SHA256.Create();

			//calculate hash value based on password that 
			//has been converted to binary
			byte[] binHash = sha.ComputeHash(binPassoword);

			//convert binaryHash > string
			string strHash = Convert.ToBase64String(binHash);

			return strHash;
		}
		protected void lbtnShowRegister_Click(object sender, EventArgs e)
		{
			Response.Redirect("RegisterTutor.aspx");
		}

		protected void lbtnForgetPass_Click(object sender, EventArgs e)
		{
			Response.Redirect("loginEmailOtp");
		}
	}
}