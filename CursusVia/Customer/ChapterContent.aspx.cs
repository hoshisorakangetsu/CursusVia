using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class ChapterContent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string contentId = Request.Params["contentId"];
            string courseId = Request.Params["courseId"];
            ChapterContentDS.SelectCommand = @"
                SELECT [cc].[title], [cc].[content], [fr].[file_path] 
                FROM [ChapterContents] cc 
                INNER JOIN [FileResources] fr ON [cc].[vid_res_id] = [fr].[id] 
                WHERE [cc].[id] = @ContentId
            ";

            ChapterContentDS.SelectParameters.Clear();
            ChapterContentDS.SelectParameters.Add("ContentId", contentId);
            ChapterContentView.DataBind();
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

        protected void FileResources_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DownloadFile")
            {
                string fileId = e.CommandArgument.ToString();
                Util.DownloadFile(Convert.ToInt32(fileId), Server);
            }
        }
    }
}