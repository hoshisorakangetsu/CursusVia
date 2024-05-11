using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace CursusVia.Tutor
{
    public partial class WithdrawRequestConfirm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Show the withdrawal details
                litWithdrawalID.Text = Session["BankName"] as string;
                litHName.Text = Session["AccountHolderName"] as string;
                LitAccNo.Text = Session["AccountNumber"] as string;
                litAmount.Text = Session["WithdrawAmount"] as string;
            }
        }

        protected void btnWithdrawal_Click(object sender, EventArgs e)
        {
            string connectionString = Global.CS;
            string sql = @"INSERT INTO WithdrawalRequests (withdraw_amount, request_date, status, account_number, bank_name, account_holder_name, tutor_id) 
                           VALUES (@WithdrawAmount, @RequestDate, 'Pending', @AccountNumber, @BankName, @AccountHolderName, @TutorId)";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@WithdrawAmount", Convert.ToDecimal(Session["WithdrawAmount"]));
                    cmd.Parameters.AddWithValue("@RequestDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@AccountNumber", Session["AccountNumber"] as string);
                    cmd.Parameters.AddWithValue("@BankName", Session["BankName"] as string);
                    cmd.Parameters.AddWithValue("@AccountHolderName", Session["AccountHolderName"] as string);
                    cmd.Parameters.AddWithValue("@TutorId", Convert.ToInt32(Session["TutorId"]));

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            Session.Remove("BankName");
            Session.Remove("AccountHolderName");
            Session.Remove("AccountNumber");
            Session.Remove("WithdrawAmount");
            Session.Remove("TutorId");

            // Redirect the user to the status page after successful submission
            Response.Redirect("~/Tutor/WithdrawRequestStatus.aspx");
        }

        protected void btnCanWithdrawal_Click(object sender, EventArgs e)
        {
            // Redirect back to the withdrawal request page if cancelled
            Response.Redirect("~/Tutor/WithdrawRequest.aspx");
        }
    }
}
