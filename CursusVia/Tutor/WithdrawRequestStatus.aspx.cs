using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class WithdrawRequestStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            string tutorId = GetTutorIdFromCookie();
            if (!string.IsNullOrEmpty(tutorId))
            {
                string connectionString = Global.CS;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT id, status,  request_date FROM WithdrawalRequests WHERE tutor_id = @TutorId ORDER BY request_date DESC", con))
                    {
                        cmd.Parameters.AddWithValue("@TutorId", tutorId);
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            gvWithdrawRequests.DataSource = reader;
                            gvWithdrawRequests.DataBind();
                        }
                    }
                }
            }
            else
            {
                // Handle not authenticated
                litWithdrawalNotice.Text = "Please log in to view your withdrawal requests.";
            }
        }

        private string GetTutorIdFromCookie()
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket != null && !string.IsNullOrEmpty(ticket.Name))
                {
                    return ticket.Name;  // Assuming the Name stores the tutor ID
                }
            }
            return null;  // Not authenticated or cookie is missing
        }

    }
}