using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class CourseContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string courseId = Request.Params["id"];
            CourseDetailHeroDS.SelectCommand = @"
                SELECT 
                    [c].[id],
                    [c].[title] AS courseName,
                    [c].[description] AS courseDesc,
                    [f].[file_path] AS courseImgPath,
                    [t].[name] AS tutorName,
                    [t].[qualifications] AS certification,
                    ISNULL((
                        SELECT AVG([rating])
                        FROM [TutorRatings] AS tr
                        WHERE [tr].[tutor_id] = [t].[id]
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT([rating])
                        FROM [TutorRatings] tr
                        WHERE [tr].[tutor_id] = [t].[id]
                    ), 0) AS ratingCount,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [Courses] AS co
                        WHERE [co].[tutor_id] = [t].[id]
                    ), 0) AS courseNum
                FROM 
                    [Courses] c
                INNER JOIN 
                    [Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN 
                    [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE
                    [c].[id] = @CourseId;
            ";
            CourseDetailHeroDS.SelectParameters.Clear();
            CourseDetailHeroDS.SelectParameters.Add("CourseId", courseId);
            CourseDetailHeroView.DataBind();

            // for chapters repeater
            ChapterDS.SelectCommand = @"
                SELECT 
                    [c].[id] AS ChapterId, 
                    [c].[title] AS ChapterTitle,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [ChapterContents]
                        WHERE chapter_id = [c].id
                    ), 0) + ISNULL((
                        SELECT COUNT(*)
                        FROM [ChapterQuiz]
                        WHERE chapter_id = [c].id
                    ), 0) AS ItemCount,
                    [c].[course_id] AS CourseId
                FROM [Chapters] c
                WHERE course_id = @CourseId;
            ";
            ChapterDS.SelectParameters.Clear();
            ChapterDS.SelectParameters.Add("CourseId", courseId);
            ChapterRepeater.DataBind();
        }
    }
}