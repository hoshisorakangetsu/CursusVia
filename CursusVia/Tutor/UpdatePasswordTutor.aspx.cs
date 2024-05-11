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
	public partial class UpdatePasswordTutor : System.Web.UI.Page
	{
		string sql = null;
		string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

		SqlConnection con;
		SqlCommand cmd;
		protected void Page_Load(object sender, EventArgs e)
		{

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

		protected void Button1_Click(object sender, EventArgs e)
		{
			try
			{

				if (User.Identity.IsAuthenticated)
				{

					HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
					string encryptedTicket = authCookie.Value;
					FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
					string id = authTicket.Name;
					// Retrieve the hashed password from the database
					string storedPasswordHash = GetStoredPasswordHash(id);

					string oldPassword = txtOldPassword.Text;
					string newPassword = txtNewPassword.Text;
					string confirmPassword = txtConfirmPassword.Text;
					string enteredOldPasswordHash = getHash(oldPassword);

					// Compare hashed passwords
					if (storedPasswordHash != enteredOldPasswordHash)
					{
						lblMsg3.Text = "Old password is incorrect.";
						lblMsg3.ForeColor = System.Drawing.Color.Red;
						return;
					}

					// Check if the new password is the same as the old password
					if (getHash(newPassword) == storedPasswordHash)
					{
						lblMsg3.Text = "New Password cannot be the same as the Old Password.";
						lblMsg3.ForeColor = System.Drawing.Color.Red;
						return;
					}

					// Hash the new password
					string newHashedPassword = getHash(newPassword);

					// Update the password in the database
					UpdatePassword(id, newHashedPassword);

					// Display success message
					lblMsg3.Text = "Password updated successfully.";
					lblMsg3.ForeColor = System.Drawing.Color.Green;
					
				}
			}
			catch (Exception ex)
			{
				lblMsg3.Text = "Error update fail";
				lblMsg3.ForeColor = System.Drawing.Color.Red;
			

			}
		}
		private string GetStoredPasswordHash(string id)
		{

			string passwordHash = null;
			using (SqlConnection con = new SqlConnection(cs))
			{
				string sql = "SELECT password FROM Tutors WHERE id = @id";
				using (SqlCommand cmd = new SqlCommand(sql, con))
				{
					cmd.Parameters.AddWithValue("@id", id);
					con.Open();
					object result = cmd.ExecuteScalar();
					if (result != null)
					{
						passwordHash = result.ToString();
					}
				}
			}
			return passwordHash;
		}
		private void UpdatePassword(string id, string newPasswordHash)
		{
			using (SqlConnection con = new SqlConnection(cs))
			{
				string sql = "UPDATE Tutors SET password = @password WHERE id = @id";
				using (SqlCommand cmd = new SqlCommand(sql, con))
				{
					cmd.Parameters.AddWithValue("@id", id);
					cmd.Parameters.AddWithValue("@password", newPasswordHash);
					con.Open();
					cmd.ExecuteNonQuery();
				}
			}
		}
	}
}