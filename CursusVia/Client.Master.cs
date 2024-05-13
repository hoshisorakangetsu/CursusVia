using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class Client : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["toast"] != null)
            {
                Toast t = (Toast)Session["toast"];
                Page.ClientScript.RegisterStartupScript(this.GetType(), "createToast", $"<script defer>setTimeout(() => makeToast('{t.Msg}', '{t.Type}'), 100)</script>", false);
                // clearing session does not work send help
                Session["toast"] = null;
            }
        }
    }
}