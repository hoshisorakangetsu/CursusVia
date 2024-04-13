using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class WithdrawalSubmission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void btnWithdraw_Click(object sender, EventArgs e)
        {
            // Redirect the user to the ViewWithdraw.aspx page
             Response.Redirect("~/Tutor/ViewWithdraw.aspx");
        }
    }
}