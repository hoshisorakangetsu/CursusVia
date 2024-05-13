using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
	public partial class TutorRatings : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (HttpContext.Current.User.Identity.IsAuthenticated)
			{

				if (!Page.IsPostBack)
				{
					BindData();
				}
			}
			else
			{
				Response.Redirect("LoginTutor.aspx");
			}
		}

		protected void BindData()
		{
			//id = Request.QueryString["id"];
			HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
			if (authCookie != null)
			{
				FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
				string tutorId = authTicket.Name;
				//lblTutorId.Text = tutorId;
				string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

				// Define your SQL query with a parameter for id
				//string sql = "SELECT tutor_id, student_id, rating FROM TutorRatings order by tutor_id";
				//string sql = "select student_id, rating, count(rating)as rating_count from TutorRatings group by student_id,tutor_id";
				string sql = "select student_id, rating from TutorRatings where tutor_id=@tutorId";
				//string sql = "SELECT tutor_id, COUNT(*) AS rating_count FROM TutorRatings GROUP BY tutor_id ORDER BY tutor_id";

				using (SqlConnection con = new SqlConnection(cs))
				{
					SqlCommand cmd = new SqlCommand(sql, con);
					// Add the parameter to the command
					cmd.Parameters.AddWithValue("@tutorId", tutorId);
					DataTable dt = new DataTable();

					con.Open();
					// Use SqlDataReader to retrieve data
					SqlDataReader reader = cmd.ExecuteReader();

					// Load data into DataTable
					dt.Load(reader);

					// Close the connection
					con.Close();

					// Bind the DataTable to Repeater control
					Repeater1.DataSource = dt;
					Repeater1.DataBind();

				}
			}
		}
			protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
			 {
			HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

			FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
			string tutorId = authTicket.Name;
			//lblTutorId.Text = tutorId;
			string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			string selectedFilter = DropDownList1.SelectedValue;
			if (selectedFilter == "All")
			{
				BindData();

			}
			else
			{
				string sql = $"select student_id, rating from TutorRatings where tutor_id=@tutorId and rating = '{selectedFilter}'";
				using (SqlConnection con = new SqlConnection(cs))
				{
					SqlCommand da = new SqlCommand(sql, con);
					da.Parameters.AddWithValue("@tutorId", tutorId);
					con.Open();
					SqlDataReader reader = da.ExecuteReader();

					DataTable dt = new DataTable();
					dt.Load(reader);
					Repeater1.DataSource = dt;
					Repeater1.DataBind();
				}
			}
		}
    }
}