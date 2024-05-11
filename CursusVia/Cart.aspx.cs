using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private void BindCart()
        {
            // Simulated cart data - replace this with actual data retrieval
            var cartItems = new[]
            {
            new { Id = 1, Image="PNG", Title= "Course 1", Description = "xxxx", Price = 15.00},
            new { Id = 2, Image="PNG", Title= "Course 1 2",Description = "xxxx", Price = 30.00},
            new { Id = 3, Image="PNG", Title= "Course 1 3", Description ="xxxx", Price =25.00},
            new { Id = 4, Image="PNG",  Title= "Course 1", Description ="xxxx", Price=15.00},
            new { Id = 1, Image="PNG", Title= "Course 1", Description = "xxxx", Price = 15.00},
            new { Id = 2, Image="PNG", Title= "Course 1 2",Description = "xxxx", Price = 30.00},
            new { Id = 3, Image="PNG", Title= "Course 1 3", Description ="xxxx", Price =25.00},
            new { Id = 4, Image="PNG",  Title= "Course 1", Description ="xxxx", Price=15.00}
        };
            CartRepeater.DataSource = cartItems;
            CartRepeater.DataBind();
        }

        protected void CartRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName== "Remove")
            {
                int itemId = Convert.ToInt32(e.CommandArgument);
                // Add logic here to remove the item from the cart
                BindCart(); // Re-bind to update the UI
            }
        }
    }
}