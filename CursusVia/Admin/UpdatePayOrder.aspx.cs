using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class UpdatePayOrder : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string requestId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(requestId))
                {
                    Response.Redirect("PayoutRequest.aspx");
                }
                else
                {
                    DisplayRequestId(requestId);
                }
            }
        }

        private void DisplayRequestId(string requestId)
        {
            litPaymentID.Text = requestId;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int payoutId = int.Parse(Request.QueryString["id"]); // This is the Payout ID
            string newStatus = ddlWithdrawStatus.SelectedValue;
            string notes = txtNotes.Text;
            string connectionString = Global.CS;

            int adminId = GetAdminIdFromCookie();
            if (adminId == -1)
            {
                litPaymentInfo.Text = "Authentication error. Please log in again.";
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = con.CreateCommand();
                SqlTransaction transaction;

                // Start a local transaction.
                transaction = con.BeginTransaction("UpdateTransaction");

                // Must assign both transaction object and connection to Command object for a pending local transaction
                cmd.Connection = con;
                cmd.Transaction = transaction;

                try
                {
                    // Update WithdrawalRequests
                    cmd.CommandText = @"
                      UPDATE WithdrawalRequests
            SET status = @Status, note = @Note
            FROM WithdrawalRequests
            INNER JOIN Payout ON WithdrawalRequests.id = Payout.withdraw_request
            WHERE Payout.id = @PayoutID";
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@Note", notes);
                    cmd.Parameters.AddWithValue("@PayoutID", payoutId);
                    cmd.ExecuteNonQuery();

                    // Update Payout
                    cmd.CommandText = @"
            UPDATE Payout
            SET status = @Status
            WHERE id = @PayoutID";
                    cmd.ExecuteNonQuery();

                    // If the status is "Paid", update the tutor's balance
                    if (newStatus.Equals("Paid", StringComparison.OrdinalIgnoreCase))
                    {
                        // Subtract the withdrawal amount from the tutor's balance
                        cmd.CommandText = @"
                UPDATE Tutors
                SET balance = balance - w.withdraw_amount
                FROM Tutors t
                INNER JOIN WithdrawalRequests w ON t.id = w.tutor_id
                INNER JOIN Payout p ON w.id = p.withdraw_request
                WHERE p.id = @PayoutID";
                        cmd.ExecuteNonQuery();
                    }

                    // Attempt to commit the transaction.
                    transaction.Commit();
                    Response.Redirect("~/Admin/UpdateConfirmation.aspx");
                }
                catch (Exception ex)
                {
                    // Attempt to roll back the transaction.
                    try
                    {
                        transaction.Rollback();
                        litPaymentInfo.Text = "Transaction rolled back due to an error. " + ex.Message;
                    }
                    catch (Exception exRollback)
                    {
                        // Handle any errors that may have occurred on the server that would cause the rollback to fail.
                        litPaymentInfo.Text = "Rollback failed. Error: " + exRollback.Message;
                    }
                }
            }
        }


        protected int GetAdminIdFromCookie()
        {
            HttpCookie authCookie = Request.Cookies["AdminAuth"];
            if (authCookie != null && authCookie["LoggedIn"] == "true")
            {
                if (int.TryParse(authCookie["AdminID"], out int adminId))
                {
                    return adminId;
                }
            }
            return -1;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("PayoutRequest.aspx");
        }




    }
}
