using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class PayoutRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckAuthentication();
                DisplayEmpty(); 
            }
        }

        private void CheckAuthentication()
        {
            HttpCookie authCookie = Request.Cookies["AdminAuth"];
            if (authCookie == null || authCookie["LoggedIn"] != "true")
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        private void BindDataWithCurrentFilters()
        {
            using (SqlConnection con = new SqlConnection(Global.CS))
            {
                string sql = @"
                SELECT p.id, t.name, p.payout_date, p.payout_method, p.total_payout, p.status, p.withdraw_request 
                FROM Payout p 
                JOIN Tutors t ON p.tutor_id = t.id 
                WHERE 1=1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                List<SqlParameter> parameters = new List<SqlParameter>();

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue) && ddlStatus.SelectedValue != "None")
                {
                    sql += " AND p.status = @Status";
                    parameters.Add(new SqlParameter("@Status", ddlStatus.SelectedValue));
                }

                if (!string.IsNullOrEmpty(txtSearch.Text) && !string.IsNullOrEmpty(TextBox4.Text))
                {
                    sql += " AND p.payout_date BETWEEN @StartDate AND @EndDate";
                    parameters.Add(new SqlParameter("@StartDate", DateTime.Parse(txtSearch.Text)));
                    parameters.Add(new SqlParameter("@EndDate", DateTime.Parse(TextBox4.Text)));
                }

                cmd.CommandText = sql;
                cmd.Parameters.AddRange(parameters.ToArray());

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPayoutOrder.DataSource = dt;
                gvPayoutOrder.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string cs = Global.CS; // Connection string
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                string query = @"
         SELECT p.id, t.name, p.payout_date, p.payout_method, p.total_payout, p.status, p.withdraw_request 
                FROM Payout p 
                JOIN Tutors t ON p.tutor_id = t.id 
        WHERE 
            p.id LIKE @SearchTerm  OR p.payout_method LIKE @SearchTerm  OR t.name LIKE @SearchTerm
            OR p.status LIKE  @SearchTerm  
            OR  p.payout_date LIKE @SearchTerm  
            OR  p.total_payout LIKE @SearchTerm";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SearchTerm", '%' + txtSearch.Text + '%'); // Use parameters to prevent SQL injection

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvPayoutOrder.DataSource = dt;
                gvPayoutOrder.DataBind();
            }
        }


        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindDataWithCurrentFilters();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            txtSearch.Text = "";
            TextBox4.Text = "";
            BindDataWithCurrentFilters(); // Reset the data view based on no filters.
        }

        protected void btnToday_Click(object sender, EventArgs e)
        {
            txtSearch.Text = DateTime.Today.ToString("yyyy-MM-dd");
            TextBox4.Text = DateTime.Today.ToString("yyyy-MM-dd");
            BindDataWithCurrentFilters();
        }

        private void DisplayEmpty()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("id", typeof(int));
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("payout_date", typeof(DateTime));
            dt.Columns.Add("payout_method", typeof(string));
            dt.Columns.Add("total_payout", typeof(decimal));
            dt.Columns.Add("status", typeof(string));
            dt.Columns.Add("withdraw_request", typeof(int));

            dt.Rows.Add(dt.NewRow()); 
            gvPayoutOrder.DataSource = dt;
            gvPayoutOrder.DataBind();
            gvPayoutOrder.Rows[0].Visible = false; // Hide the dummy row
        }
    }
}
