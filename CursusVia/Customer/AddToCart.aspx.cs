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
                    try
                    {
                        FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                        studentId = Convert.ToInt32(authTicket.Name);
                    }
                    catch (Exception ex)
                    {
                        // Log error
                        Response.Redirect("~/ErrorPage.aspx?ErrorMessage=Unable to process your request."); // Generic error message for the user
                    }
                }
                else
                {
                    Response.Redirect("LoginStudent.aspx");
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string courseId = Request.Params["courseId"];
            if (!string.IsNullOrEmpty(courseId) && studentId > 0)
            {
                string connectionString = Global.CS; // Assuming Global.CS is your connection string
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

                    Response.Redirect("~/Cart.aspx"); // Redirect to the cart page or a confirmation page
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
            }
        }
    }
}
