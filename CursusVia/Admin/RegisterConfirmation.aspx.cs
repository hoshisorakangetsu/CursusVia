﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class RegisterConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/AdminAccount.aspx");
        }




    }
}