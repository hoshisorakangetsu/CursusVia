using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Web.Security;

namespace CursusVia.Customer
{
	public partial class LoginStudent : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			

		}
		/*
		protected void lbtnShowLogin_Click(object sender, EventArgs e)
		{
			// Toggle visibility of the Logoin panel
			pnlLogin.Visible = !pnlLogin.Visible;
			pnlRegister.Visible = false;
			
		}

		protected void lbtnShowRegister_Click(object sender, EventArgs e)
		{
			pnlRegister.Visible = !pnlRegister.Visible;
			pnlLogin.Visible = false;
		}
		

		protected void lbtnForgetPass_Click(object sender, EventArgs e)
		{
			pnlForgetPw.Visible = !pnlForgetPw.Visible;
			pnlLogin.Visible = false;
			pnlRegister.Visible = false;
		}
		*/
		protected void btnLogin_Click(object sender, EventArgs e)
		{
			/*
			string email = txtUsername.Text;
			string password = txtPassword.Text;
			bool rememberMe = cbRememberMe.Checked;
			string hash = getHash(password);

			//Response.Redirect("Student.aspx");
			string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			using (SqlConnection con = new SqlConnection(CS))
			{
				string sql = "Select COUNT(*) from Students where email=@Email and password=@Password";
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@Email", txtUsername.Text.Trim());
				cmd.Parameters.AddWithValue("@Password", getHash(txtPassword.Text.Trim()));
				con.Open();

				int matched = (Int32)cmd.ExecuteScalar();
				if (matched == 1)
				{
					
				}
				
				else
				{
					lblMessage.ForeColor = System.Drawing.Color.Red;
					lblMessage.Text = "Invalid username and password";
				}
				
			}*/
			string username = txtUsername.Text;
			string password = txtPassword.Text;
			bool rememberMe=cbRememberMe.Checked;

			string authenticatedUserId = AuthenticateUser(txtUsername.Text, txtPassword.Text);



            if (authenticatedUserId != "0" && captchacode.Text.ToLower() == Session["sessionCaptcha"].ToString())
			{

				//FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, cbRememberMe.Checked);
				/*
			{
					Response.Cookies["authCookie"]["email"] = txtUsername.Text;
					Response.Cookies["authCookie"]["password"] = txtPassword.Text;
				
				}
				*/


				//	FormsAuthentication.RedirectFromLoginPage(txtUsername.Text,cbRememberMe.Checked);

				FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
					1,
				authenticatedUserId,
				DateTime.Now,
				DateTime.Now.AddMinutes(30),
				rememberMe,
				"Customer"
			 );
				string encTicket = FormsAuthentication.Encrypt(ticket);
				HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket);
				if (rememberMe)
				{
					authCookie.Expires = DateTime.Now.AddYears(1); // Example: Cookie expires in 1 year
				}

				Response.Cookies.Add(authCookie);

				//Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));
				//string userData = authTicket.UserData;
				//FormsIdentity identity=(FormsIdentity)ctx.User.Identity;
				//string[] username = identity.Ticket.UserData.Split(',');
				Response.Redirect("Student.aspx");
			}
			else
			{
				if (authenticatedUserId == "0")
				{
					Response.Write("<script>alert('Invalid email or password');window.location = 'LoginStudent.aspx';</script>");

				}

				if (captchacode.Text.ToLower() != Session["sessionCaptcha"].ToString())
				{
					Response.Write("<script>alert('Captcha code incorrect. Please try again ');window.location = 'LoginStudent.aspx';</script>");

				}
			}

		}
		private string AuthenticateUser(string email,string password)
		{
			string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			using (SqlConnection con = new SqlConnection(CS))
			{
				string sql = "Select id from Students where email=@Email and password=@Password";
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@Email", txtUsername.Text.Trim());
				cmd.Parameters.AddWithValue("@Password", getHash(txtPassword.Text.Trim()));
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

		
	}


}
