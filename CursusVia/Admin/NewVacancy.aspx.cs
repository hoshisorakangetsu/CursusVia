using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class NewVacancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(cs);

            con.Open();
            string selectQuery = "SELECT [id], [name], [address], [postcode], [state], [area] FROM [dbo].[Companies] WHERE [name] = @CompanyName";
            SqlCommand cmd = new SqlCommand(selectQuery, con);
            cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text);

            var companyID = cmd.ExecuteScalar();

            if (companyID == null) 
            {
                string sqlCompany = "INSERT INTO [dbo].[Companies] ([name], [address], [postcode], [state], [area]) VALUES (@Name, @Address, @Postcode, @State, @Area)";
                SqlCommand insertCompany = new SqlCommand(sqlCompany, con);

                insertCompany.Parameters.AddWithValue("@Name", txtCompanyName.Text);
                insertCompany.Parameters.AddWithValue("@Address", txtCompanyAddress.Text);
                insertCompany.Parameters.AddWithValue("@Postcode", txtCompanyPostcode.Text);
                insertCompany.Parameters.AddWithValue("@State", txtCompanyState.Text);
                insertCompany.Parameters.AddWithValue("@Area", txtCompanyArea.Text);

                insertCompany.ExecuteNonQuery();

                companyID = cmd.ExecuteScalar();
            }
            
            string sqlJob = "INSERT INTO [dbo].[Vacancies] ([job_title], [min_salary], [max_salary], [type], [role], [job_requirement], [job_description], [company_id], [email]) VALUES ( @JobTitle, @MinSalary, @MaxSalary, @Type, @Role, @JobRequirement, @JobDescription, @CompanyId, @Email)";
            SqlCommand insertJob = new SqlCommand(sqlJob, con);
            insertJob.Parameters.AddWithValue("@JobTitle", txtSearch.Text);
            insertJob.Parameters.AddWithValue("@MinSalary", Convert.ToDouble(txtMinSalary.Text));
            insertJob.Parameters.AddWithValue("@MaxSalary", Convert.ToDouble(txtMaxSalary.Text));
            insertJob.Parameters.AddWithValue("@Type", ddlJobType.SelectedItem.Text);
            insertJob.Parameters.AddWithValue("@Role", txtRoleDepartment.Text);
            insertJob.Parameters.AddWithValue("@JobRequirement", txtJobReq.Text);
            insertJob.Parameters.AddWithValue("@JobDescription", txtJobDescr.Text);
            insertJob.Parameters.AddWithValue("@CompanyId", Convert.ToInt32(companyID));
            insertJob.Parameters.AddWithValue("@Email", txtHRemail.Text);

            int row = insertJob.ExecuteNonQuery();

            if (row > 0)
            {
               Response.Write("<script>alert('Job inserted successfully');window.location = 'Vacancy.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Job does not inserted successfully');window.location = 'Vacancy.aspx';</script>");
            }

            con.Close();
        }
    }
}