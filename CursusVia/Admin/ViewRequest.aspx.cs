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
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT [title], [date_send], [description] FROM [SupportRequests] WHERE [id] ='" + id + "'";

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
                }
            }

            con.Close();

            con.Open();

            string replies = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = '" + id + "'";
            SqlDataAdapter adapter = new SqlDataAdapter(replies, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();

            con.Close();

            replyLink.NavigateUrl = "ReplySupport.aspx?id="+id;
        }
    }
}