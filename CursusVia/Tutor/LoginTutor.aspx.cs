using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
	public partial class LoginTutor : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void lbtnShowLogin_Click(object sender, EventArgs e)
        {
			pnlLogin.Visible = !pnlLogin.Visible;
			pnlRegister.Visible = false;
		}

		protected void lbtnShowRegister_Click(object sender, EventArgs e)
		{
			pnlRegister.Visible = !pnlRegister.Visible;
			pnlLogin.Visible = false;
		}

		protected void lbtnForgetPass_Click(object sender, EventArgs e)
		{
			pnlForgetPw.Visible = !pnlForgetPw.Visible;
			pnlLogin.Visible = false;
			pnlRegister.Visible = false;
		}
	}
}