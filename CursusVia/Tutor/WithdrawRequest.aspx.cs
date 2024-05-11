using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class WithdrawRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect the user to theWithdrawalSubmission  page
            Response.Redirect("~/Tutor/WithdrawalSubmission.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket != null)
                {
                    int tutorId = Convert.ToInt32(ticket.Name);
                    float currentBalance = GetCurrentBalance(tutorId);
                    float totalPendingWithdrawals = GetTotalPendingWithdrawals(tutorId);

                    if (!float.TryParse(txtWithdrawAmount.Text, out float withdrawAmount))
                    {
                        lblStatus.Text = "Invalid withdrawal amount.";
                        lblStatus.CssClass = "error";
                        lblStatus.Visible = true;
                        return;
                    }

                    if (withdrawAmount < 50 || (withdrawAmount + totalPendingWithdrawals) > currentBalance)
                    {
                        lblStatus.Text = "Withdrawal amount must be at least $50 and cannot exceed your available balance minus pending withdrawals.";
                        lblStatus.CssClass = "error";
                        lblStatus.Visible = true;
                        return;
                    }

                    // Store the values in Session to pass to the confirmation page
                    Session["TutorId"] = tutorId;
                    Session["BankName"] = ddlBankName.SelectedItem.Text;
                    Session["AccountHolderName"] = txtAccHName.Text;
                    Session["AccountNumber"] = txtAccNo.Text;
                    Session["WithdrawAmount"] = withdrawAmount.ToString();  // Format as necessary, e.g., adding currency

                    // Redirect the user to the confirmation page after successful submission
                    Response.Redirect("~/Tutor/WithdrawRequestConfirm.aspx");
                }
                else
                {
                    lblStatus.Text = "Authentication failed. Please log in again.";
                    lblStatus.CssClass = "error";
                    lblStatus.Visible = true;
                }
            }
            else
            {
                lblStatus.Text = "You must be logged in to submit a request.";
                lblStatus.CssClass = "error";
                lblStatus.Visible = true;
            }
        }

        private float GetTotalPendingWithdrawals(int tutorId)
        {
            float totalPending = 0;
            string connectionString = Global.CS;
            string sql = "SELECT SUM(withdraw_amount) FROM WithdrawalRequests WHERE tutor_id = @TutorId AND status = 'Pending'";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@TutorId", tutorId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != DBNull.Value)
                    {
                        totalPending = Convert.ToSingle(result);
                    }
                }
            }

            return totalPending;
        }



        private float GetCurrentBalance(int tutorId)
        {
            // Assuming you have a method to query the database to retrieve the tutor's balance
            float balance = 0;
            string connectionString = Global.CS;
            string sql = "SELECT balance FROM Tutors WHERE id = @TutorId";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@TutorId", tutorId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        balance = Convert.ToSingle(result);
                    }
                }
            }

            return balance;
        }

    }
}
   
