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
        private string supportReqId;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                adminId = authTicket.Name;
            }

            //if (String.IsNullOrEmpty(adminId)) { adminId = "1"; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT [id], [title], [date_send], [description], [tutor_id], [student_id] FROM [SupportRequests] WHERE [id] = @ID";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            cmd.Parameters.AddWithValue("@ID", id);
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
                    supportReqId = reader["id"].ToString();
                }
            }

            con.Close();

            backLink.NavigateUrl = "ViewRequest.aspx?id="+supportReqId;
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            int aId; int supportId;

            if (Int32.TryParse(adminId, out aId)) 
            {
                Response.Write("aId");
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

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            SqlConnection con = new SqlConnection(cs);

            con.Open();

            string selectQuery = "INSERT INTO [dbo].[Replies] ([reply],[datetime],[support_req_id],[admin_id]) VALUES (@Reply,@Datetime,@SupportReqId,@AdminId)";

            SqlCommand cmd = new SqlCommand(selectQuery, con);
            cmd.Parameters.AddWithValue("@Reply", txtReply.Text);
            cmd.Parameters.AddWithValue("@Datetime", DateTime.Now); 
            cmd.Parameters.AddWithValue("@SupportReqId", supportId); // Assuming support request ID
            cmd.Parameters.AddWithValue("@AdminId", aId); // Assuming admin ID

            int row = cmd.ExecuteNonQuery();

            if (row > 0)
            {
                Session["toast"] = new Toast("Reply created successfully", "success");
                Response.Redirect("SupportRequest.aspx");

                //Response.Write("<script>alert('Reply created successfully');window.location = 'SupportRequest.aspx';</script>");
            }
            else
            {
                Session["toast"] = new Toast("Reply does not created successfully", "fail");
                Response.Redirect("SupportRequest.aspx");

                //Response.Write("<script>alert('Reply does not created successfully');window.location = 'SupportRequest.aspx';</script>");
            }

        }
    }
}