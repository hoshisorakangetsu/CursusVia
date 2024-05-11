using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class MyCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string studentId = "1";
            string finalCmd = @"
                SELECT [c].[id], [c].[title], [c].[description], [c].[price], [fr].[file_path] AS courseImgPath, [t].[name] AS tutorName
                FROM [Courses] c
                INNER JOIN [PurchasedCourses] pc ON [c].[id] = [pc].[course_id]
                INNER JOIN [FileResources] fr ON [c].[cover_pic_res_id] = [fr].[id]
                INNER JOIN [Tutors] t ON [c].[tutor_id] = [t].[id]
                WHERE [pc].[student_id] = @StudentId
            ";
            CourseRepeaterSqlDS.SelectCommand = finalCmd;
            CourseRepeaterSqlDS.SelectParameters.Clear();
            CourseRepeaterSqlDS.SelectParameters.Add("StudentId", studentId);
            CourseRepeaterSqlDS.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            CourseRepeater.DataBind();
        }
    }
}