using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class ViewWithdraw : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCanWithdrawal_Click(object sender, EventArgs e)
        {
            // Redirect the user to the WithdrawalSubmission.aspx page
            Response.Redirect("~/Tutor/WithdrawalSubmission.aspx");
        }

        protected void btnWithdrawal_Click(object sender, EventArgs e)
        {
            // Redirect the user to the WithdrawRequest.aspx page
            Response.Redirect("~/Tutor/WithdrawRequest.aspx");
        }
    }
}