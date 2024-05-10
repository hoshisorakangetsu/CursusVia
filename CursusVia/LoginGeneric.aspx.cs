using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
	public partial class LoginGeneric : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			string[] retUrl = Request["ReturnUrl"].ToString().Split(new char[] { '/' });

			if (retUrl[1] == "Customer")
			{
				Response.Redirect(@"/Customer/LoginStudent.aspx");
			} else if (retUrl[1] == "Tutor")
			{
				Response.Redirect(@"/Tutor/LoginTutor.aspx");
			}
		}
	}
}