using CursusVia.Customer;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class PayementSuccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket != null)
                {
                    string studId = ticket.Name;
                    string cartIdStr = Request.Params["ids"];
                    string paymentAmount = Request.Params["amount"];
                    string cartIdStripped = cartIdStr.Substring(1, cartIdStr.Length - 2);
                    //test.Text = cartIdStripped;

                    DateTime paymentDate = DateTime.Now;
                    string transactionMethod = "Stripe";

                    string[] cartIds = cartIdStripped.Split(',');
                    string query = "INSERT INTO Payments (payment_amount, payment_date, transaction_method, student_id) " +
                       "VALUES (@PaymentAmount, @PaymentDate, @TransactionMethod, @StudentId); SELECT SCOPE_IDENTITY();";

                    int paymentId;
                    // Create connection and command objects
                    using (SqlConnection connection = new SqlConnection(Global.CS))
                    {

                        connection.Open();
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            // Add parameters
                            command.Parameters.AddWithValue("@PaymentAmount", paymentAmount);
                            command.Parameters.AddWithValue("@PaymentDate", paymentDate);
                            command.Parameters.AddWithValue("@TransactionMethod", transactionMethod);
                            command.Parameters.AddWithValue("@StudentId", studId);
                            paymentId = Convert.ToInt32(command.ExecuteScalar());
                        }
                        foreach (string id in cartIds)
                        {
                            string getCourseIdCmd = "SELECT course_id FROM CartItems WHERE id=@cartId";
                            int courseId;
                            using (SqlCommand command = new SqlCommand(getCourseIdCmd, connection))
                            {
                                // Add parameters
                                command.Parameters.AddWithValue("@cartId", id);
                                courseId = Convert.ToInt32(command.ExecuteScalar());
                            }
                            string insertIntoPurchasedCourse = "INSERT INTO PurchasedCourses (course_id, student_id, payment_id) VALUES (@CourseId, @StudentId, @PaymentId);";
                            using (SqlCommand command = new SqlCommand(insertIntoPurchasedCourse, connection))
                            {
                                // Add parameters
                                command.Parameters.AddWithValue("@CourseId", courseId);
                                command.Parameters.AddWithValue("@StudentId", studId);
                                command.Parameters.AddWithValue("@PaymentId", paymentId);
                                courseId = Convert.ToInt32(command.ExecuteScalar());
                            }
                            string deleteFromCart = "SELECT course_id FROM CartItems WHERE id=@cartId";

                            using (SqlCommand command = new SqlCommand(deleteFromCart, connection))
                            {
                                // Add parameters
                                command.Parameters.AddWithValue("@cartId", id);
                                command.ExecuteNonQuery();
                            }
                        }
                    }
                    Response.Redirect("~/Customer/MyCourses.aspx");
                    Session["sessionId"] = null;
                }
            }
        }
    }
}