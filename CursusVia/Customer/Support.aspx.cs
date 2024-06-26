﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Reflection.Emit;

namespace CursusVia.Customer
{
    public partial class Support : System.Web.UI.Page
    {
        private string studentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }
            //if (String.IsNullOrEmpty(studentId)) { studentId = "1"; }

            if (!IsPostBack)
            {
                string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(cs);

                string query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = @sID";
                con.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(query, con);
                adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);
                Repeater1.DataSource=dataSet;
                Repeater1.DataBind();
                con.Close();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string filter, begin = "", end ="";
            bool isStatus = false;
            bool isStart = false;
            bool isEnd = false;

            filter = ddlStatus.SelectedValue;
            if (!filter.Equals("None"))
                isStatus = true;
            if (startDate.Text.Length > 0)
            {
                begin = startDate.Text;
                isStart = true;
            }
            if (EndDate.Text.Length > 0)
            {
                DateTime date = Convert.ToDateTime(this.EndDate.Text);
                date = date.AddDays(1);
                end = date.ToString("yyyy-MM-dd");
                isEnd = true;
            }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = @sID";
            if (isStatus)
            {
                query = String.Concat(query," AND [status] = @filter");
            }
            if (isStart)
            {
                query = String.Concat(query, " AND [date_send] >= @Start");
            }
            if (isEnd)
            {
                query = String.Concat(query, " AND [date_send] <= @End");
            }
            con.Open();
            SqlDataAdapter sql = new SqlDataAdapter(query, con);
            sql.SelectCommand.Parameters.AddWithValue("@sID", studentId);
            sql.SelectCommand.Parameters.AddWithValue("@filter", filter);
            sql.SelectCommand.Parameters.AddWithValue("@Start", begin);
            sql.SelectCommand.Parameters.AddWithValue("@End", end);
            DataSet dt = new DataSet();
            sql.Fill(dt);
            Repeater1.DataSource=dt;
            Repeater1.DataBind();
            con.Close();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            EndDate.Text = "";
            startDate.Text ="";

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = @sID";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string query = "SELECT [id], [title], [date_send], [description], [status], [student_id] FROM [SupportRequests] WHERE [student_id] = @sID AND [title] LIKE @reqTitle";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(query, con);
            adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
            adapter.SelectCommand.Parameters.AddWithValue("@reqTitle", "%" + txtTitle.Text + "%");
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }
    }
}