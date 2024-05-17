using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
	public partial class DeleteTutor : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated)
			{
				Response.Redirect("LoginTutor.aspx");
			}
		}

        protected void Button1_Click(object sender, EventArgs e)
        {
			/*
			if (User.Identity.IsAuthenticated)
			{
				//HttpContext ctx=HttpContext.Current;
				HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
				string encryptedTicket = authCookie.Value;
				FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
				string id = authTicket.Name;

				string sql = "DELETE FROM Tutors where id=@id";
				string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
				SqlConnection con = new SqlConnection(cs);
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@id", id);
				con.Open();
				int affectedRows = cmd.ExecuteNonQuery();
				con.Close();
				if (affectedRows >= 1)
					Response.Redirect("deleteMsg.aspx");
			}
			else
			{
				Response.Redirect("LoginTutor.aspx");
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
							string checkRatingsQuery = "SELECT COUNT(*) FROM TutorRatings WHERE tutor_id = @id";
							using (SqlCommand checkCmd = new SqlCommand(checkRatingsQuery, con, transaction))
							{
								checkCmd.Parameters.AddWithValue("@id", id);
								int ratingCount = (int)checkCmd.ExecuteScalar();

								if (ratingCount > 0)
								{
									// Delete related ratings
									string deleteRatingsQuery = "DELETE FROM TutorRatings WHERE tutor_id = @id";
									using (SqlCommand deleteRatingsCmd = new SqlCommand(deleteRatingsQuery, con, transaction))
									{
										deleteRatingsCmd.Parameters.AddWithValue("@id", id);
										deleteRatingsCmd.ExecuteNonQuery();
									}
								}
							}

							// Delete tutor
							string deleteTutorQuery = "DELETE FROM Tutors WHERE id = @id";
							using (SqlCommand cmd = new SqlCommand(deleteTutorQuery, con, transaction))
							{
								cmd.Parameters.AddWithValue("@id", id);
								int affectedRows = cmd.ExecuteNonQuery();
								if (affectedRows >= 1)
								{
									transaction.Commit();
									Response.Redirect("deleteMsg.aspx");
								}
								else
								{
									throw new Exception("No rows affected while deleting the tutor.");
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
					Response.Redirect("LoginTutor.aspx");
				}

			}
		}

		protected void Button2_Click(object sender, EventArgs e)
		{

			if (User.Identity.IsAuthenticated)
			{
				FormsAuthentication.SignOut();
				Response.Redirect("logoutMsg.aspx");
			}
			else
			{
				Response.Redirect("LoginTutor.aspx");
			}
		}
		}
	}
