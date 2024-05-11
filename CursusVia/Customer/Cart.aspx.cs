using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private int? GetStudentIdFromCookie()
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null && !string.IsNullOrEmpty(authCookie.Value))
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                return int.Parse(ticket.Name);  // Assuming the Name stores the student ID
            }
            return null;
        }

        private DataTable GetCartItems(int studentId)
        {
            DataTable dt = new DataTable();
            string connectionString = Global.CS;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT CartItems.id, Courses.image AS Image, Courses.title AS Title, Courses.description AS Description, Courses.price AS Price FROM CartItems JOIN Courses ON CartItems.course_id = Courses.id WHERE CartItems.student_id = @StudentId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@StudentId", studentId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        private void BindCart()
        {
            int? studentId = GetStudentIdFromCookie();
            if (studentId != null)
            {
                DataTable cartItems = GetCartItems(studentId.Value);
                CartRepeater.DataSource = cartItems;
                CartRepeater.DataBind();
            }
            else
            {
                // Handle cases where the student ID is not available
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void CartRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int itemId = Convert.ToInt32(e.CommandArgument);
                RemoveItemFromCart(itemId);  //  handle item removal from DB
                BindCart(); // Re-bind to update the UI
            }
        }

        private void RemoveItemFromCart(int itemId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM CartItems WHERE id = @ItemId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ItemId", itemId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
