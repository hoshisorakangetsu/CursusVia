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

            CustomerChapterOverview.CourseId = courseId; // dk why server inline tags aren't working
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