using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class CreateCourseContent : System.Web.UI.Page
    {
        private string chapterId;
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            chapterId = Request.Params["chapId"];
            if (chapterId == null)
            {
                Response.Redirect("~/Tutor/MyCourses.aspx");
            }

        }

        protected void submitForm_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string selectLastOrderQuery = "SELECT TOP 1 [order] FROM [ChapterContents] WHERE [chapter_id] = @ChapterId ORDER BY [order] DESC;";

                int order;
                SqlCommand selectLastOrderCommand = new SqlCommand(selectLastOrderQuery, con);
                selectLastOrderCommand.Parameters.AddWithValue("@ChapterId", chapterId);
                var lastOrderObj = selectLastOrderCommand.ExecuteScalar();
                order = lastOrderObj == DBNull.Value ? 1 : Convert.ToInt32(lastOrderObj) + 1;

                int vidId = Util.UploadFile(FileUploadWithPreview.MediaFileUpload.PostedFile, Server);

                if (vidId == 0) { return; }

                string cmd = "INSERT INTO [ChapterContents] ([title], [content], [order], [vid_res_id],  [chapter_id]) VALUES (@Title, @Content, @Order, @VidId, @ChapterId); SELECT SCOPE_IDENTITY();";

                SqlCommand command = new SqlCommand(cmd, con);
                command.Parameters.AddWithValue("@Title", ContentTitle.Text);
                command.Parameters.AddWithValue("@Content", Description.Text);
                command.Parameters.AddWithValue("@Order", order);
                command.Parameters.AddWithValue("@VidId", vidId);
                command.Parameters.AddWithValue("@ChapterId", chapterId);

                int contentId = Convert.ToInt32(command.ExecuteScalar());
                if (contentId > 0)
                {
                    HandleFileResources(contentId);
                    
                    Session["toast"] = new Toast("Successfully added quiz", "success");
                    Response.Redirect("~/Tutor/CourseDetail.aspx?id=" + Request.Params["courseId"]);
                }
            }
        }

        private void HandleFileResources(int contentId)
        {
            // straight forward in create content, just split the file ids and insert them, and delete the files
            string[] uploadedIDs = MultiFileUpload.UploadedFileIDs.Value.Split(',');
            string[] deletedIDs = MultiFileUpload.DeletedFileIDs.Value.Split(',');

            foreach (var id in deletedIDs)
            {
                if (!String.IsNullOrEmpty(id))
                {
                    Util.DeleteFile(Convert.ToInt32(id), Server); 
                }
            }

            foreach (var id in uploadedIDs)
            {
                if (String.IsNullOrEmpty(id)) continue;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string cmd = "INSERT INTO ContentResources([content_id], [resource_id]) VALUES (@ContentId, @ResourceId)";
                    SqlCommand command = new SqlCommand(cmd, con);
                    command.Parameters.AddWithValue("@ContentId", contentId);
                    command.Parameters.AddWithValue("@ResourceId", id);

                    command.ExecuteNonQuery();
                }
            }
        }
    }
}