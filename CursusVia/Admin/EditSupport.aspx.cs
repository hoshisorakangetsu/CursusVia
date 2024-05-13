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
    public partial class EditSupport : System.Web.UI.Page
    {
        private string id;
        private string supportReqId;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string read = "SELECT [reply], [support_req_id], [id] FROM [Replies] WHERE [id] = @ID";

                con.Open();

                SqlCommand cmd = new SqlCommand(read, con);
                cmd.Parameters.AddWithValue("@ID", id);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        txtReplyContent.Text = reader["reply"].ToString();
                        supportReqId = reader["support_req_id"].ToString();
                    }
                }
                con.Close();
            }

            backLink.NavigateUrl = "ViewRequest.aspx?id="+supportReqId;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string update = "UPDATE [dbo].[Replies] SET [reply] = @Reply WHERE [id] = @id";
            
            con.Open();
            SqlCommand updateReply = new SqlCommand(update, con);

            updateReply.Parameters.AddWithValue("@Reply", txtReplyContent.Text);
            updateReply.Parameters.AddWithValue("@id", id);

            int row = updateReply.ExecuteNonQuery();
            
            if (row > 0)
            {
                Session["toast"] = new Toast("Reply update successfully", "success");
                Response.Redirect("SupportRequest.aspx");

                //Response.Write("<script>alert('Reply update successfully');window.location = 'SupportRequest.aspx';</script>");
            }
            else
            {
                Session["toast"] = new Toast("Reply does not update", "fail");
                Response.Redirect("SupportRequest.aspx");

                //Response.Write("<script>alert('Reply does not update');window.location = 'SupportRequest.aspx';</script>");
            }
        }
    }
}