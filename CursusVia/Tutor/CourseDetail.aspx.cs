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
    public partial class CourseDetail : System.Web.UI.Page
    {
        private string courseId;
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Request.Params["id"];
            CourseDetailHeroDS.SelectCommand = @"
                SELECT t.[name] AS tutorName, c.[title], c.[description], f.[file_path] AS courseImgPath, c.[id]
                FROM [Courses] c
                INNER JOIN [Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE c.[id] = @CourseId;
            ";
            if (!Page.IsPostBack) CourseDetailHeroDS.SelectParameters.Add("CourseId", courseId);
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
            if (!Page.IsPostBack) ChapterDS.SelectParameters.Add("CourseId", courseId);
            ChapterRepeater.DataBind();
        }

        protected void ChapterModalBtn_Click(object sender, EventArgs e)
        {
            string chapId = ChapterModalId.Value; // -1 for new chapter
            string newText = ChapterTitleTxt.Text;
            int affectedRows;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                if (ModalType.Value == "QUIZ")
                {
                    Response.Redirect("~/Tutor/CreateQuiz.aspx?chapId=" + chapId + "&courseId=" + courseId + "&quizTitle=" + newText);
                } else
                {
                    if (chapId == "-1")
                    {
                        affectedRows = NewChapter(newText, con);
                    } else
                    {
                        affectedRows = UpdateChapter(chapId, newText, con);
                    }
                    Response.Redirect("~/Tutor/CourseDetail.aspx?id=" + courseId);
                }
            }

        }

        private int NewChapter(string chapTitle, SqlConnection con)
        {
            string cmd = @"
                INSERT INTO [Chapters] ([title], [course_id])
                VALUES (@ChapterTitle, @CourseID);
            ";

            SqlCommand command = new SqlCommand(cmd, con);
            command.Parameters.AddWithValue("@ChapterTitle", chapTitle);
            command.Parameters.AddWithValue("@CourseID", courseId);

            return command.ExecuteNonQuery();
        }

        private int UpdateChapter(string id, string chapTitle, SqlConnection con)
        {
            string cmd = "UPDATE [Chapters] SET [title] = @NewChapterTitle WHERE [id] = @ChapterID";

            SqlCommand command = new SqlCommand(cmd, con);
            command.Parameters.AddWithValue("@NewChapterTitle", chapTitle);
            command.Parameters.AddWithValue("@ChapterID", id);

            return command.ExecuteNonQuery();
        }
    }
}