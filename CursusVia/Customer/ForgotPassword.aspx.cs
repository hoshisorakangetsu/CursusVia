using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;



namespace CursusVia.Customer
{
	public partial class ForgotPassword : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
		public string Decrypt(string cipherText)
		{
			string EncryptionKey = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
			byte[] cipherBytes = Convert.FromBase64String(cipherText);
			using (Aes decryptor = Aes.Create())
			{
				Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
				decryptor.Key = pdb.GetBytes(32);
				decryptor.IV = pdb.GetBytes(16);
				using (MemoryStream ms = new MemoryStream(cipherBytes))
				{
					using (CryptoStream cs = new CryptoStream(ms, decryptor.CreateDecryptor(), CryptoStreamMode.Read))
					{
						byte[] decryptedBytes = new byte[ms.Length];
						int decryptedCount = cs.Read(decryptedBytes, 0, decryptedBytes.Length);
						return Encoding.Unicode.GetString(decryptedBytes, 0, decryptedCount);
					}
				}
			}
		}
	

		protected void Button1_Click(object sender, EventArgs e)
		{
			string password = "";
			string email = txtEmail.Text;
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			string sql = "SELECT password FROM Students WHERE email=@Email ";
			SqlConnection con = new SqlConnection(cs);
			SqlCommand cmd = new SqlCommand(sql, con);
			cmd.Parameters.AddWithValue("email", email);
			con.Open();
			SqlDataReader dr = cmd.ExecuteReader();
			while (dr.Read())
			{
				password = dr["password"].ToString();
				//Response.Write(password);
			}
			con.Close();
			/*
			if (!string.IsNullOrEmpty(password))
			{
				MailMessage msg = new MailMessage();
				msg.From = new MailAddress("yikityong@gmail.com");
				msg.To.Add(txtEmail.Text);
				msg.Subject = " Recover your Password";
				msg.Body = ( "Your Password is:" + password);
				msg.IsBodyHtml = true;

				SmtpClient smt = new SmtpClient();
				smt.Host = "smtp.gmail.com";
				System.Net.NetworkCredential ntwd = new NetworkCredential();
				ntwd.UserName = txtEmail.ToString(); //Your Email ID  
				ntwd.Password = ""; // Your Password  
				smt.UseDefaultCredentials = true;
				smt.Credentials = ntwd;
				smt.Port = 587;
				smt.EnableSsl = true;
				smt.Send(msg);
				lblMsg.Text = " Password Sent Successfully";
				lblMsg.ForeColor = System.Drawing.Color.ForestGreen;
			}*/
			
			if (!string.IsNullOrEmpty(password))
			{
				MailMessage msg = new MailMessage();
				msg.From = new MailAddress("yongyk-pp21@student.tarc.edu.my");
				msg.To.Add(txtEmail.Text);
				msg.Subject = "Recover your Password";
				msg.Body = "Your Password is: " + password;
				msg.IsBodyHtml = true;

				SmtpClient smt = new SmtpClient();
				smt.Host = "smtp.gmail.com";
				smt.Port = 587;
				smt.EnableSsl = true;
				smt.UseDefaultCredentials = false; // Don't use default credentials
				smt.Credentials = new System.Net.NetworkCredential("yongyk-pp21@student.tarc.edu.my", "030128070217");
				//smt.Credentials = new NetworkCredential("your_email@gmail.com", "your_password"); // Provide valid credentials here

				smt.Send(msg);
				lblMsg.Text = "Password Sent Successfully";
				lblMsg.ForeColor = System.Drawing.Color.ForestGreen;
			}
			
		}
	}
}