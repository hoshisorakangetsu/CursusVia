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

namespace CursusVia.Tutor
{
	public partial class loginEmailOtp : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void btnRequest_Click(object sender, EventArgs e)
        {
			string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			using (SqlConnection con = new SqlConnection(CS))
			{
				con.Open();
				string sql = "select id from Tutors where email='" + txtEmail.Text + "'";
				//+ "' and is_active=1";
				SqlCommand cmd = new SqlCommand(sql, con);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.Read())
				{
					con.Close();
					Random random = new Random();
					int myRandom = random.Next(100000, 999999);
					string login_otp = myRandom.ToString();
					con.Open();
					string updateAcc = "update Tutors set login_otp='" + login_otp + "',login_otp_created='" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' where email='" + txtEmail.Text + "'";

					SqlCommand cmdUpdate = new SqlCommand(updateAcc, con);
					cmdUpdate.ExecuteNonQuery();
					con.Close();


					try
					{

						MailMessage msg = new MailMessage();
						msg.From = new MailAddress("yongyk-pp21@student.tarc.edu.my");
						msg.To.Add(txtEmail.Text.Trim());
						msg.Subject = "Login OTP (only valid for 10 min)";
						string emailBody = "<p>Dear User,</p> ";
						emailBody += "<p> Here is your login OTP: " + login_otp + "</p>";
						emailBody += "<p> Only Valid For 10 Minutes </p>";
						emailBody += "<p> <b> CursusVia Team </b></p>";

						msg.Body = emailBody;
						msg.IsBodyHtml = true;



						SmtpClient smt = new SmtpClient();
						smt.Host = "smtp.gmail.com";
						smt.Port = 587;
						smt.EnableSsl = true;
						smt.UseDefaultCredentials = false; // Don't use default credentials
						smt.Credentials = new System.Net.NetworkCredential("yongyk-pp21@student.tarc.edu.my", "030128070217");
						smt.Send(msg);

						otp.Text = "email send successfully";
						otp.ForeColor = System.Drawing.Color.Green;
					}
					catch (SmtpException ex)
					{
						// Handle SMTP exception (e.g., no internet connection, SMTP server down)
						otp.Text = "Failed to send email. Please try again later.";
						otp.ForeColor = System.Drawing.Color.Red;


					}
					catch (FormatException ex)
					{
						// Handle invalid email format exception
						otp.Text = "Invalid email address. Please enter a valid email.";
						otp.ForeColor = System.Drawing.Color.Red;

					}
					catch (Exception ex)
					{
						otp.Text = "Email send fail";
						otp.ForeColor = System.Drawing.Color.Red;

					}
				}
				else
				{
					otp.Text = "email is not registered";
					otp.ForeColor = System.Drawing.Color.Red;

				}

			}
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

			using (SqlConnection con = new SqlConnection(CS))
			{

				con.Open();
				string sql = "select login_otp, id, login_otp_created from Tutors where email='" + txtEmail.Text + "'";
				SqlCommand cmd = new SqlCommand(sql, con);
				SqlDataReader dr = cmd.ExecuteReader();
				if (dr.Read())
				{
					var start = DateTime.Now;
					string login_otp = dr["login_otp"].ToString();
					string id = dr["id"].ToString();
					string oldTimeStr = dr["login_otp_created"].ToString();
					DateTime oldTime = DateTime.Parse(oldTimeStr);
					con.Close();
					if (txtOtp.Text == login_otp && (start.Subtract(oldTime) <= TimeSpan.FromMinutes(10)))
					{

						FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
							1,
						id,
						DateTime.Now,
						DateTime.Now.AddMinutes(30),
						false,
						"Tutor"
					 );
						string encTicket = FormsAuthentication.Encrypt(ticket);
						HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket);


						Response.Cookies.Add(authCookie);
						Response.Redirect("Tutor.aspx");
					}
					else
					{
						otp.Text = "Invalid otp";
						otp.ForeColor = System.Drawing.Color.Red;

					}

				}
				else
				{
					otp.Text = "Invalid otp ";
					otp.ForeColor = System.Drawing.Color.Red;
				}
			}
		}
	}
}