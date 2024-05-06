using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Web;
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
			string email = Session["username"].ToString();
			if (Session["username"] != null)
			{
				
				string sql = "DELETE FROM Students where email=@Email";
				string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
				SqlConnection con = new SqlConnection(cs);
				SqlCommand cmd = new SqlCommand(sql, con);
				cmd.Parameters.AddWithValue("@Email", email);
				con.Open();
				cmd.ExecuteNonQuery();
				con.Close();
				Response.Redirect("displaySuccessfulDeleteAccountMsg.aspx");
			}
			else
			{
				Response.Redirect("LoginStudent.aspx");
			}
		}
	}

}