using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class ViewWithdrawRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["AdminAuth"] != null && Request.Cookies["AdminAuth"]["LoggedIn"] == "true")
                {
                    if (Request.QueryString["id"] != null)
                    {
                        int requestId = int.Parse(Request.QueryString["id"]);
                        LoadWithdrawalDetails(requestId);
                    }
                }
                else
                {
                    Response.Redirect("AdminLogin.aspx"); // Redirect to login if not authenticated
                }
            }
        }

        private void LoadWithdrawalDetails(int requestId)
        {
            string cs = Global.CS;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT w.id, w.withdraw_amount, w.request_date, w.status, w.note, w.account_number, w.bank_name, w.account_holder_name, t.name, t.balance FROM WithdrawalRequests w JOIN Tutors t ON w.tutor_id = t.id WHERE w.id = @ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ID", requestId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Literal1.Text = reader["id"].ToString();
                    Literal5.Text = reader["name"].ToString(); 
                    litAvaiBalance.Text = reader["balance"].ToString();
                    Literal2.Text = reader["withdraw_amount"].ToString();
                    Literal3.Text = reader["bank_name"].ToString();
                    Literal4.Text = reader["account_number"].ToString();
                    Literal6.Text = reader["status"].ToString();
                    Literal7.Text = reader["note"].ToString();
                }
                reader.Close();
            }
        }


      

        protected void btnCanWithdrawal_Click(object sender, EventArgs e)
        {
            Response.Redirect("/admin/WithdrawalRequest.aspx");

        }


    }
}