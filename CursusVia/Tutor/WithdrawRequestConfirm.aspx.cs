using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class WithdrawRequestConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnWithdrawal_Click(object sender, EventArgs e)
        {
            //back to the status page
            Response.Redirect("~/Tutor/WithdrawRequestStatus.aspx");
        }

        protected void btnCanWithdrawal_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Tutor/WithdrawRequest.aspx");
        }
    }
}