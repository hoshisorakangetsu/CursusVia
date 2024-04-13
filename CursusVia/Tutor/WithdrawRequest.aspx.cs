using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class WithdrawRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect the user to theWithdrawalSubmission  page
            Response.Redirect("~/Tutor/WithdrawalSubmission.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Redirect the user to the ViewBalacne Details  page
            Response.Redirect("~/Tutor/WithdrawRequestConfirm.aspx");
        }
    }
    }
