using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class SupportRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GridView1.DataSource = SqlDataSource1;
                GridView1.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT[id], [title], [date_send], [status] FROM[SupportRequests] WHERE title LIKE @Name";

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            adapter.SelectCommand.Parameters.AddWithValue("@Name", "%" + txtRequestTitle.Text + "%");
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            GridView1.DataSource=dataSet;
            GridView1.DataBind();
            con.Close();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            bool isStatus = false;
            bool isStart = false;
            bool isEnd = false;
            string end = "";

            if (!ddlStatus.SelectedValue.Equals("None"))
                isStatus = true;
            if (txtStart.Text.Length > 0)
                isStart = true;
            if (txtEnd.Text.Length > 0)
            {
                DateTime date = Convert.ToDateTime(this.txtEnd.Text);
                date = date.AddDays(1);
                end = date.ToString("yyyy-MM-dd");
                isEnd = true;
            }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            string query;

            //default query
            query = "SELECT[id], [title], [date_send], [status] FROM [SupportRequests] WHERE";
            if (isStatus)
                query = String.Concat(query, " [status] = @Type AND");
            if (isStart)
                query = String.Concat(query, " [date_send] >= @Start AND");
            if (isEnd)
                query = String.Concat(query, " [date_send] <= @End AND");

            //remove the AND and space
            query = query.Remove(query.Length - 4);

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            adapter.SelectCommand.Parameters.AddWithValue("@Type", ddlStatus.SelectedValue);
            adapter.SelectCommand.Parameters.AddWithValue("@Start", txtStart.Text);
            adapter.SelectCommand.Parameters.AddWithValue("@End", end);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            GridView1.DataSource=dataSet;
            GridView1.DataBind();
            con.Close();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
            ddlStatus.SelectedIndex = 0;
            txtStart.Text="";
            txtEnd.Text="";
        }

        protected void btnToday_Click(object sender, EventArgs e)
        {
            DateTime dt = DateTime.Now;
            txtStart.Text = dt.ToString("yyyy-MM-dd");
            txtEnd.Text = dt.ToString("yyyy-MM-dd");
        }
    }
}