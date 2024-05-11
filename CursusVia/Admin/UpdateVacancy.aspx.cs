using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class UpdateVacancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            backLink.NavigateUrl = "ViewVacancy.aspx?id="+id;
            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string read = "SELECT Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area, Vacancies.job_title, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description, Vacancies.company_id, Vacancies.email FROM Companies INNER JOIN Vacancies ON Companies.id = Vacancies.company_id WHERE Vacancies.id ='" + id + "'";

                con.Open();

                SqlCommand cmd = new SqlCommand(read, con);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        txtSearch.Text = reader["job_title"].ToString();
                        if (reader["type"].ToString().Equals("Full Time"))
                            ddlJobType.SelectedIndex = 0;
                        else
                            ddlJobType.SelectedIndex = 1;
                        txtMinSalary.Text = reader["min_salary"].ToString();
                        txtMaxSalary.Text = reader["max_salary"].ToString();
                        txtRoleDepartment.Text = reader["role"].ToString();
                        txtJobReq.Text = reader["job_requirement"].ToString();
                        txtJobDescr.Text = reader["job_description"].ToString();
                        txtCompanyName.Text = reader["name"].ToString();
                        txtCompanyAddress.Text = reader["address"].ToString();
                        txtCompanyArea.Text = reader["area"].ToString();
                        txtCompanyPostcode.Text = reader["postcode"].ToString();
                        txtCompanyState.Text = reader["state"].ToString();
                        txtHRemail.Text = reader["email"].ToString();
                    }
                }
                con.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            int row=0;
            con.Open();

            //identify the company id that associated to the job
            string selectQuery = "SELECT Vacancies.company_id FROM Vacancies WHERE Vacancies.id ='" + Request.QueryString["id"] + "'";
            SqlCommand cmd = new SqlCommand(selectQuery, con);
            //get the company id
            var companyID = cmd.ExecuteScalar();

            //check is the updated company name is inside the table?
            string companies = "SELECT [id], [name], [address], [postcode], [state], [area] FROM [dbo].[Companies] WHERE [name] = @CompanyName";
            SqlCommand company = new SqlCommand(companies, con);
            company.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text);
            //get exist or not exist
            var companyExist = company.ExecuteScalar();
            //if not exist then add
            if (companyExist == null)
            {
                string sqlCompany = "INSERT INTO [dbo].[Companies] ([name], [address], [postcode], [state], [area]) VALUES (@Name, @Address, @Postcode, @State, @Area)";
                SqlCommand insertCompany = new SqlCommand(sqlCompany, con);

                insertCompany.Parameters.AddWithValue("@Name", txtCompanyName.Text);
                insertCompany.Parameters.AddWithValue("@Address", txtCompanyAddress.Text);
                insertCompany.Parameters.AddWithValue("@Postcode", txtCompanyPostcode.Text);
                insertCompany.Parameters.AddWithValue("@State", txtCompanyState.Text);
                insertCompany.Parameters.AddWithValue("@Area", txtCompanyArea.Text);

                insertCompany.ExecuteNonQuery();

                companyID = company.ExecuteScalar();
            }
            else
            {
                //if company exist then directly update
                string update = "UPDATE [dbo].[Companies] SET [name] = @Name, [address] = @Address, [postcode] = @Postcode, [state] = @State, [area] = @Area WHERE [id] = @id";
                SqlCommand updateCompany = new SqlCommand(update, con);

                updateCompany.Parameters.AddWithValue("@Name", txtCompanyName.Text);
                updateCompany.Parameters.AddWithValue("@Address", txtCompanyAddress.Text);
                updateCompany.Parameters.AddWithValue("@Postcode", txtCompanyPostcode.Text);
                updateCompany.Parameters.AddWithValue("@State", txtCompanyState.Text);
                updateCompany.Parameters.AddWithValue("@Area", txtCompanyArea.Text);
                updateCompany.Parameters.AddWithValue("@id", Convert.ToInt32(companyID));

                row = updateCompany.ExecuteNonQuery();

                companyID = cmd.ExecuteScalar();
            }
            //update job details
            string updateJob = "UPDATE [dbo].[Vacancies] SET [job_title]=@JobTitle, [min_salary]=@MinSalary, [max_salary]=@MaxSalary, [type]=@Type, [role]=@Role, [job_requirement]=@JobRequirement, [job_description]=@JobDescription, [company_id]=@CompanyId, [email]=@Email WHERE [id] ='" + Request.QueryString["id"] + "'";

            SqlCommand insertJob = new SqlCommand(updateJob, con);
            insertJob.Parameters.AddWithValue("@JobTitle", txtSearch.Text);
            insertJob.Parameters.AddWithValue("@MinSalary", Convert.ToDouble(txtMinSalary.Text));
            insertJob.Parameters.AddWithValue("@MaxSalary", Convert.ToDouble(txtMaxSalary.Text));
            insertJob.Parameters.AddWithValue("@Type", ddlJobType.SelectedItem.Text);
            insertJob.Parameters.AddWithValue("@Role", txtRoleDepartment.Text);
            insertJob.Parameters.AddWithValue("@JobRequirement", txtJobReq.Text);
            insertJob.Parameters.AddWithValue("@JobDescription", txtJobDescr.Text);
            insertJob.Parameters.AddWithValue("@CompanyId", Convert.ToInt32(companyID));
            insertJob.Parameters.AddWithValue("@Email", txtHRemail.Text);

            row += insertJob.ExecuteNonQuery();

            if (row > 0)
            {
                Response.Write("<script>alert('Job update successfully');window.location = 'Vacancy.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Job does not update');window.location = 'Vacancy.aspx';</script>");
            }

            con.Close();
        }
    }
}