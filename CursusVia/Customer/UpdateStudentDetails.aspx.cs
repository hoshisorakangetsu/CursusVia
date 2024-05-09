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
					string email = authTicket.UserData;
					string sql = "SELECT email,name from Students WHERE email=@email";
					string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

					SqlConnection con = new SqlConnection(cs);
					SqlCommand cmd = new SqlCommand(sql, con);
					cmd.Parameters.AddWithValue("@email", email);
					con.Open();
					SqlDataReader dr = cmd.ExecuteReader();
					
					bool found = false;
					while (dr.Read())
					{
						//NOTE: When you cast from obj type to string --> type(string)
						found = true;
						txtEmail.Text = (string)dr["email"];
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
			string email = authTicket.UserData;         //string email = Session["username"].ToString();
			string name = txtName.Text;
			//string updatedEmail = "";
			//string updatedName = "";

			string sql = "UPDATE Students SET name = @Name,email=@Email  WHERE email=@Email ";
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;


			SqlConnection con = new SqlConnection(cs);
			SqlCommand cmd = new SqlCommand(sql, con);
			cmd.Parameters.AddWithValue("@Name", name);
			cmd.Parameters.AddWithValue("@Email", email);
			con.Open();
			cmd.ExecuteNonQuery();
			con.Close();
			if (!string.IsNullOrEmpty(email))
			{
				MailMessage msg = new MailMessage();
				msg.From = new MailAddress("yongyk-pp21@student.tarc.edu.my");
				msg.To.Add(txtEmail.Text);
				msg.Subject = "ere is your updated details";
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
			}

		}
	}
}
