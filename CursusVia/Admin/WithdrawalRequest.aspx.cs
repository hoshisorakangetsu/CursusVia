using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class WithdrawalRequest : System.Web.UI.Page
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
                Response.Redirect("AdminAccount.aspx");
                return;
            }
        }



       
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string cs = Global.CS; 
            using (SqlConnection con = new SqlConnection(cs))
            {
                
                string query = @"
            SELECT w.id, w.withdraw_amount, w.request_date, w.status, w.account_number, t.name, t.balance 
            FROM WithdrawalRequests w 
            JOIN Tutors t ON w.tutor_id = t.id 
            WHERE t.name LIKE @SearchTerm OR w.status LIKE @SearchTerm OR w.id LIKE @SearchTerm OR  w.withdraw_amount LIKE @SearchTerm OR t.balance LIKE @SearchTerm";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SearchTerm", '%' + txtSearch.Text + '%'); // Use parameters to prevent SQL injection

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvWithdrawalRequests.DataSource = dt;
                gvWithdrawalRequests.DataBind();
            }
        }


        private void DisplayEmpty()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("id", typeof(int));
            dt.Columns.Add("withdraw_amount", typeof(decimal));
            dt.Columns.Add("request_date", typeof(DateTime));
            dt.Columns.Add("status", typeof(string));
            dt.Columns.Add("account_number", typeof(string));
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("balance", typeof(decimal));

            dt.Rows.Add(dt.NewRow()); 
            gvWithdrawalRequests.DataSource = dt;
            gvWithdrawalRequests.DataBind();
            gvWithdrawalRequests.Rows[0].Visible = false; 
        }


        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindDataWithCurrentFilters();
        }

        private void BindDataWithCurrentFilters()
        {
            using (SqlConnection con = new SqlConnection(Global.CS))
            {
                string baseSql = "SELECT w.id, w.withdraw_amount, w.request_date, w.status, w.account_number, t.name, t.balance FROM WithdrawalRequests w JOIN Tutors t ON w.tutor_id = t.id WHERE 1=1";
                List<SqlParameter> parameters = new List<SqlParameter>();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue) && ddlStatus.SelectedValue != "None")
                {
                    baseSql += " AND w.status = @Status";
                    parameters.Add(new SqlParameter("@Status", ddlStatus.SelectedValue));
                }

                if (!string.IsNullOrEmpty(TextBox3.Text))
                {
                    baseSql += " AND w.request_date >= @StartDate";
                    parameters.Add(new SqlParameter("@StartDate", DateTime.Parse(TextBox3.Text)));
                }

                if (!string.IsNullOrEmpty(TextBox4.Text))
                {
                    baseSql += " AND w.request_date <= @EndDate";
                    parameters.Add(new SqlParameter("@EndDate", DateTime.Parse(TextBox4.Text).AddDays(1)));
                }

                if (ddlStatus.SelectedValue == "None" && string.IsNullOrEmpty(TextBox3.Text) && string.IsNullOrEmpty(TextBox4.Text))
                {
                    // If "None" is selected and no other filters are set, you might want to clear the grid or handle appropriately
                    gvWithdrawalRequests.DataSource = null;
                    gvWithdrawalRequests.DataBind();
                    return;
                }

                cmd.CommandText = baseSql;
                cmd.Parameters.AddRange(parameters.ToArray());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvWithdrawalRequests.DataSource = dt;
                gvWithdrawalRequests.DataBind();
            }
        }


        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            TextBox3.Text = "";
            TextBox4.Text = "";
            BindDataWithCurrentFilters();
        }

        protected void btnToday_Click(object sender, EventArgs e)
        {
            var today = DateTime.Today;
            TextBox3.Text = today.ToString("yyyy-MM-dd");
            TextBox4.Text = today.ToString("yyyy-MM-dd");
            BindDataWithCurrentFilters();
        }


        private void BindDataToday()
        {
            using (SqlConnection con = new SqlConnection(Global.CS))
            {
                string sql = "SELECT w.id, w.withdraw_amount, w.request_date, w.status, w.account_number, t.name, t.balance FROM WithdrawalRequests w JOIN Tutors t ON w.tutor_id = t.id WHERE w.request_date = CAST(GETDATE() AS Date)";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvWithdrawalRequests.DataSource = dt;
                gvWithdrawalRequests.DataBind();
            }
        }

        protected void btnToday_Click1(object sender, EventArgs e)
        {
            BindDataToday();
        }

        



    }
}
