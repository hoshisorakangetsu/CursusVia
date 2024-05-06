using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Security.Cryptography;
using System.Text;
using System.IO;

namespace CursusVia.Customer
{
	public partial class RegisterStudent : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			try
			{
				string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
				using (SqlConnection con = new SqlConnection(CS))
				{
					string sql = "INSERT INTO Students (email, password, name)" + "VALUES (@email,@password,@name)  ";
					SqlCommand cmd = new SqlCommand(sql, con);



					cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
					cmd.Parameters.AddWithValue("@password", Encrypt(txtPass.Text.Trim()));
					cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());

					con.Open();
					cmd.ExecuteNonQuery();
					con.Close();



					lblMessage.Text = "You have registered succussfully";
					lblMessage.ForeColor = System.Drawing.Color.Green;


				}
			}

			catch (Exception)
			{

				lblMessage.Text = "You have not registered";
				lblMessage.ForeColor = System.Drawing.Color.Red;

			}




		}

		private string Encrypt(string clearText)
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
	
		/*
		protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string email = args.Value;
			string sql = "SELECT COUNT(*) FROM Students WHERE email = @email";
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

			SqlConnection con = new SqlConnection(cs);

			SqlCommand cmd = new SqlCommand(sql, con);

			cmd.Parameters.AddWithValue("@email",email);

			con.Open();
			int count = (int)cmd.ExecuteScalar();

			if (count > 0)
			{
				//same student id existed 
				//show error message
				args.IsValid = false;
			}
			con.Close();
		}
		*/
	
//}