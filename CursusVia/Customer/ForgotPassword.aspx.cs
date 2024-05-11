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
using System.Data;
using System.Xml;



namespace CursusVia.Customer
{
	public partial class ForgotPassword : System.Web.UI.Page
	{
		SqlCommand cmd;
		DataTable dt;
		SqlConnection con = new SqlConnection();
		SqlDataAdapter adp;

		protected void Page_Load(object sender, EventArgs e)
		{
			con = new SqlConnection();
			con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			con.Open();
			if (con.State == ConnectionState.Closed)
			{
				con.Open();
			}

		}



		protected void Button1_Click(object sender, EventArgs e)
		{
			if (con.State == ConnectionState.Closed)
			{ con.Open(); }
			try
			{
				adp = new SqlDataAdapter("select name,email from students where email=@email or name=@name", con);
				adp.SelectCommand.Parameters.AddWithValue("@email", txtEmail.Text);
				adp.SelectCommand.Parameters.AddWithValue("@name", txtName.Text);

				dt = new DataTable();
				adp.Fill(dt);
				if (dt.Rows.Count == 0)
				{
					lblMsg.Text = "Enter valid email address or uname";
					txtEmail.Text = "";
					txtName.Text = "";
					return;
				}
				else
				{
					string code;
					code = Guid.NewGuid().ToString();
					cmd = new SqlCommand("update students set code=@code where  email=@email or name=@name", con);
					cmd.Parameters.AddWithValue("@code", code);
					cmd.Parameters.AddWithValue("@email", txtEmail.Text);
					cmd.Parameters.AddWithValue("@name", txtName.Text);
					StringBuilder sbody = new StringBuilder();
					//sbody.Append("<a href=http://usingasp.net/reset_pwd.aspx?email=" + txtEmail.Text);
					//sbody.Append("&code=" + code + "&uname=" + txtName.Text + ">Click here to change your password</a>");
					//	string resetUrl = "/resetPassword.aspx" +
					//  "?email=" + HttpUtility.UrlEncode(txtEmail.Text) +
					//  "&code=" + HttpUtility.UrlEncode(code) +
					//  "&name=" + HttpUtility.UrlEncode(txtName.Text);
					// Construct the password reset URL with necessary query parameters
					//string resetUrl = "http://localhost/WebApplication1/Registration/ChangePassword.aspx?uid=" + code;

					// Append the constructed URL to the email body
		//	sbody.Append("<a href=\"" + resetUrl + "\">Click here to reset your password</a>");

				//	sbody.Append("<a href=https://localhost:44383/C:/CursusVia/Customer/resetPassword.aspx?email=" + txtEmail.Text);


					//sbody.Append("&code=" + code + "&uname=" + txtName.Text + ">Click here to change your password</a>");

					sbody.Append("<a href=https://localhost:44383/C:/CursusVia/Customer/resetPassword.aspx?email=" + HttpUtility.UrlEncode(txtEmail.Text));
					sbody.Append("&code=" + HttpUtility.UrlEncode(code) + "&name=" + HttpUtility.UrlEncode(txtName.Text) + ">Click here to change your password</a>");

					// Append the constructed URL to the email body
					//	sbody.Append("<a href=\"" + resetUrl + "\">Click here to reset your password</a>");
					// Update the sender's email address with a valid one
					string senderEmail = "yongyk-pp21@student.tarc.edu.my"; // Update with a valid sender email address
					string recipientEmail = dt.Rows[0]["email"].ToString().Trim(); // Retrieve recipient's email address from the database

					// Check if the recipient's email address is empty or invalid
					if (string.IsNullOrWhiteSpace(recipientEmail))
					{
						lblMsg.Text = "Recipient's email address is empty or invalid.";
						return;
					}

					// Create the MailMessage object with sender and recipient email addresses
					System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage(senderEmail, recipientEmail, "Reset Your Password", sbody.ToString());

					// Update SMTP server settings as needed
					System.Net.Mail.SmtpClient mailclient = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587); // Update SMTP server details as necessary
					mailclient.EnableSsl = true;
					System.Net.NetworkCredential mailAuthenticaion = new System.Net.NetworkCredential("yongyk-pp21@student.tarc.edu.my", "030128070217"); // Update with your actual Gmail username and password
					mailclient.Credentials = mailAuthenticaion;
					mail.IsBodyHtml = true;
					mailclient.Send(mail);
					cmd.ExecuteNonQuery();
					cmd.Dispose();
					con.Close();
					lblMsg.Text = "Link has been sent to your email address";
					txtEmail.Text = "";
					txtName.Text = "";

				}

			}
			catch (Exception ex)
			{
				// if there will be any error created at the time of the sending mail then it goes inside the catch
				//and display the error in the label
				lblMsg.Text = ex.Message;
			}
			finally
			{
				con.Close();
			}

		}
	}
}
