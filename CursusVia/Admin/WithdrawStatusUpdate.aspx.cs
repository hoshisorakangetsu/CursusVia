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

    


    }
}
