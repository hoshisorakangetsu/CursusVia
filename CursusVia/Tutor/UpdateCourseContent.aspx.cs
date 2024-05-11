using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class UpdateCourseContent : System.Web.UI.Page
    {
        private string contentId;
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString + ";" + "MultipleActiveResultSets=true";
        protected void Page_Load(object sender, EventArgs e)
        {
            contentId = Request.Params["contentId"];
            if (contentId == null)
            {
                Response.Redirect("~/Tutor/MyCourses.aspx");
            }
            if (!Page.IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string cmd = @"
                        SELECT [cc].[title], [cc].[content], [fr].[file_path] 
                        FROM [ChapterContents] cc 
                        INNER JOIN [FileResources] fr ON [cc].[vid_res_id] = [fr].[id] 
                        WHERE [cc].[id] = @ContentId
                    ";

                    using (SqlCommand command = new SqlCommand(cmd, con))
                    {
                        command.Parameters.AddWithValue("@ContentId", contentId);

                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            ContentTitle.Text = reader["title"].ToString();
                            Description.Text = reader["content"].ToString();
                            FileUploadWithPreview.Src = reader["file_path"].ToString().Substring(1);
                        }
                    }

                    string cmd2 = @"
                        SELECT [fr].[id] AS fileId, [fr].[file_name] AS fileName
                        FROM [ContentResources] cr
                        INNER JOIN [FileResources] fr ON [cr].[resource_id] = [fr].[id]
                        WHERE [cr].[content_id] = @ContentId;
                    ";
                    using (SqlCommand command = new SqlCommand(cmd2, con))
                    {
                        command.Parameters.AddWithValue("@ContentId", contentId);
                        SqlDataReader reader = command.ExecuteReader();
                        string files = "";
                        while (reader.Read())
                        {
                            files += reader["fileId"].ToString() + "," + reader["fileName"].ToString() + ";";
                        }
                        MultiFileUpload.Files = files;
                    }
                }
            }
        }

        protected void submitForm_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string cmd = @"
                    UPDATE [ChapterContents]
                    SET [title] = @Title, [content] = @Description
                ";
                string hasFileCmd = "[vid_res_id] = @VidResId,";
                string cmd2 = "WHERE [id] = @ContentId;";

                string finalCmd = cmd;
                if (FileUploadWithPreview.MediaFileUpload.HasFile)
                {
                    finalCmd += hasFileCmd;
                }
                finalCmd += cmd2;

                SqlCommand command = new SqlCommand(finalCmd, con);
                command.Parameters.AddWithValue("@Title", ContentTitle.Text);
                command.Parameters.AddWithValue("@Description", Description.Text);
                if (FileUploadWithPreview.MediaFileUpload.HasFile)
                {
                    int fileId = Util.UploadFile(FileUploadWithPreview.MediaFileUpload.PostedFile, Server);
                    if (fileId == 0) { return; }
                    command.Parameters.AddWithValue("@VidResId", fileId);
                }
                command.Parameters.AddWithValue("@ContentId", contentId);

                command.ExecuteNonQuery();

                HandleFileResources(Convert.ToInt32(contentId));
                Response.Redirect("~/Tutor/CourseDetail.aspx?id=" + Request.Params["courseId"]);
            }
        }

        private void HandleFileResources(int contentId)
        {
            // not straight forward in update content, split the file ids and insert them, check if the deleted id exists in the content resources table and delete it and then delete the files
            string[] uploadedIDs = MultiFileUpload.UploadedFileIDs.Value.Split(',');
            string[] deletedIDs = MultiFileUpload.DeletedFileIDs.Value.Split(',');

            foreach (var id in deletedIDs)
            {
                if (!String.IsNullOrEmpty(id))
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        con.Open();
                        string cmd = "DELETE FROM [ContentResources] WHERE [content_id] = @ContentId AND [resource_id] = @ResourceId";
                        SqlCommand command = new SqlCommand(cmd, con);
                        command.Parameters.AddWithValue("@ContentId", contentId);
                        command.Parameters.AddWithValue("@ResourceId", id);

                        command.ExecuteNonQuery();
                    }

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