using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace CursusVia.Customer
{
    /// <summary>
    /// Provide question id, return the list of correct answers for the question
    /// </summary>
    public class GetCustomerQuizDetail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string questionId = context.Request.Params["questionId"];
            List<string> correctAnswers = new List<string>();
            string selectCorrectAnswersCmd = "SELECT [answer_id] FROM [QuizAnswers] WHERE [question_id] = @QuestionId AND [is_correct] = 1;";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                SqlCommand command = new SqlCommand(selectCorrectAnswersCmd, con);
                command.Parameters.AddWithValue("@QuestionId", questionId);

                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    string answerId = reader["answer_id"].ToString();
                    correctAnswers.Add(answerId);
                }

            }

            context.Response.ContentType = "text/json";
            context.Response.Write("[" + String.Join(",", correctAnswers.ToArray()) + "]"); // return in js array
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}