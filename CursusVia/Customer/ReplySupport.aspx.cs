using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class ReplySupport : System.Web.UI.Page
    {
        private string id;
        private string studentId;
        private string supportReqId;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }

            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(studentId)) { studentId = "1"; }

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string details = "SELECT [reply], [datetime], [support_req_id], [student_id], [admin_id] FROM [Replies] WHERE [id] ='" + id + "'";

                con.Open();

                SqlCommand cmd = new SqlCommand(details, con);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        lblAdminID.Text = "Admin ID: " + reader["admin_id"].ToString();
                        lblReplyTime.Text = "Replies on:" + reader["datetime"].ToString();
                        lblReply.Text = reader["reply"].ToString();
                        //studentId = reader["student_id"].ToString();
                        //tutorId = reader["tutor_id"].ToString();
                        supportReqId = reader["support_req_id"].ToString();
                    }
                }

                con.Close();

                backLink.NavigateUrl = "ViewRequest.aspx?id="+supportReqId;
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            int sId; int supportId;
            string supportReqId = "";

            string details = "SELECT [support_req_id] FROM [Replies] WHERE [id] ='" + id + "'";

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    supportReqId = reader["support_req_id"].ToString();
                }
            }

            con.Close();

            if (Int32.TryParse(studentId, out sId))
            {
                Debug.Write("tId");
            }
            else
            {
                Debug.Write("fail");
            }
            if (Int32.TryParse(supportReqId, out supportId))
            {
                Debug.Write(supportId);
            }
            else
            {
                Debug.Write("fail");
            }

            string insert = "INSERT INTO [dbo].[Replies] ([reply],[datetime],[support_req_id],[student_id]) VALUES (@Reply,@Datetime,@SupportReqId,@StudentId)";
            con.Open();
            SqlCommand insertSql = new SqlCommand(insert, con);
            insertSql.Parameters.AddWithValue("@Reply", txtReply.Text);
            insertSql.Parameters.AddWithValue("@Datetime", DateTime.Now);
            insertSql.Parameters.AddWithValue("@SupportReqId", supportId);
            insertSql.Parameters.AddWithValue("@StudentId", sId);

            int row = insertSql.ExecuteNonQuery();
            con.Close();
            if (row > 0)
            {
                Response.Write("<script>alert('Reply created successfully');window.location = 'Support.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Reply does not created successfully');window.location = 'Support.aspx';</script>");
            }
        }
    }
}