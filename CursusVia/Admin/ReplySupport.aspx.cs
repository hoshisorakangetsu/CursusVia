using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class ReplySupport : System.Web.UI.Page
    {
        private string id;
        private string adminId;
        private string studentId;
        private string tutorId;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                adminId = authTicket.Name;
            }

            // for xb test on his machine only, remove in future
            if (String.IsNullOrEmpty(adminId)) { adminId = "1"; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT [title], [date_send], [description], [tutor_id], [student_id] FROM [SupportRequests] WHERE [id] ='" + id + "'";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblRequestTitle.Text = reader["title"].ToString();
                    lblPostTime.Text = "Posted on:" + reader["date_send"].ToString();
                    lblDescr.Text = reader["description"].ToString();
                    studentId = reader["student_id"].ToString();
                    tutorId = reader["tutor_id"].ToString();
                }
            }

            con.Close();
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            int sId; int tId; int aId; int supportId;
            bool isStudent = false;
            if (Int32.TryParse(studentId,out sId)) 
            { 
                Debug.Write("sId");
                isStudent = true;
            }
            else 
            {
                Debug.Write("fail");
            }
            if (Int32.TryParse(tutorId, out tId)) 
            {
                Debug.Write("tId");
            }
            else
            {
                Debug.Write("fail");
            }
            if (Int32.TryParse(adminId, out aId)) 
            {
                Debug.Write("aId");
            }
            else
            {
                Debug.Write("fail");
            }
            if (Int32.TryParse(id, out supportId)) 
            { 
                Debug.Write("supportId");
            }
            else
            {
                Debug.Write("fail");
            }

            //Int32.TryParse;
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(cs);

            con.Open();
            //string getValue = "SELECT [id], [title], [date_send], [description], [status], [tutor_id], [student_id] FROM [SupportRequests] WHERE [id] ='" + id + "'";

            string selectQuery;
            if (isStudent)
                selectQuery = "INSERT INTO [dbo].[Replies] ([reply],[datetime],[support_req_id],[admin_id],[student_id]) VALUES (@Reply,@Datetime,@SupportReqId,@AdminId,@StudentId)";
            else 
                selectQuery = "INSERT INTO [dbo].[Replies] ([reply],[datetime],[support_req_id],[admin_id],[tutor_id]) VALUES (@Reply,@Datetime,@SupportReqId,@AdminId,@TutorId)";

            SqlCommand cmd = new SqlCommand(selectQuery, con);
            cmd.Parameters.AddWithValue("@Reply", txtReply.Text);
            cmd.Parameters.AddWithValue("@Datetime", DateTime.Now); 
            cmd.Parameters.AddWithValue("@SupportReqId", supportId); // Assuming support request ID
            cmd.Parameters.AddWithValue("@AdminId", aId); // Assuming admin ID

            if (isStudent)
                cmd.Parameters.AddWithValue("@StudentId", sId); // Assuming student ID
            else
                cmd.Parameters.AddWithValue("@TutorId", tId); // Assuming no tutor ID (nullable)

            int row = cmd.ExecuteNonQuery();

            if (row > 0)
            {
                Response.Write("<script>alert('Reply created successfully');window.location = 'SupportRequest.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Reply does not created successfully');window.location = 'SupportRequest.aspx';</script>");
            }

        }
    }
}