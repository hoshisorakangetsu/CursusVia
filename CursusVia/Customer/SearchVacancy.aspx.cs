﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class Vacancy1 : System.Web.UI.Page
    {
        private string studentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            string comName = Request.QueryString["comName"];

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }
            //if (String.IsNullOrEmpty(studentId)) { studentId = "1"; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            if (!string.IsNullOrEmpty(comName))
            {
                txtCompanyName.Text = comName;
                string sqlWithName = "SELECT Vacancies.id, Vacancies.job_title, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description, Vacancies.email, Vacancies.company_id, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE Companies.name = @Name";
                con.Open();
                SqlDataAdapter adapterName = new SqlDataAdapter(sqlWithName, con);
                adapterName.SelectCommand.Parameters.AddWithValue("@Name", comName);
                DataSet dataSetName = new DataSet();
                adapterName.Fill(dataSetName);
                Repeater1.DataSource=dataSetName;
                Repeater1.DataBind();
                con.Close();
            }
            else if (!IsPostBack)
            {
                string sql = "SELECT Vacancies.id, Vacancies.job_title, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description, Vacancies.email, Vacancies.company_id, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE Vacancies.id NOT IN (SELECT vacancy_id FROM JobApplications WHERE student_id = @sID)";
                con.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sql, con);
                adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
                DataSet dataSet = new DataSet();
                adapter.Fill(dataSet);
                Repeater1.DataSource=dataSet;
                Repeater1.DataBind();
                con.Close();
            }

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bool isComName = false;
            bool isTitle = false;
            bool isWorkArea = false;
            bool isMinSalary = false;
            bool isMaxSalary = false;
            bool isType = false;
            string type;
            int min=0, max=0;

            type = ddlJobType.SelectedValue;
            if (!type.Equals("None"))
                isType = true;
            if (txtCompanyName.Text.Length > 0)
                isComName = true;
            if (txtJobTitle.Text.Length > 0)
                isTitle = true;
            if (txtWorkingArea.Text.Length > 0)
                isWorkArea = true;
            if (txtMinSalary.Text.Length > 0)
            {
                isMinSalary = true;
                if (Int32.TryParse(txtMinSalary.Text, out min)) ;
            }
                
            if (txtMaxSalary.Text.Length > 0)
            {
                isMaxSalary= true;
                if (Int32.TryParse(txtMaxSalary.Text, out max));
            }
                
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string sql;
            sql = "SELECT Vacancies.id, Vacancies.job_title, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Companies.name, Companies.state, Companies.area FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE";
           
            if (isType)
            {
                sql = String.Concat(sql, " Vacancies.type = @Type AND");
            }
            if (isComName)
            {
                sql = String.Concat(sql, " Companies.name LIKE @ComName AND");
            }
            if (isTitle)
            {
                sql = String.Concat(sql, " Vacancies.job_title LIKE @JobTitle AND");
            }
            if (isWorkArea)
            {
                sql = String.Concat(sql, " Companies.area LIKE @WorkArea AND");
            }
            if (isMinSalary)
            {
                sql = String.Concat(sql, " Vacancies.min_salary >= @Min AND");
            }
            if (isMaxSalary)
            {
                sql = String.Concat(sql, " Vacancies.min_salary <= @Max AND");
            }
            sql = sql.Remove(sql.Length - 4);

            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(sql, con);
            adapter.SelectCommand.Parameters.AddWithValue("@Type", type);
            adapter.SelectCommand.Parameters.AddWithValue("@ComName", "%" + txtCompanyName.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@JobTitle", "%" + txtJobTitle.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@WorkArea", "%" + txtWorkingArea.Text + "%");
            adapter.SelectCommand.Parameters.AddWithValue("@Min", min);
            adapter.SelectCommand.Parameters.AddWithValue("@Max", max);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCompanyName.Text = "";
            txtJobTitle.Text="";
            txtWorkingArea.Text="";
            txtMinSalary.Text="";
            txtMaxSalary.Text="";
            ddlJobType.SelectedIndex = 0;

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string sql = "SELECT Vacancies.id, Vacancies.job_title, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description, Vacancies.email, Vacancies.company_id, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id WHERE Vacancies.id NOT IN (SELECT vacancy_id FROM JobApplications WHERE student_id = @sID)";
            con.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(sql, con);
            adapter.SelectCommand.Parameters.AddWithValue("@sID", studentId);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            Repeater1.DataSource=dataSet;
            Repeater1.DataBind();
            con.Close();
        }
    }
}