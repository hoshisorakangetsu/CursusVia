﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class Tutor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			if (!User.Identity.IsAuthenticated)
			{
				Response.Redirect("LoginTutor.aspx");
			}
		}

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReadTutorInformation.aspx");
        }

		protected void Button2_Click(object sender, EventArgs e)
		{
			Response.Redirect("UpdateDetailsTutor.aspx");
		}

		protected void Button3_Click(object sender, EventArgs e)
		{
			Response.Redirect("UpdatePasswordTutor.aspx");
		}

		protected void Button4_Click(object sender, EventArgs e)
		{
			Response.Redirect("DeleteTutor.aspx");
		}

		protected void Button5_Click(object sender, EventArgs e)
		{
			Response.Redirect("TutorRatings.aspx");
		}
	}
}