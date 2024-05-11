using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class Vacancy1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string sql = "SELECT Vacancies.id, Vacancies.job_title, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description, Vacancies.email, Vacancies.company_id, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(sql, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }
    }
}