﻿using System;
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
using System.Net.Mail;

namespace CursusVia.Customer
{
	public partial class RegisterStudent : System.Web.UI.Page
	{
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

		protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string email = args.Value;
			string sql = "SELECT COUNT(*) FROM Students WHERE email = @email";
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

			SqlConnection con = new SqlConnection(cs);

			SqlCommand cmd = new SqlCommand(sql, con);

			cmd.Parameters.AddWithValue("@email", email);

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
		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			if (Page.IsValid)
			{

				try
				{
					string CS = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
					using (SqlConnection con = new SqlConnection(CS))
					{
						string sql = "INSERT INTO Students (email, password, name)" + "VALUES (@email,@password,@name)  ";
						SqlCommand cmd = new SqlCommand(sql, con);
						cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
						cmd.Parameters.AddWithValue("@password", getHash(txtPass.Text.Trim()));
						cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());

						con.Open();
						int count = cmd.ExecuteNonQuery();
						con.Close();

						if (count > 0)
						{

							lblMessage.Text = "You have registered succussfully";
							lblMessage.ForeColor = System.Drawing.Color.Green;
							string script = @"<script type='text/javascript'>
                        setTimeout(function(){
                            window.location.href = 'LoginStudent.aspx';
                        }, 2000); // 2 seconds delay
                    </script>";

							ClientScript.RegisterStartupScript(this.GetType(), "redirect", script);
							//Response.Redirect("LoginStudent.aspx");
							try
							{

								MailMessage msg = new MailMessage();
								msg.From = new MailAddress("yongyk-pp21@student.tarc.edu.my");
								msg.To.Add(txtEmail.Text.Trim());
								msg.Subject = "You have Successfully created a new account";
								string emailBody = "<p><b>Dear  " + txtName.Text + ",</b></p>";
								emailBody += " <p> You have successfully created a new account with us at " + DateTime.Now + " .</p>";
								emailBody += "<p> Thank you for creating a new account </p>";
								emailBody += "<p> <b> Cursus Via Team </b> </p>";

								msg.Body = emailBody;
								msg.IsBodyHtml = true;



								SmtpClient smt = new SmtpClient();
								smt.Host = "smtp.gmail.com";
								smt.Port = 587;
								smt.EnableSsl = true;
								smt.UseDefaultCredentials = false; // Don't use default credentials
								smt.Credentials = new System.Net.NetworkCredential("yongyk-pp21@student.tarc.edu.my", "030128070217");
								smt.Send(msg);


							}
							catch (SmtpException ex)
							{
								// Handle SMTP exception (e.g., no internet connection, SMTP server down)
								
							}
							catch (FormatException ex)
							{
								// Handle invalid email format exception
								
								
							}
							catch (Exception ex)
							{
								

							}
						}
					

					}
				}

				catch (Exception)
				{
					if (!Page.IsValid)
					{
						lblMessage.Text = "Validation failed. Please correct the errors.";
						lblMessage.ForeColor = System.Drawing.Color.Red;
					}
					else
					{
						lblMessage.Text = "You have not registered";
						lblMessage.ForeColor = System.Drawing.Color.Red;

					}

				}
			}



			}

			

			



		
	}
}



	
	
