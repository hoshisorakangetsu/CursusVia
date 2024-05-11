using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace CursusVia.Customer
{
	public partial class resetPassword : System.Web.UI.Page
	{
		SqlCommand cmd;
		DataTable dt;
		SqlConnection con = new SqlConnection();
		SqlDataAdapter adp;

		protected void Page_Load(object sender, EventArgs e)
		{
			con = new SqlConnection();
			con.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			con.Open();
			if (con.State == ConnectionState.Closed)
			{
				con.Open();
			}
			try
			{
				adp = new SqlDataAdapter("select name,email,code from students where code=@code and(email=@email or name=@name )", con);
				adp.SelectCommand.Parameters.AddWithValue("@code", Request.QueryString["code"].ToString());
				adp.SelectCommand.Parameters.AddWithValue("@email", Request.QueryString["email"].ToString());
				adp.SelectCommand.Parameters.AddWithValue("@name", Request.QueryString["name"].ToString());

				dt = new DataTable();
				adp.Fill(dt);
				if (dt.Rows.Count == 0)
				{
					Pane_image.Visible = true;
					Panel_reset_pwd.Visible = false;

					return;
				}
				else
				{
					Pane_image.Visible = false;
					Panel_reset_pwd.Visible = true;

				}
			}
			catch
			{

			}
			finally
			{

			}
		}

		protected void btn_change_pwd_Click(object sender, EventArgs e)
		{
			if (con.State == ConnectionState.Closed)
			{ con.Open(); }
			try

			{
				cmd = new SqlCommand("update students set code='',pwd=@pwd where   code=@code  and (email=@email or name=@name)", con);
				cmd.Parameters.AddWithValue("@pwd", txt_pwd.Text);

				cmd.Parameters.AddWithValue("@code", Request.QueryString["code"].ToString());
				cmd.Parameters.AddWithValue("@email", Request.QueryString["email"].ToString());
				cmd.Parameters.AddWithValue("@name", Request.QueryString["name"].ToString());

				cmd.ExecuteNonQuery();
				cmd.Dispose();
				con.Close();
				lbl_msg.Text = "Your Password has been Changed successfully";
				txt_pwd.Text = "";
				txt_retype_pwd.Text = "";

			}
			catch
			{

			}
			finally
			{
				con.Close();
			}

		
	}
	}
}