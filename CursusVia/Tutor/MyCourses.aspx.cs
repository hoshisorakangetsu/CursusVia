using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class MyCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO change me to get from cookie
            int tutorId = 2;
            string cmd = @"
                SELECT 
                    c.[id],
                    c.[title],
                    c.[price],
                    f.[file_path] AS courseImgPath,
                    ISNULL((
                        SELECT AVG(rating)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS ratingCount,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id
                    ), 0) AS enrollCount
                FROM 
                    [Courses] c
                INNER JOIN 
                    [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE 
                    c.[tutor_id] = @TutorId
            ";
            CourseRepeaterSqlDS.SelectCommand = cmd + ";";
            CourseRepeaterSqlDS.SelectParameters.Add("TutorId", tutorId.ToString());
            CourseRepeaterSqlDS.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            CourseRepeater.DataBind();

        }
    }
}