using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class DeleteVacancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT Vacancies.job_title, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description FROM Companies INNER JOIN Vacancies ON Companies.id = Vacancies.company_id WHERE Vacancies.id = @ID";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            cmd.Parameters.AddWithValue("@ID", id);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblJobTitle.Text = reader["job_title"].ToString();
                    lblCompanyName.Text = reader["name"].ToString();
                    lblArea.Text = reader["area"].ToString() + ", " + reader["state"].ToString();
                    lblMinSalary.Text = "RM" + reader["min_salary"].ToString();
                    lblMaxSalary.Text = " RM " + reader["max_Salary"].ToString() + " per month";
                    lblDepartment.Text = reader["role"].ToString();
                    lblType.Text = reader["type"].ToString();
                    lblDescr.Text = reader["job_description"].ToString();
                    lblRequirement.Text = reader["job_requirement"].ToString();
                    lblAddress.Text = reader["address"].ToString()+", "+reader["postcode"].ToString()+", "+reader["area"].ToString() + ", " + reader["state"].ToString();
                }
            }

            con.Close();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string delete = "DELETE FROM [dbo].[Vacancies] WHERE [id] = '" + Request.QueryString["id"] + "'";
            con.Open();

            SqlCommand drop = new SqlCommand(delete, con);
            drop.ExecuteNonQuery();
            con.Close();

            Response.Write("<script>alert('Job deleted successfully');window.location = 'Vacancy.aspx';</script>");
        }
    }
}