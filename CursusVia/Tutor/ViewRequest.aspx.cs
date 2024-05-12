﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class ViewRequest : System.Web.UI.Page
    {
        int row;
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string select = "SELECT [id], [title], [date_send], [description], [tutor_id] FROM [SupportRequests] WHERE [id] = '" + id + "'";

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(select, con);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();

            con.Close();

            con.Open();

            string replies = "SELECT [reply], [datetime], [support_req_id], [admin_id], [student_id], [tutor_id], [id] FROM [Replies] WHERE [support_req_id] = '" + id + "'";
            SqlDataAdapter adapterReply = new SqlDataAdapter(replies, con);
            DataSet dataSetReply = new DataSet();
            adapterReply.Fill(dataSetReply);
            Repeater2.DataSource=dataSetReply;
            Repeater2.DataBind();
            con.Close();

            row = dataSetReply.Tables[0].Rows.Count;

            if (row == 0)
            {
                lblNoReplies.Text = "No Replies to the Request yet";
            }
        }
    }
}