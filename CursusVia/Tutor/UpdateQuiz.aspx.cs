using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class UpdateQuiz : System.Web.UI.Page
    {
        private string quizId;
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            quizId = Request.Params["quizId"];
            if (!Page.IsPostBack)
            {
                backControl.NavigateUrl = $"~/Tutor/CourseDetail.aspx?id=" + Request.Params["courseId"];
                questionDS.SelectCommand = @"
                    SELECT 
                        [id] AS QuestionId, 
                        [question] AS QuestionContent, 
                        ROW_NUMBER() OVER(ORDER BY [order] ASC) AS QuestionNumber
                    FROM [QuizQuestions] 
                    WHERE [quiz_id] = @QuizId
                    ORDER BY [order]
                ";
                questionDS.SelectParameters.Clear();
                questionDS.SelectParameters.Add("QuizId", quizId);
                rptQuestions.DataBind();
            }
        }

        protected void AddQuestion_Click(object sender, EventArgs e)
        {
            if (NewQuestionFieldValidator.IsValid)
            {
                string question = NewQuestion.Text;

                // get the latest question
                string selectLastOrderQuery = @"
                    SELECT TOP 1 [order] 
                    FROM [QuizQuestions] qq 
                    INNER JOIN [ChapterQuiz] cq ON [cq].[id] = [qq].[quiz_id] 
                    WHERE [cq].[chapter_id] = @ChapterId 
                    ORDER BY [order] DESC;
                ";
                string chapterId = Request.Params["chapId"];

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    int order;
                    SqlCommand selectLastOrderCommand = new SqlCommand(selectLastOrderQuery, con);
                    selectLastOrderCommand.Parameters.AddWithValue("@ChapterId", chapterId);
                    var lastOrderObj = selectLastOrderCommand.ExecuteScalar();
                    order = lastOrderObj == DBNull.Value ? 1 : Convert.ToInt32(lastOrderObj) + 1;

                    string insertCmd = @"
                        INSERT INTO [QuizQuestions] ([question], [order], [quiz_id])
                        VALUES (@Question, @Order, @QuizId);
                    ";

                    SqlCommand insertCommand = new SqlCommand(insertCmd, con);
                    insertCommand.Parameters.AddWithValue("@Question", question);
                    insertCommand.Parameters.AddWithValue("@Order", order);
                    insertCommand.Parameters.AddWithValue("@QuizId", quizId);
                    int rows = insertCommand.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        Session["toast"] = new Toast("Successfully added quiz", "success");
                    } 
                    else
                    {
                        Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                    }
                    Response.Redirect(Request.RawUrl); // reload to have the repeaters automagically refetch the questions
                }

            }
        }

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "NewAnswer")
            {
                NewAnswer(e);
            }

            if (e.CommandName == "DeleteQuestion")
            {
                DeleteQuestion(e);
            }
        }

        private void DeleteQuestion(RepeaterCommandEventArgs e)
        {
            string questionId = e.CommandArgument.ToString();

            // either all should be executed or none should be if any error, so make it a transaction
            string deleteQuestionCmd = @"
                    BEGIN TRANSACTION;                

                    DELETE FROM [dbo].[QuizAnswers]
                    WHERE [question_id] = @QuestionID;

                    DELETE FROM [dbo].[Answers]
                    WHERE [id] IN (SELECT [answer_id] FROM [dbo].[QuizAnswers] WHERE [question_id] = @QuestionID);

                    DELETE FROM [dbo].[QuizQuestions]
                    WHERE [id] = @QuestionID;

                    COMMIT TRANSACTION;
            ";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand command = new SqlCommand(deleteQuestionCmd, con);
                command.Parameters.AddWithValue("@QuestionID", questionId);

                int rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully deleted quiz", "success");
                }
                else
                {
                    Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                }
                Response.Redirect(Request.RawUrl);
            }
        }

        private void NewAnswer(RepeaterCommandEventArgs e)
        {
            string questionId = e.CommandArgument.ToString();
            string newAnswer = ((TextBox)e.Item.FindControl("NewAnswer")).Text;
            Label label = ((Label)e.Item.FindControl("NewAnswerRequiredText"));

            if (String.IsNullOrEmpty(newAnswer) || String.IsNullOrWhiteSpace(newAnswer))
            {
                label.Visible = true;
                return;
            }
            else if (label.Visible)
            {
                label.Visible = false;
            }

            string insertNewAnswer = @"
                    INSERT INTO [Answers] ([answer_content])
                    VALUES (@AnswerContent);
                    SELECT SCOPE_IDENTITY();
                ";

            string insertNewQuizAnswer = @"
                    INSERT INTO [QuizAnswers] ([answer_id], [question_id], [is_correct])
                    VALUES (@AnswerId, @QuestionId, @IsCorrect);
                ";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(insertNewAnswer, con);
                cmd.Parameters.AddWithValue("@AnswerContent", newAnswer);
                int answerId = Convert.ToInt32(cmd.ExecuteScalar());

                SqlCommand cmd2 = new SqlCommand(insertNewQuizAnswer, con);
                cmd2.Parameters.AddWithValue("@AnswerId", answerId);
                cmd2.Parameters.AddWithValue("@QuestionId", questionId);
                cmd2.Parameters.AddWithValue("@IsCorrect", false);
                int rows = cmd2.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully added quiz answer", "success");
                }
                else
                {
                    Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                }
                Response.Redirect(Request.RawUrl); // reload to have the repeaters automagically refetch the questions
            }
        }

        protected void chkIsCorrect_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox ck = (CheckBox) sender;
            HiddenField quesAndAnsIdControl = (HiddenField)((RepeaterItem)ck.NamingContainer).FindControl("AnswerAndQuestionIdControl");
            string quesAndAnsId = quesAndAnsIdControl.Value;
            bool isCorrect = ck.Checked;

            string[] quesAnsId = quesAndAnsId.Split(';'); // question id is the first element, answer id is the second element

            string updateIsCorrectCmd = @"
                UPDATE [QuizAnswers]
                SET [is_correct] = @IsCorrect
                WHERE [question_id] = @QuestionID
                AND [answer_id] = @AnswerID;
            ";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand command = new SqlCommand(updateIsCorrectCmd, con);
                command.Parameters.AddWithValue("@IsCorrect", isCorrect);
                command.Parameters.AddWithValue("@QuestionID", quesAnsId[0]);
                command.Parameters.AddWithValue("@AnswerID", quesAnsId[1]);
                int rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully updated answer", "success");
                }
                else
                {
                    Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                }
                Response.Redirect(Request.RawUrl); // reload to have the repeaters automagically refetch the questions
            }
        }

        protected void rptAnswer_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteAnswer")
            {
                string quesAndAnsIdStr = e.CommandArgument.ToString();
                string[] quesAndAnsId = quesAndAnsIdStr.Split(';'); // first elem is question id second is answer id

                // either all should be executed or none should be if any error, so make it a transaction
                string deleteAnsCmd = @"
                    BEGIN TRANSACTION; 

                    DELETE FROM [dbo].[QuizAnswers]
                    WHERE [answer_id] = @AnswerID
                    AND [question_id] = @QuestionID;

                    DELETE FROM [Answers]
                    WHERE [id] = @AnswerID;

                    COMMIT TRANSACTION;
                ";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(deleteAnsCmd, con);
                    cmd.Parameters.AddWithValue("@AnswerID", quesAndAnsId[1]);
                    cmd.Parameters.AddWithValue("@QuestionID", quesAndAnsId[0]);

                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        Session["toast"] = new Toast("Successfully deleted answer", "success");
                    }
                    else
                    {
                        Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                    }
                    Response.Redirect(Request.RawUrl);
                }
            }
        }

        protected void QuizQuestionModalBtn_Click(object sender, EventArgs e)
        {
            string questionId = QuizQuestionID.Value;
            string newQuestion = EditQuizQuestion.Text;

            string updateQuestionCmd = @"
                UPDATE [QuizQuestions]
                SET [question] = @NewQuestion
                WHERE [id] = @QuestionID;
            ";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand command = new SqlCommand(updateQuestionCmd, con);
                command.Parameters.AddWithValue("@NewQuestion", newQuestion);
                command.Parameters.AddWithValue("@QuestionID", questionId);

                int rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully updated quiz answers", "success");
                }
                else
                {
                    Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                }
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void QuizAnswerModalBtn_Click(object sender, EventArgs e)
        {
            string answerId = QuizAnswerIDAnswerModal.Value;
            string newAnswer = EditQuizAnswer.Text;

            string updateAnswerCmd = @"
                UPDATE [dbo].[Answers]
                SET [answer_content] = @NewAnswer
                WHERE [id] = @AnswerID;
            ";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand command = new SqlCommand(updateAnswerCmd, con);
                command.Parameters.AddWithValue("@NewAnswer", newAnswer);
                command.Parameters.AddWithValue("@AnswerID", answerId);

                int rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully updated answers", "success");
                }
                else
                {
                    Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                }
                Response.Redirect(Request.RawUrl);
            }
        }
    }
}