using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class CourseDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string courseId = Request.Params["id"];
            CourseDetailHeroDS.SelectCommand = @"
                SELECT t.[name] AS tutorName, c.[title], c.[description], f.[file_path] AS courseImgPath, c.[id]
                FROM [Courses] c
                INNER JOIN [Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE c.[id] = @CourseId
            ";
            CourseDetailHeroDS.SelectParameters.Add("CourseId", courseId);
            CourseDetailHeroDS.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            CourseDetailHeroView.DataBind();
        }
    }
}