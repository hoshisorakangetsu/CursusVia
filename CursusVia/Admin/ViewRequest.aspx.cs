using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class ViewRequest : System.Web.UI.Page
    {
        int row = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT [title], [date_send], [description] FROM [SupportRequests] WHERE [id] = @ID";

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
                }
            }

            con.Close();

            con.Open();

            string replies = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = @ID AND [admin_id] IS NOT NULL";
            SqlDataAdapter adapter = new SqlDataAdapter(replies, con);
            adapter.SelectCommand.Parameters.AddWithValue("@ID", id);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();

            con.Close();

            con.Open();
            string repliesTutor = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = @ID AND [admin_id] IS NULL";
            SqlDataAdapter adapterReplyTutor = new SqlDataAdapter(repliesTutor, con);
            adapterReplyTutor.SelectCommand.Parameters.AddWithValue("@ID", id);
            DataSet dataSetReplyTutor = new DataSet();
            adapterReplyTutor.Fill(dataSetReplyTutor);
            Repeater2.DataSource=dataSetReplyTutor;
            Repeater2.DataBind();
            con.Close();

            row = dataSet.Tables[0].Rows.Count;

            if (row == 0)
            {
                lblNoReplies.Text = "No Replies to the Request yet";
            }

            replyLink.NavigateUrl = "ReplySupport.aspx?id="+id;
        }
    }
}