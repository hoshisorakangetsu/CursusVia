using CursusVia.Tutor;
using System;
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
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                if (authCookie != null)
                {
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                    if (ticket != null && !string.IsNullOrEmpty(ticket.UserData))
                    {
                        // Assuming UserData field is used to store the studentId securely
                        if (int.TryParse(ticket.UserData, out int parsedId))
                        {
                            studentId = parsedId;
                            System.Diagnostics.Debug.WriteLine("Student ID parsed successfully: " + studentId);
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("Failed to parse Student ID.");
                            Response.Redirect("LoginStudent.aspx");
                        }
                    }
                 
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

                    Response.Redirect("~/Customer/Cart.aspx"); // Redirect to the cart page or a confirmation page
                }
                catch (SqlException sqlEx)
                {
                    // Log the exception
                    Response.Write("<script>alert('Database error: " + sqlEx.Message + "');</script>"); // Show a simple alert to the user
                }
                catch (Exception ex)
                {
                    // Log the exception
                    Response.Redirect("~/ErrorPage.aspx?ErrorMessage=Unable to add item to cart."); // Redirect to a generic error page
                }
            }
            else
            {
                Response.Write("<script>alert('Invalid course information provided. Please try again.');</script>"); // Inform the user about the invalid input
                System.Diagnostics.Debug.WriteLine("Course ID: " + courseId); // Check the output in your IDE's output window

            }
        }


    }
}
