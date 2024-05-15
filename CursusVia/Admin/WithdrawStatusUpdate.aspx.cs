using CursusVia.Models;
using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace CursusVia.Admin
{
    public partial class WithdrawStatusUpdate : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string requestId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(requestId))
                {
                    Response.Redirect("WithdrawalRequest.aspx");
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
            int requestId = int.Parse(Request.QueryString["id"]);
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
                SqlCommand updateCmd = new SqlCommand("UPDATE WithdrawalRequests SET status = @Status, note = @Note WHERE id = @ID", con);
                updateCmd.Parameters.AddWithValue("@Status", newStatus);
                updateCmd.Parameters.AddWithValue("@Note", notes);
                updateCmd.Parameters.AddWithValue("@ID", requestId);

                try
                {
                    int updateResult = updateCmd.ExecuteNonQuery();
                    if (updateResult > 0)
                    {
                        // Call to insert into Payouts should be here after confirming status is updated
                        if (newStatus == "Approve")
                        {
                            InsertApprovedPayouts(requestId);
                        }

                        Response.Redirect("~/Admin/UpdateConfirmation.aspx");
                    }
                    else
                    {
                        litPaymentInfo.Text = "Update failed. No records were changed.";
                    }
                }
                catch (Exception ex)
                {
                    litPaymentInfo.Text = "Update failed. Error: " + ex.Message;
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
            Response.Redirect("WithdrawalRequest.aspx");
        }




        private void InsertApprovedPayouts(int requestId)
        {
            using (SqlConnection con = new SqlConnection(Global.CS))
            {
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Payout (total_payout, payout_method, payout_date, status, withdraw_request, tutor_id, admin_id)
                        SELECT wr.withdraw_amount, wr.bank_name, GETDATE(), 'Pending', wr.id, wr.tutor_id, NULL
                         FROM WithdrawalRequests wr
                         WHERE wr.status = 'Approve' AND wr.id = @ID", con);

                    cmd.Parameters.AddWithValue("@ID", requestId);  // Use the parameter correctly here

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






    }
}
