using CursusVia.Customer;
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
        private int studentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
                if (authCookie != null)
                {
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                    if (ticket != null && !string.IsNullOrEmpty(ticket.Name))
                    {
                        if (int.TryParse(ticket.Name, out int parsedId))
                        {
                            studentId = parsedId;
                            System.Diagnostics.Debug.WriteLine("Student ID set to: " + studentId);
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("Failed to parse student ID.");
                            Response.Redirect("LoginStudent.aspx");
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("Ticket is null or empty.");
                        Response.Redirect("LoginStudent.aspx");
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Authentication cookie is missing.");
                    Response.Redirect("LoginStudent.aspx");
                }
            }
            BindCart();
        }

        private DataTable GetCartItems(int studentId)
        {
            DataTable dt = new DataTable();
            string connectionString = Global.CS;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = @"
            SELECT
                ci.id AS CartItemId,
                c.title AS Title,
                c.description AS Description,
                c.price AS Price,
                fr.file_path AS ImagePath
            FROM
                dbo.CartItems ci
            INNER JOIN
                dbo.Courses c ON ci.course_id = c.id
            INNER JOIN
                dbo.FileResources fr ON c.cover_pic_res_id = fr.id
            WHERE
                ci.student_id = @StudentId;
        ";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
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
            if (studentId > 0)  // Check if studentId is greater than 0
            {
                DataTable cartItems = GetCartItems(studentId);
                CartRepeater.DataSource = cartItems;
                CartRepeater.DataBind();
            }
            else
            {
                // Handle cases where the student ID is not available
                Response.Redirect("LoginStudent.aspx");
            }
        }

        private void RemoveItemFromCart(int itemId)
        {
            string connectionString = Global.CS;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM CartItems WHERE id = @ItemId";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@ItemId", itemId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        protected void CartRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
        
                if (e.CommandName == "Remove")
                {
                    int itemId = Convert.ToInt32(e.CommandArgument);
                    RemoveItemFromCart(itemId);  // Handle item removal from DB
                    BindCart(); // Re-bind to update the UI
                }
         
        }
    }
}
