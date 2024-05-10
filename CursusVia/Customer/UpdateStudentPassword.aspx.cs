using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
	public partial class UpdateStudentPassword : System.Web.UI.Page
	{
		
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			if (User.Identity.IsAuthenticated)
			{
				//HttpContext ctx=HttpContext.Current;
				HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
				string encryptedTicket = authCookie.Value;
				FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(encryptedTicket);
				string id = authTicket.Name;

			}
			}
	}
}