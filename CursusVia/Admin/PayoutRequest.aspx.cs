using System;
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
                InsertApprovedPayouts(); // Method to insert payouts from approved withdrawal requests
                BindDataToday();
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

        private void InsertApprovedPayouts()
        {
            using (SqlConnection con = new SqlConnection(Global.CS))
            {
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Payout (total_payout, payout_method, payout_date, status, withdraw_request, tutor_id, admin_id)
SELECT wr.withdraw_amount, bank_name, GETDATE(), 'Pending', wr.id, wr.tutor_id, NULL
FROM WithdrawalRequests wr
WHERE wr.status = 'Approve';

", con);  

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine("Successfully inserted " + rowsAffected + " records.");
                    }
                    else
                    {
                        Console.WriteLine("No records to insert. Check the status of WithdrawalRequests.");
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("An error occurred: " + ex.Message);
                }
                finally
                {
                    con.Close();
                }
            }
        }




        private void BindDataToday()
        {
            var today = DateTime.Today;
            TextBox3.Text = today.ToString("yyyy-MM-dd");
            TextBox4.Text = today.ToString("yyyy-MM-dd");
            BindDataWithCurrentFilters();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindDataWithCurrentFilters();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindDataWithCurrentFilters();
        }

        private void BindDataWithCurrentFilters()
        {
            using (SqlConnection con = new SqlConnection(Global.CS))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                string sql = "SELECT p.id, t.name, p.payout_date, p.payout_method, p.total_payout, p.status FROM Payout p JOIN Tutors t ON p.tutor_id = t.id WHERE 1=1";

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue) && ddlStatus.SelectedValue != "None")
                {
                    sql += " AND p.status = @Status";
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                }

                if (!string.IsNullOrEmpty(TextBox3.Text) && !string.IsNullOrEmpty(TextBox4.Text))
                {
                    sql += " AND p.payout_date BETWEEN @StartDate AND @EndDate";
                    cmd.Parameters.AddWithValue("@StartDate", DateTime.Parse(TextBox3.Text));
                    cmd.Parameters.AddWithValue("@EndDate", DateTime.Parse(TextBox4.Text));
                }

                cmd.CommandText = sql;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvPayoutOrder.DataSource = dt;
                gvPayoutOrder.DataBind();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            TextBox3.Text = "";
            TextBox4.Text = "";
            BindDataToday(); // Reset the data view to today's data or use BindData if today-specific isn't needed.
        }

        protected void btnToday_Click(object sender, EventArgs e)
        {
            BindDataToday();
        }
    }
}
