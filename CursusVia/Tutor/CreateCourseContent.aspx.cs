using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class CreateCourseContent : System.Web.UI.Page
    {
        private string courseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Request.Params["id"];
            if (courseId == null)
            {
                Response.Redirect("~/Tutor/MyCourses.aspx");
            }

        }
    }
}