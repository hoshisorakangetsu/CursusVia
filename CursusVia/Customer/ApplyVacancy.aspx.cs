using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class ApplyVacancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT Vacancies.job_title, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description FROM Companies INNER JOIN Vacancies ON Companies.id = Vacancies.company_id WHERE Vacancies.id ='" + id + "'";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblJobTitle.Text = reader["job_title"].ToString();
                    jobtitle.Text = reader["job_title"].ToString();
                    lblCompanyName.Text = reader["name"].ToString();
                    companyName.Text = reader["name"].ToString();
                    lblArea.Text = reader["area"].ToString() + ", " + reader["state"].ToString();
                    lblMinSalary.Text = "RM" + reader["min_salary"].ToString();
                    lblMaxSalary.Text = " RM " + reader["max_Salary"].ToString() + " per month";
                    lblDepartment.Text = reader["role"].ToString();
                    lblType.Text = reader["type"].ToString();
                }
            }

            con.Close();
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            Response.Redirect("Vacancy.aspx");
        }
    }
}