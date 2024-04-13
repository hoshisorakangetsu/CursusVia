using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class Student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("ReadStudentInfo.aspx");
        }

		protected void Button2_Click(object sender, EventArgs e)
		{
			Response.Redirect("UpdateStudentDetails.aspx");
		}

		protected void Button3_Click(object sender, EventArgs e)
		{
			Response.Redirect("UpdateStudentPassword.aspx");

		}

		protected void Button4_Click(object sender, EventArgs e)
		{
			Response.Redirect("DeleteStudent.aspx");
		}
	}
}