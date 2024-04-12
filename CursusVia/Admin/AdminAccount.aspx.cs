using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class AdminAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnShowRegister_Click(object sender, EventArgs e)
        {

            // Toggle visibility of the registration panel
            pnlRegister.Visible = !pnlRegister.Visible;
            pnlLogin.Visible = false;
        }

        protected void lbtnShowLogin_Click(object sender, EventArgs e)
        {
            // Toggle visibility of the Logoin panel
            pnlLogin.Visible = !pnlLogin.Visible;
            pnlRegister.Visible = false;
        }
    }
}