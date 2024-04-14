using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
	public partial class DeleteTutor : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void Button1_Click(object sender, EventArgs e)
        {
			Response.Redirect("deleteMsg.aspx");
        }

		protected void Button2_Click(object sender, EventArgs e)
		{
			Response.Redirect("LogoutMsg.aspx");
		}
	}
}