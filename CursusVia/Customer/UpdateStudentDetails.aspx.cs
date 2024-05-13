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
				Response.Write("<script>alert('operation fail');window.location = 'UpdateStudentDetails.aspx';</script>");
			}
			if (name == oldName)
			{
				args.IsValid = false;
			}
			else
			{
				Response.Write("<script>alert('updated successfully');window.location = 'UpdateStudentDetails.aspx';</script>");

			

				}
			
			}
		}
	}

