using CursusVia.Customer;
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
        private string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

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
            con.Open(); 
            string select = "SELECT vacancy_id FROM JobApplications WHERE vacancy_id = @ID";
            SqlCommand cmd = new SqlCommand(select, con);
            cmd.Parameters.AddWithValue("@ID", id);
            int row = cmd.ExecuteNonQuery();
            con.Close();

            if (row > 0)
            {
                Session["toast"] = new Toast("Selected job cannot be deleted", "fail");
                Response.Redirect("Vacancy.aspx");
            }
            else
            {
                string delete = "DELETE FROM [dbo].[Vacancies] WHERE [id] = @ID";
                con.Open();

                SqlCommand drop = new SqlCommand(delete, con);

                drop.Parameters.AddWithValue("@ID", id);
                drop.ExecuteNonQuery();
                con.Close();

                Session["toast"] = new Toast("Job deleted successfully", "success");
                Response.Redirect("Vacancy.aspx");

                //Response.Write("<script>alert('Job deleted successfully');window.location = 'Vacancy.aspx';</script>");
            }
        }
    }
}