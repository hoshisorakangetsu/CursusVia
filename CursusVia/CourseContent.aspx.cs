using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class CourseContent : System.Web.UI.Page
    {
        private string courseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Request.Params["id"];
            CourseDetailHeroDS.SelectCommand = @"
                SELECT 
                    [c].[id],
                    [c].[title] AS courseName,
                    [c].[description] AS courseDesc,
                    [c].[price],
                    [f].[file_path] AS courseImgPath,
                    [t].[name] AS tutorName,
                    ISNULL((
                        SELECT AVG(rating)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT(rating)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS ratingCount
                FROM 
                    [Courses] c
                INNER JOIN 
                    [Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN 
                    [FileResources] f ON c.[cover_pic_res_id] = f.[id];
            ";
            CourseDetailHeroDS.SelectParameters.Clear();
            CourseDetailHeroDS.SelectParameters.Add("CourseId", courseId);
            CourseDetailHeroView.DataBind();
        }
    }
}