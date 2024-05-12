using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class ViewPayoutRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["AdminAuth"] != null && Request.Cookies["AdminAuth"]["LoggedIn"] == "true")
                {
                    if (Request.QueryString["id"] != null)
                    {
                        int payoutId = int.Parse(Request.QueryString["id"]);
                        LoadWithdrawalDetails(payoutId);
                    }
                }
                else
                {
                    Response.Redirect("AdminLogin.aspx"); // Redirect to login if not authenticated
                }
            }
        }

        private void LoadWithdrawalDetails(int payoutId)
        {
            string cs = Global.CS;
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Updated SQL to join Payout with WithdrawalRequests and Tutors
                string query = @"
        SELECT 
            p.id, 
            p.total_payout, 
            p.payout_method, 
            p.payout_date, 
            p.status, 
            w.withdraw_amount, 
            w.request_date, 
            w.note, 
            w.account_number, 
            w.bank_name, 
            w.account_holder_name, 
            t.name, 
            t.balance 
        FROM Payout p
        JOIN WithdrawalRequests w ON p.withdraw_request = w.id
        JOIN Tutors t ON p.tutor_id = t.id 
        WHERE p.id = @ID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", payoutId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Update literals to reflect fields from Payout and associated tables
                    Literal1.Text = reader["id"].ToString();
                    Literal5.Text = reader["name"].ToString(); // Tutor's name
                    litAvaiBalance.Text = reader["balance"].ToString(); // Tutor's balance
                    Literal2.Text = reader["total_payout"].ToString(); // Total payout instead of withdrawal amount
                    Literal3.Text = reader["payout_method"].ToString(); // Payout method
                    Literal4.Text = reader["account_number"].ToString(); // Payout date
                    Literal6.Text = reader["status"].ToString(); // Payout status
                    Literal7.Text = reader["note"].ToString(); // Note from WithdrawalRequests
                }
                reader.Close();
            }
        }



        protected void btnCanWithdrawal_Click(object sender, EventArgs e)
        {
            Response.Redirect("/admin/PayoutRequest.aspx");

        }

    }
}