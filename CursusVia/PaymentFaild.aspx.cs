using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class PaymentFaild : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["sessionId"] = null;
            Response.Write("<script>alert('Payment unsuccessful! Please try again'); location.href = '~/Customer/Courses.aspx';</script>");
            Response.Redirect("~/Customer/Cart.aspx");
        }
    }
}