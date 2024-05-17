using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
	public partial class DeleteStudent : System.Web.UI.Page
	{

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated)
			{
				Response.Redirect("LoginStudent.aspx");
			}
		}

		protected void Button2_Click(object sender, EventArgs e)
		{
			if (User.Identity.IsAuthenticated)
			{
				FormsAuthentication.SignOut();
				Response.Redirect("displaySuccessfulLogoutMessage.aspx");
			}
			else
			{
				Response.Redirect("LoginStudent.aspx");
			}
		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			//string email = Session["username"].ToString();
			//if (Session["username"] != null)
			/*
			if (User.Identity.IsAuthenticated)
			{
				//HttpContext ctx=HttpContext.Current;
				HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
				string encryptedTicket=authCookie.Value;
				FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
				string id = authTicket.Name;
				
				string sql = "DELETE FROM Students where id=@Email";
				string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
				SqlConnection con = new SqlConnection(cs);
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@Email", id);
				con.Open();
				int affectedRows = cmd.ExecuteNonQuery();
				con.Close();
				if (affectedRows >= 1)
					Response.Redirect("displaySuccessfulDeleteAccountMsg.aspx");
			}
			else
			{
				Response.Redirect("LoginStudent.aspx");
			}
			*/
			if (User.Identity.IsAuthenticated)
			{
				HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
				if (authCookie != null)
				{
					string encryptedTicket = authCookie.Value;
					FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
					string id = authTicket.Name;
					string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

					using (SqlConnection con = new SqlConnection(connectionString))
					{
						con.Open();
						SqlTransaction transaction = con.BeginTransaction();

						try
						{
							// Check if there are related ratings
							string checkRatingsQuery = "SELECT COUNT(*) FROM TutorRatings WHERE student_id = @id";
							using (SqlCommand checkCmd = new SqlCommand(checkRatingsQuery, con, transaction))
							{
								checkCmd.Parameters.AddWithValue("@id", id);
								int ratingCount = (int)checkCmd.ExecuteScalar();

								if (ratingCount > 0)
								{
									// Delete related ratings
									string deleteRatingsQuery = "DELETE FROM TutorRatings WHERE student_id = @id";
									using (SqlCommand deleteRatingsCmd = new SqlCommand(deleteRatingsQuery, con, transaction))
									{
										deleteRatingsCmd.Parameters.AddWithValue("@id", id);
										deleteRatingsCmd.ExecuteNonQuery();
									}
								}
							}

							// Delete tutor
							string deleteTutorQuery = "DELETE FROM Students WHERE id = @id";
							using (SqlCommand cmd = new SqlCommand(deleteTutorQuery, con, transaction))
							{
								cmd.Parameters.AddWithValue("@id", id);
								int affectedRows = cmd.ExecuteNonQuery();
								if (affectedRows >= 1)
								{
									transaction.Commit();
									Response.Redirect("displaySuccessfulDeleteAccountMsg.aspx");
								}
								else
								{
									throw new Exception("No rows affected while deleting the student.");
								}
							}
						}
						catch (Exception ex)
						{
							transaction.Rollback();
							// Log or handle the exception as needed
							Response.Write("Error: " + ex.Message);
						}
					}
				}
				else
				{
					Response.Redirect("LoginStudent.aspx");
				}
			}
			}
		}

}