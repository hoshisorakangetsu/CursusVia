using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CursusVia.Tutor
{
	public partial class UpdateDetailsTutor : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				//string email = Session["username"].ToString();
				//if (Session["username"] != null)
				if (User.Identity.IsAuthenticated)
				{
					HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
					string encryptedTicket = authCookie.Value;
					FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
					string id = authTicket.Name;
					string sql = "SELECT email,name, qualifications from Tutors WHERE id=@id";
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
						ddlQualification.SelectedValue = (string)dr["qualifications"];

					}

					con.Close();

					if (!found)
					{
						Response.Redirect("LoginTutor.aspx");
					}
				}
				else
				{
					Response.Redirect("LoginTutor.aspx");
				}
			}
		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			if (Page.IsValid)
			{
				try
				{


					HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
					string encryptedTicket = authCookie.Value;
					FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
					string id = authTicket.Name;
					string name = txtName.Text;
					string qualifications = ddlQualification.SelectedValue;
					string email = lblEmail.Text;
					string sql = "UPDATE Tutors SET name = @Name, qualifications=@qualifications WHERE id=@id ";
					string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;


					SqlConnection con = new SqlConnection(cs);
					SqlCommand cmd = new SqlCommand(sql, con);
					cmd.Parameters.AddWithValue("@Name", name);
					cmd.Parameters.AddWithValue("@Email", email);
					cmd.Parameters.AddWithValue("@id", id);
					cmd.Parameters.AddWithValue("@qualifications", qualifications);

					con.Open();
					cmd.ExecuteNonQuery();
					con.Close();
					Response.Write("<script>alert('updated successfully');window.location = 'UpdateDetailsTutor.aspx';</script>");


				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('operation fail');window.location = 'UpdateDetailsTutor.aspx';</script>");
				}
			}
		}

		protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string name = txtName.Text;
			string qualifications = ddlQualification.SelectedValue;


			string email = lblEmail.Text;
			HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
			string encryptedTicket = authCookie.Value;
			FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
			string id = authTicket.Name;
			string sql = "SELECT name, qualifications from Tutors WHERE id=@id";
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

			SqlConnection con = new SqlConnection(cs);
			SqlCommand cmd = new SqlCommand(sql, con);
			cmd.Parameters.AddWithValue("@id", id);
			con.Open();
			SqlDataReader dr = cmd.ExecuteReader();
			bool found = false;
			string oldName = "";
			string oldQualifications = "";
			while (dr.Read())
			{
				//NOTE: When you cast from obj type to string --> type(string)
				found = true;
				oldName = dr["name"].ToString();
				oldQualifications = dr["qualifications"].ToString();
			}

			con.Close();
			if (!found)
			{
				Response.Write("<script>alert('operation fail');window.location = 'UpdateDetailsTutor.aspx';</script>");
			}


			if (name == oldName && qualifications == oldQualifications)
			{
				args.IsValid = false;

			}
			//else
			//{
			//	lblMsg.Text = "updated successfully";

			//	}

		}
	}
}