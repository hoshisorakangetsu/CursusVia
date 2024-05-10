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

		}

		protected void Button2_Click(object sender, EventArgs e)
		{
			Response.Redirect("displaySuccessfulLogoutMessage.aspx");
		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			//string email = Session["username"].ToString();
			//if (Session["username"] != null)
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
		}
	}

}