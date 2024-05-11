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

            TutorDS.SelectCommand = @"
                SELECT
                    [T].[name] AS tutorName,
                    [T].[qualifications] AS certification,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [Courses] AS CO
                        WHERE [CO].[tutor_id] = [T].[id]
                    ), 0) AS courseNum,
                    ISNULL((
                        SELECT AVG([rating])
                        FROM [TutorRatings] AS TR
                        WHERE [TR].[tutor_id] = [T].[id]
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT([rating])
                        FROM [TutorRatings] TR
                        WHERE [TR].[tutor_id] = [T].[id]
                    ), 0) AS ratingCount
                FROM
                    [Tutors] T, [Courses] C
                WHERE
                    [C].[id] = @CourseId
            ";
            TutorDS.SelectParameters.Clear();
            TutorDS.SelectParameters.Add("CourseId", courseId);
            TutorView.DataBind();
        }
    }
}