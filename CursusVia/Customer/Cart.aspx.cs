using CursusVia.Customer;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
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
                if (authCookie == null || !AuthenticateUser(authCookie))
                {
                    Response.Redirect("LoginStudent.aspx");

                 
                }

                BindGrid();
            }
           
        }

        private bool AuthenticateUser(HttpCookie authCookie)
        {
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
            return ticket != null &&
                   !string.IsNullOrEmpty(ticket.Name) &&
                   int.TryParse(ticket.Name, out studentId);
        }

        private void BindGrid()
        {
            CartItemDataAccess dataAccess = new CartItemDataAccess();
            GridView1.DataSource = dataAccess.GetCartItems(studentId);
            GridView1.DataBind();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (GridView1.DataKeys.Count > e.RowIndex && e.RowIndex >= 0)
            {
                int itemId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
                CartItemDataAccess dataAccess = new CartItemDataAccess();
                dataAccess.DeleteCartItems(new List<int> { itemId });
                BindGrid(); // Rebind to update the view
            }
            else
            {
                // Handle error or log it
                Debug.WriteLine("Invalid row index or empty DataKeys.");
            }
        }

        public class CartItemDataAccess
        {
            private string connectionString = Global.CS;

            public DataTable GetCartItems(int studentId)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string sql = @"SELECT ci.id AS CartItemId, c.title AS Title, c.description AS Description, c.price AS Price, fr.file_path AS ImagePath 
                       FROM dbo.CartItems ci 
                       JOIN dbo.Courses c ON ci.course_id = c.id 
                       JOIN dbo.FileResources fr ON c.cover_pic_res_id = fr.id 
                       WHERE ci.student_id = @StudentId";
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@StudentId", studentId);
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    // Debug output to check column names
                    foreach (DataColumn col in dt.Columns)
                    {
                        System.Diagnostics.Debug.WriteLine("Column: " + col.ColumnName);
                    }

                    return dt;
                }
            }

            public void DeleteCartItems(List<int> ids)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    foreach (int id in ids)
                    {
                        SqlCommand cmd = new SqlCommand("DELETE FROM CartItems WHERE id = @id", conn);
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                    conn.Close();
                }
            }
        }

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            List<int> idsToDelete = new List<int>();
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
                    int itemId = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    idsToDelete.Add(itemId);
                }
            }

            if (idsToDelete.Count > 0)
            {
                CartItemDataAccess dataAccess = new CartItemDataAccess();
                dataAccess.DeleteCartItems(idsToDelete);
                BindGrid();
            }


            Response.Redirect("Cart.aspx");
        }
    }
}

/*  private int studentId;
        private int cartItemId;
        SqlConnection conn = new SqlConnection (Global.CS);
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
                CartGridView.DataSource = cartItems;
                CartGridView.DataBind();
            }
            else
            {
                // Handle cases where the student ID is not available
                Response.Redirect("Cart.aspx");
            }
        }













        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            // Iterate through the GridView
            foreach (GridViewRow row in CartGridView.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
                    // Find the value of the CartItemId in the row
                    int cartItemId = Convert.ToInt32(CartGridView.DataKeys[row.RowIndex].Value);

                    // Call the method to delete the item
                    DeleteCartItem(cartItemId);
                }
            }

            // Rebind the GridView to show the updated list
            BindCart();
        }

        private void DeleteCartItem(int cartItemId)
        {
            string connectionString = Global.CS;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM CartItems WHERE id = @CartItemId", con))
                {
                    cmd.Parameters.AddWithValue("@CartItemId", cartItemId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
*/