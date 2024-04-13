using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CursusVia.Customer
{
    public partial class PaymentConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCanWithdrawal_Click(object sender, EventArgs e)
        {
            //Return to the pament details page
            Response.Redirect("~/Customer/Payment.aspx");
        }

        protected void btnWithdrawal_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SuccsessfulMessage.aspx"); 
        }
    }
}