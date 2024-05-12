using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class DeleteRequest : System.Web.UI.Page
    {
        int row;
        string id;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string select = "SELECT [id], [title], [date_send], [description], [student_id] FROM [SupportRequests] WHERE [id] = '" + id + "'";

                con.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(select, con);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);
                Repeater1.DataSource=dataSet;
                Repeater1.DataBind();

                con.Close();

                con.Open();
                string replies = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = '" + id + "' AND [admin_id] IS NOT NULL";
                SqlDataAdapter adapterReply = new SqlDataAdapter(replies, con);
                DataSet dataSetReply = new DataSet();
                adapterReply.Fill(dataSetReply);
                Repeater2.DataSource=dataSetReply;
                Repeater2.DataBind();
                con.Close();

                con.Open();
                string repliesTutor = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = '" + id + "' AND [student_id] IS NOT NULL";
                SqlDataAdapter adapterReplyTutor = new SqlDataAdapter(repliesTutor, con);
                DataSet dataSetReplyTutor = new DataSet();
                adapterReplyTutor.Fill(dataSetReplyTutor);
                Repeater3.DataSource=dataSetReplyTutor;
                Repeater3.DataBind();
                con.Close();

                row = dataSetReply.Tables[0].Rows.Count;

                if (row == 0)
                {
                    lblNoReplies.Text = "No Replies to the Request yet";
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string deleteReply = "DELETE FROM [dbo].[Replies] WHERE [support_req_id] = '" + id + "'";
            string deleteRequest = "DELETE FROM[dbo].[SupportRequests] WHERE [id] = '" + id + "'";

            con.Open();
            SqlCommand drop = new SqlCommand(deleteReply, con);
            drop.ExecuteNonQuery();
            SqlCommand drop1 = new SqlCommand(deleteRequest, con);
            drop1.ExecuteNonQuery();
            con.Close();

            Response.Write("<script>alert('Support Request deleted successfully');window.location = 'Support.aspx';</script>");
        }
    }
}