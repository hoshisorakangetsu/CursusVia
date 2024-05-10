using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
	public partial class UpdateStudentDetails : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				//string email = Session["username"].ToString();
				//if (Session["username"] != null)
				if(User.Identity.IsAuthenticated)
				{
					HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
					string encryptedTicket = authCookie.Value;
					FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
					string id = authTicket.Name;
					string sql = "SELECT email,name from Students WHERE id=@id";
					string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

					SqlConnection con = new SqlConnection(cs);
					SqlCommand cmd = new SqlCommand(sql, con);
					cmd.Parameters.AddWithValue("@id", id);
					con.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					
					bool found = false;
					while (dr.Read())
					{
						//NOTE: When you cast from obj type to string --> type(string)
						found = true;
						lblEmail.Text = (string)dr["email"];
						txtName.Text = (string)dr["name"];
					}
					
					con.Close();
					
					if (!found)
					{
						Response.Redirect("Student.aspx");
					}
					

				}else
				{
					Response.Redirect("LoginStudent.aspx");
				}
			}
		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
			string encryptedTicket = authCookie.Value;
			FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
			string id = authTicket.Name;         //string email = Session["username"].ToString();
			string name = txtName.Text;
			//string updatedEmail = "";
			//string updatedName = "";
			string email = lblEmail.Text;
			string sql = "UPDATE Students SET name = @Name,email=@Email  WHERE id=@id ";
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;


			SqlConnection con = new SqlConnection(cs);
			SqlCommand cmd = new SqlCommand(sql, con);
			cmd.Parameters.AddWithValue("@Name", name);
			cmd.Parameters.AddWithValue("@Email", email);
			cmd.Parameters.AddWithValue("@id", id);

			con.Open();
			cmd.ExecuteNonQuery();
			con.Close();
			/*
			if (!string.IsNullOrEmpty(id))
			{
				MailMessage msg = new MailMessage();
				msg.From = new MailAddress("yongyk-pp21@student.tarc.edu.my");
				msg.To.Add(lblEmail.Text);
				msg.Subject = "Here is your updated details";
				msg.Body = "Your new Email is: " + email;
				msg.Body = "Your new Name is: " + name;

				msg.IsBodyHtml = true;

				SmtpClient smt = new SmtpClient();
				smt.Host = "smtp.gmail.com";
				smt.Port = 587;
				smt.EnableSsl = true;
				smt.UseDefaultCredentials = false; // Don't use default credentials
				smt.Credentials = new System.Net.NetworkCredential("yongyk-pp21@student.tarc.edu.my", "030128070217");
				//smt.Credentials = new NetworkCredential("your_email@gmail.com", "your_password"); // Provide valid credentials here

				smt.Send(msg);
				lblMsg.Text = "Updated Successfully";
				lblMsg.ForeColor = System.Drawing.Color.ForestGreen;
			
			}*/

		}

		protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string name=txtName.Text;
			string email=lblEmail.Text;
			HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
			string encryptedTicket = authCookie.Value;
			FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
			string id = authTicket.Name;
			string sql = "SELECT name from Students WHERE id=@id";
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

			SqlConnection con = new SqlConnection(cs);
			SqlCommand cmd = new SqlCommand(sql, con);
			cmd.Parameters.AddWithValue("@id", id);
			con.Open();
			SqlDataReader dr = cmd.ExecuteReader();
			bool found = false;
			string oldName = "";
			while (dr.Read())
			{
				//NOTE: When you cast from obj type to string --> type(string)
				found = true;
				oldName = dr["name"].ToString();
			}

			con.Close();
			if (!found)
			{
				lblMsg.Text = "update failed ";
			}
			if (name == oldName)
			{
				args.IsValid = false;
				lblMsg.Text = " Update fail due to no updated information";
			}
			else
			{
				try
				{
					MailMessage msg = new MailMessage();
					msg.From = new MailAddress("yongyk-pp21@student.tarc.edu.my");
					msg.To.Add(lblEmail.Text);
					msg.Subject = "Here is your updated details";
					msg.Body = "Your new Email is: " + email;
					msg.Body = "Your new Name is: " + name;

					msg.IsBodyHtml = true;

					SmtpClient smt = new SmtpClient();
					smt.Host = "smtp.gmail.com";
					smt.Port = 587;
					smt.EnableSsl = true;
					smt.UseDefaultCredentials = false; // Don't use default credentials
					smt.Credentials = new System.Net.NetworkCredential("yongyk-pp21@student.tarc.edu.my", "030128070217");
					//smt.Credentials = new NetworkCredential("your_email@gmail.com", "your_password"); // Provide valid credentials here

					smt.Send(msg);
					lblMsg.Text = "Updated Successfully";
					lblMsg.ForeColor = System.Drawing.Color.ForestGreen;
					lblMsg2.Text = "An email will be send ";
					lblMsg2.ForeColor = System.Drawing.Color.ForestGreen;

				}
				catch (SmtpException ex)
				{
					// Handle SMTP exception (e.g., no internet connection, SMTP server down)
					lblMsg.Text = "Failed to send email. Please try again later.";
					lblMsg.ForeColor = System.Drawing.Color.Red;
					lblMsg2.Text = "updated successfully";
					lblMsg2.ForeColor = System.Drawing.Color.ForestGreen;

				}
				catch (FormatException ex)
				{
					// Handle invalid email format exception
					lblMsg.Text = "Invalid email address. Please enter a valid email.";
					lblMsg.ForeColor = System.Drawing.Color.Red;
					lblMsg2.Text = "updated successfully";
					lblMsg2.ForeColor = System.Drawing.Color.ForestGreen;
				}
				catch (Exception ex)
				{
					// Handle other exceptions
					lblMsg.Text = "An error occurred. Please try again later.";
					lblMsg.ForeColor = System.Drawing.Color.Red;
				}
			}
		}
	}
}
