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

		}

        protected void Button1_Click(object sender, EventArgs e)
        {
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
