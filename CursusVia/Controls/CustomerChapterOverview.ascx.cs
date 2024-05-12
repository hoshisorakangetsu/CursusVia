using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class CustomerChapterOverview : System.Web.UI.UserControl
    {
        public string CourseId {  get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
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
            ChapterDS.SelectParameters.Add("CourseId", CourseId);
            ChapterRepeater.DataBind();
        }
    }
}