using System;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace CursusVia.Customer
{
    public partial class AddToCart : Page
    {
        private int studentId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
                if (authCookie != null)
                {
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                    if (ticket != null && !ticket.Expired)
                    {
                        if (int.TryParse(ticket.Name, out int userId))
                        {
                            studentId = userId;
                            HiddenStudentId.Value = studentId.ToString();
                        }
                    }
                }
            }
            else
            {
                if (int.TryParse(HiddenStudentId.Value, out int savedId))
                {
                    studentId = savedId;
                  
                }
            }
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string courseId = Request.Params["courseId"];
            if (!string.IsNullOrEmpty(courseId) && studentId > 0)
            {
                string connectionString = Global.CS;
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string sql = "INSERT INTO CartItems (course_id, student_id) VALUES (@CourseId, @StudentId)";
                        using (SqlCommand command = new SqlCommand(sql, conn))
                        {
                            command.Parameters.AddWithValue("@CourseId", Convert.ToInt32(courseId));
                            command.Parameters.AddWithValue("@StudentId", studentId);
                            command.ExecuteNonQuery();  // ExecuteNonQuery as we are inserting
                        }
                    }

                    Response.Redirect("~/Customer/Cart.aspx");

                }
                catch (SqlException sqlEx)
                {
                    // Log the exception (ideally to a file or server log)
                    Response.Write("<script>alert('Database error: " + HttpUtility.HtmlEncode(sqlEx.Message) + "');</script>"); // Show a simple alert to the user
                }
                catch (Exception ex)
                {
                    // Log the exception (ideally to a file or server log)
                    Response.Redirect("~/ErrorPage.aspx?ErrorMessage=" + HttpUtility.UrlEncode("Unable to add item to cart.")); // Redirect to a generic error page
                }
            }
            else
            {
                Response.Write("<script>alert('Invalid course information provided. Please try again.');</script>"); // Inform the user about the invalid input
               
            }
        }
    }
}
