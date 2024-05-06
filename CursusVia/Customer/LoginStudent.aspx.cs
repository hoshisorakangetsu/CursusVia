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

namespace CursusVia.Customer
{
	public partial class LoginStudent : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Session["Username"] = txtUsername.Text;

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
			//Response.Redirect("Student.aspx");
			string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			using (SqlConnection con = new SqlConnection(CS))
			{
				string sql = "Select COUNT(*) from Students where Email=@Email and Password=@Password";
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@Email", txtUsername.Text.Trim());
				cmd.Parameters.AddWithValue("@Password", Decrypt(txtPassword.Text.Trim()));
				con.Open();

				int Username = (Int32)cmd.ExecuteScalar();
				if (Username == 1)
				{
					Session["Username"] = txtUsername.Text;
					Response.Redirect("Student.aspx");
					Session.RemoveAll();

				}
				
				else
				{
					lblMessage.ForeColor = System.Drawing.Color.Red;
					lblMessage.Text = "Invalid username and password";
				}
				
			}
		}
		public string Decrypt(string clearText)
		{
			string EncryptionKey = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
			byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
			using (Aes encryptor = Aes.Create())
			{
				Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
				encryptor.Key = pdb.GetBytes(32);
				encryptor.IV = pdb.GetBytes(16);
				using (MemoryStream ms = new MemoryStream())
				{
					using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
					{
						cs.Write(clearBytes, 0, clearBytes.Length);
						cs.Close();
					}
					clearText = Convert.ToBase64String(ms.ToArray());
				}
			}
			return clearText;
		}
	}

		
	}
