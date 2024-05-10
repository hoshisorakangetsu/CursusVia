using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class Vacancy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT Vacancies.id, Vacancies.job_title, Companies.name FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE Vacancies.job_title LIKE '%" + txtJobTitle.Text + "%'";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            GridView1.DataSource=dataSet;
            GridView1.DataBind();
            con.Close();
        }
    }
}