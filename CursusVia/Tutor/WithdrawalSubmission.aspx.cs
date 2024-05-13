using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;

namespace CursusVia.Tutor
{
    public partial class WithdrawalSubmission : System.Web.UI.Page
    {
        private string tutorId;
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

                if (authCookie != null)
                {
                    FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                    tutorId = authTicket.Name;
                }
            }
            LoadTutorBalance();
        }

        private void LoadTutorBalance()
        {
            if (string.IsNullOrEmpty(tutorId))
            {
                litBalance.Text = "RM 0.00"; // Display default balance or a warning message
                return; // Exit the method if tutorId is null
            }

            string connectionString = Global.CS;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string sql = "SELECT balance FROM Tutors WHERE id = @TutorId";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorId);
                    object result = command.ExecuteScalar();

                    if (result != null)
                    {
                        try
                        {
                            decimal balance = Convert.ToDecimal(result);
                            litBalance.Text = $"RM {balance:N2}";
                        } 
                        catch (Exception)
                        { 
                            litBalance.Text = "RM 0.00";
                        }
                    }
                    else
                    {
                        litBalance.Text = "RM 0.00";
                    }
                }
            }
        }
        protected void btnWithdraw_Click(object sender, EventArgs e)
        {
           Response.Redirect("~/Tutor/WithdrawRequest.aspx");
        }

       

    }
}
