﻿using System;
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
	
		protected void btnLogin_Click(object sender, EventArgs e)
		{
			
			string username = txtUsername.Text;
			string password = txtPassword.Text;
			bool rememberMe = cbRememberMe.Checked;

			string authenticatedUserId = AuthenticateUser(txtUsername.Text, txtPassword.Text);


			if (authenticatedUserId != "0" && captchacode.Text.ToLower() == (Session["sessionCaptcha"] != null ? Session["sessionCaptcha"].ToString() : "") )
			{
				

			FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
					1,
				authenticatedUserId,
				DateTime.Now,
				DateTime.Now.AddMinutes(60),
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
		private string AuthenticateUser(string email, string password)
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

		protected void lbtnShowRegister_Click(object sender, EventArgs e)
		{
			Response.Redirect("RegisterStudent.aspx");
		}

		protected void lbtnForgetPass_Click(object sender, EventArgs e)
		{
			Response.Redirect("ForgotPassword.aspx");
		}
	}


}
