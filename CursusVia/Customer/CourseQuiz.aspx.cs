using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class CourseQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // post back wont happen in this page (no controls for it to trigger post back, most of the stuff populated by csharp and js take over with AJAX
            string courseId = Request.Params["courseId"];
            backControl.NavigateUrl = $"~/CourseContent.aspx?id={courseId}";
            CustomerChapterOverviewControl.CourseId = courseId; // dk why server inline tags aren't working

            string quizId = Request.Params["quizId"];
            QuestionDS.SelectCommand = @"
                    SELECT 
                        [id] AS QuestionId, 
                        [question] AS QuestionContent, 
                        ROW_NUMBER() OVER(ORDER BY [order] ASC) AS QuestionNumber
                    FROM [QuizQuestions] 
                    WHERE [quiz_id] = @QuizId
                    ORDER BY [order]
                ";
            QuestionDS.SelectParameters.Clear();
            QuestionDS.SelectParameters.Add("QuizId", quizId);
            RptQuestions.DataBind();
        }
    }
}