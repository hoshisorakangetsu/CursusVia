using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class Vacancy2 : System.Web.UI.Page
    {
        private string studentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            //newRequestLink.NavigateUrl = "SearchVacancy.aspx?id="+studentId;
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }
            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(studentId)) { studentId = "1"; }

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);
                con.Open();
                string select = "SELECT JobApplications.expecred_salary, Vacancies.job_title, Companies.name FROM Vacancies INNER JOIN JobApplications ON Vacancies.id = JobApplications.vacancy_id INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE JobApplications.student_id = @sID";
                
                SqlDataAdapter adapter = new SqlDataAdapter(select, con);

                adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);
                GridView1.DataSource=dataSet;
                GridView1.DataBind();
                con.Close();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT JobApplications.expecred_salary, Vacancies.job_title, Companies.name FROM Vacancies INNER JOIN JobApplications ON Vacancies.id = JobApplications.vacancy_id INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE JobApplications.student_id = @sID AND  Vacancies.job_title LIKE @Title";

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
            adapter.SelectCommand.Parameters.AddWithValue("@Title", "%" + txtRequestTitle.Text + "%");
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            GridView1.DataSource=dataSet;
            GridView1.DataBind();
            con.Close();
        }
    }
}