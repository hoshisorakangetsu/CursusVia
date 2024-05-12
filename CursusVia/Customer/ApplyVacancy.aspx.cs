using CursusVia.Admin;
using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using MailKit.Net.Smtp;
using MailKit;
using MimeKit;

namespace CursusVia.Customer
{
    public partial class ApplyVacancy : System.Web.UI.Page
    {
        string id;
        private string studentId;
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

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string details = "SELECT Vacancies.job_title, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description FROM Companies INNER JOIN Vacancies ON Companies.id = Vacancies.company_id WHERE Vacancies.id ='" + id + "'";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblJobTitle.Text = reader["job_title"].ToString();
                    jobtitle.Text = reader["job_title"].ToString();
                    lblCompanyName.Text = reader["name"].ToString();
                    companyName.Text = reader["name"].ToString();
                    lblArea.Text = reader["area"].ToString() + ", " + reader["state"].ToString();
                    lblMinSalary.Text = "RM" + reader["min_salary"].ToString();
                    lblMaxSalary.Text = " RM " + reader["max_Salary"].ToString() + " per month";
                    lblDepartment.Text = reader["role"].ToString();
                    lblType.Text = reader["type"].ToString();
                }
            }

            con.Close();
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) { return; }

            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);

            string insert = "INSERT INTO[dbo].[JobApplications] ([vacancy_id],[student_id],[resume_resource_id],[expecred_salary])VALUES(@VacancyId,@StudentId,@ResumeResourceId,@ExpectedSalary)";
            int file = Util.UploadFile(FileUpload1.PostedFile, Server);
            if (file == 0) { return; }

            SqlCommand cmd = new SqlCommand(insert, con);

            cmd.Parameters.AddWithValue("@VacancyId", id);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@ResumeResourceId", file);
            cmd.Parameters.AddWithValue("@ExpectedSalary", Convert.ToDouble(txtMinSalary.Text));
            int row = cmd.ExecuteNonQuery();

            if (row > 0)
            {
                //create object to store message
                MimeMessage message = new MimeMessage();
                //add sender info to the message
                message.From.Add(new MailboxAddress("neohsc", "neohsc-pp21@student.tarc.edu.my"));
                //add receiver
                message.To.Add(MailboxAddress.Parse("soonqi03@gmail.com"));
                //add message subject
                message.Subject = "Testing";
                //add the message body as plain text
                message.Body =  new TextPart("plain")
                {
                    Text = @"yes
                    Hello!.
                    This is a dog."
                };

                //authentication which is a email   
                string email="";
                string password="";

                //create smtp cilent
                SmtpClient client = new SmtpClient();

                try
                {
                    //connect to gmail smtp server using port 465 with SSl enabled
                    client.Connect("smtp.gmail.com",465,true);
                    //need autheticate if use gmail
                    client.Authenticate(email, password);
                    client.Send(message);

                    //success message
                }
                catch (Exception ex)
                {
                    //cause error
                    Response.Write(ex.Message.ToString());
                }
                finally
                {
                    //disconnect and dispose
                    client.Disconnect(true);
                    client.Dispose();
                }

                Response.Write("<script>alert('Job applied successfully');window.location = 'Vacancy.aspx';</script>");
            }
            else
            {
                Response.Write("<script>alert('Job does not applied successfully');window.location = 'Vacancy.aspx';</script>");
            }
        }
    }
}