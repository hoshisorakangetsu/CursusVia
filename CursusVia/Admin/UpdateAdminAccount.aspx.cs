using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CursusVia.Admin
{
    public partial class UpdateAdminAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
          
            //Response.Redirect("~/Admin/UpdateConfirmation.aspx");
            Response.Redirect("~/Admin/UpdateConfirmation.aspx");

        }


    }
}