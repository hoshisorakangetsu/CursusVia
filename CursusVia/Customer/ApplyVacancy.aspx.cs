using MailKit.Net.Smtp;
using MimeKit;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class ApplyVacancy : System.Web.UI.Page
    {
        string id;
        private string studentId;
        private string jobTitle;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = Request.Params["id"];
            backLink.NavigateUrl= "ViewVacancy.aspx?id="+id;

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

            string details = "SELECT Vacancies.job_title, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.area, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description FROM Companies INNER JOIN Vacancies ON Companies.id = Vacancies.company_id WHERE Vacancies.id = @ID";

            con.Open();

            SqlCommand cmd = new SqlCommand(details, con);
            cmd.Parameters.AddWithValue("@ID", id);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblJobTitle.Text = reader["job_title"].ToString();
                    jobtitle.Text = reader["job_title"].ToString();
                    jobTitle = reader["job_title"].ToString();
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

            con.Open();
            string insert = "INSERT INTO[dbo].[JobApplications] ([vacancy_id],[student_id],[resume_resource_id],[expecred_salary])VALUES(@VacancyId,@StudentId,@ResumeResourceId,@ExpectedSalary)";
            int file = Util.UploadFile(FileUpload1.PostedFile, Server);
            if (file == 0)
            {
                Session["toast"] = new Toast("File upload fail", "fail");
                Response.Redirect(Request.RawUrl);
            }

            SqlCommand cmd = new SqlCommand(insert, con);

            cmd.Parameters.AddWithValue("@VacancyId", id);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@ResumeResourceId", file);
            cmd.Parameters.AddWithValue("@ExpectedSalary", Convert.ToDouble(txtMinSalary.Text));
            int row = cmd.ExecuteNonQuery();
            con.Close();
            if (row > 0)
            {
                //get student name
                string studentName;
                con.Open();
                string std = "SELECT [name] FROM [Students] WHERE [id] = @StudentID";
                SqlCommand stud = new SqlCommand(std, con);
                stud.Parameters.AddWithValue("@StudentID", studentId);
                studentName = stud.ExecuteScalar().ToString();
                con.Close();

                //get student email
                string studentEmail;
                con.Open();
                string email = "SELECT [email] FROM [Students] WHERE [id] = @StudentID";
                SqlCommand emailSql = new SqlCommand(email, con);
                emailSql.Parameters.AddWithValue("@StudentID", studentId);
                studentEmail = emailSql.ExecuteScalar().ToString();
                con.Close();

                //get HR email
                string HREmail;
                con.Open();
                string hremail = "SELECT [email] FROM [Vacancies] WHERE [id] = @VacancyID";
                SqlCommand hremailSql = new SqlCommand(hremail, con);
                hremailSql.Parameters.AddWithValue("@VacancyID", id);
                HREmail = hremailSql.ExecuteScalar().ToString();
                con.Close();

                Response.Write(HREmail);

                //create object to store message
                MimeMessage message = new MimeMessage();
                //add sender info to the message
                // TODO replace test@example.com with actual email
                message.From.Add(new MailboxAddress("CursusVia", "test@example.com"));
                //add receiver
                message.To.Add(MailboxAddress.Parse(HREmail));
                //message.To.Add(MailboxAddress.Parse("soonqi03@gmail.com"));//replace with the email from db
                //add message subject
                message.Subject = "Resume for " + jobTitle;
                //create the message body as plain text
                var body = new TextPart("plain")
                {
                    Text = @"This is an auto generated email and the student resume is attached below.
Please directly contact the student if you are interested.

Student Name: " + studentName + " \n" +
"Student Email: " + studentEmail + " \n" +
"Expected Salary: RM" + txtMinSalary.Text
                };

                //get student name
                string filePath;
                con.Open();
                string resume = "SELECT [file_path] FROM [FileResources] WHERE [id] = @fileID";
                SqlCommand fileSql = new SqlCommand(resume, con);
                fileSql.Parameters.AddWithValue("@fileID", file);
                filePath = fileSql.ExecuteScalar().ToString();
                con.Close();

                //create an pdf attachment for file located at path
                var attachment = new MimePart()
                {
                    Content = new MimeContent(File.OpenRead(Server.MapPath(filePath)), ContentEncoding.Default),
                    ContentDisposition = new ContentDisposition(ContentDisposition.Attachment),
                    ContentTransferEncoding = ContentEncoding.Base64,
                    FileName = Path.GetFileName(Server.MapPath(filePath))
                };

                // now create the multipart/mixed container to hold the message text and the
                // image attachment
                var multipart = new Multipart("mixed");
                multipart.Add(body);
                multipart.Add(attachment);

                // now set the multipart/mixed as the message body
                message.Body = multipart;

                //authentication which is a email   
                // TODO replace test@example.com with actual email and verysecurepassword with actual password
                string senderEmail = "test@example.com";
                string password = "verysecurepassword";

                //create smtp cilent
                SmtpClient client = new SmtpClient();

                try
                {
                    //Session["toast"] = new Toast("testing", "success");
                    //Response.Redirect("Vacancy.aspx");
                    //connect to gmail smtp server using port 465 with SSl enabled
                    client.Connect("smtp.gmail.com", 465, true);
                    //need autheticate if use gmail
                    client.Authenticate(senderEmail, password);
                    //Response.Write("authe");
                    client.Send(message);
                    //Response.Redirect("Vacancy.aspx");
                    //success message
                }
                catch (Exception ex)
                {
                    //cause error
                    Session["toast"] = new Toast("Email send failed", "fail");
                    //Response.Redirect("Vacancy.aspx");
                    //Response.Write("<script>alert('Job not applied successfully');window.location = 'Vacancy.aspx';</script>");
                    //Response.Write(ex.Message.ToString());
                }
                finally
                {
                    //disconnect and dispose
                    client.Disconnect(true);
                    client.Dispose();
                }

            }
            if (row > 0)
            {
                Session["toast"] = new Toast("Job applied successfully", "success");
                Response.Redirect("Vacancy.aspx");
                //Response.Write("<script>alert('Job applied successfully');window.location = 'Vacancy.aspx';</script>");
            }
            else
            {
                Session["toast"] = new Toast("Job does not applied successfully", "fail");
                Response.Redirect("Vacancy.aspx");
                //Response.Write("<script>alert('Job does not applied successfully');window.location = 'Vacancy.aspx';</script>");
            }
        }
    }
}