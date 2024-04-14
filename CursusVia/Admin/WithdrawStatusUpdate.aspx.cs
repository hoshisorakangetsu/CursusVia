using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class WithdrawStatusUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpate_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/UpdateConfirmation.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            //back to withdraw Request
            Response.Redirect("/Admin/WithdrawalRequest.aspx");
        }
    }
}