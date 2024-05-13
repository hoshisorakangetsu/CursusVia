using CursusVia.Customer;
using Org.BouncyCastle.Crypto;
using Stripe;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;

namespace CursusVia
{
    public partial class Cart : Page
    {
        private int studentId;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // since for test only and is in assignment will be pushing the key directly to version control
                StripeConfiguration.ApiKey = "sk_test_51PFuSUJsbFY19ohRW0C3PKDFDInv5DchhrAACTRY8CTTrcYj57OWHWTnOPuplS0Hg1tVP7KiE23PQJMj1ogNhnsB00ZtiThM0T";

                BindGrid();
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
            Response.Redirect(Request.RawUrl); // Redirect to the same pag
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
        }

        private void CreateCheckoutSession(List<int> idsToPurchase, decimal price)
        {
            string baseUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);


            var options = new SessionCreateOptions
            {
                LineItems = new List<SessionLineItemOptions>
                {
                    new SessionLineItemOptions
                    {
                        PriceData = new SessionLineItemPriceDataOptions
                        {
                            UnitAmount = (int)(price*100),
                            Currency = "myr",
                            ProductData = new SessionLineItemPriceDataProductDataOptions
                            {
                                Name = $"Purchasing {idsToPurchase.Count} Courses",
                            },
                        },
                        Quantity = 1,
                    },
                },
                Mode = "payment",
                SuccessUrl = $"{baseUrl}/PayementSuccess.aspx?ids=[{String.Join(",", idsToPurchase)}]&amount={price}",
                CancelUrl = $"{baseUrl}/PaymentFaild.aspx",
            };

            var service = new SessionService();
            Session session = service.Create(options);

            // Store the session ID in the session state
            Session["sessionId"] = session.Id;
        }

        protected void SelectForCheckout_Click(object sender, EventArgs e)
        {
            string connectionString = Global.CS;

            List<int> idsToPurchase = new List<int>();
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
                    int itemId = Convert.ToInt32(((HiddenField)row.FindControl("cartIdHiddenField")).Value);
                    idsToPurchase.Add(itemId);
                }
            }

            decimal coursePrice = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                foreach (var id in idsToPurchase)
                {
                    string cmd = "SELECT price FROM Courses c WHERE c.id = (SELECT ci.course_id FROM CartItems ci WHERE ci.id = @cartId)";
                    SqlCommand command = new SqlCommand(cmd, conn);
                    command.Parameters.AddWithValue("@cartId", id);
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            coursePrice += Convert.ToDecimal(dr["price"]);
                        }
                    }
                }
                conn.Close();
            }
            lblSubtotal.Text = "RM" + coursePrice.ToString("0.00");
            lblTotal.Text = coursePrice.ToString("0.00");

            CreateCheckoutSession(idsToPurchase, Convert.ToDecimal(lblTotal.Text));
        }
    }
}