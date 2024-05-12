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
    public partial class CreateQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string courseId = Request.Params["courseId"];
            string chapId = Request.Params["chapId"];
            string quizTitle = Request.Params["quizTitle"];
            string cmd = "INSERT INTO [ChapterQuiz] ([chapter_id], [quiz_title]) VALUES (@ChapId, @QuizTitle); SELECT SCOPE_IDENTITY();";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                SqlCommand command = new SqlCommand(cmd, con);
                command.Parameters.AddWithValue("@ChapId", chapId);
                command.Parameters.AddWithValue("@QuizTitle", quizTitle);

                int quizId = Convert.ToInt32(command.ExecuteScalar());
                Response.Redirect("~/Tutor/UpdateQuiz.aspx?quizId=" + quizId + "&chapId=" + chapId + "&courseId=" + courseId);
            }
        }
    }
}