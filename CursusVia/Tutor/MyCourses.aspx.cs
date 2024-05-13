using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class MyCourses : System.Web.UI.Page
    {
        private string tutorId = "2";
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                tutorId = authTicket.Name;
            }
            if (!Page.IsPostBack)
            {
                FetchTutorCourse();
            }
        }

        private void FetchTutorCourse()
        {
            string cmd = @"
                SELECT 
                    c.[id],
                    c.[title],
                    c.[price],
                    f.[file_path] AS courseImgPath,
                    ISNULL((
                        SELECT AVG(rating)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS ratingCount,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id
                    ), 0) AS enrollCount
                FROM 
                    [Courses] c
                INNER JOIN 
                    [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE 
                    c.[tutor_id] = @TutorId
            ";
            bool NotNullEmptyWhiteSpace(string str) => !(String.IsNullOrEmpty(str) || String.IsNullOrWhiteSpace(str));
            string searchKeyword = Request.Params["search"];
            if (NotNullEmptyWhiteSpace(searchKeyword))
            {
                cmd += "AND c.[title] LIKE @keyword\n";
                CourseRepeaterSqlDS.SelectParameters.Add("keyword", $"%{searchKeyword}%");
                SearchTextBox.Text = searchKeyword;
            }

            CourseRepeaterSqlDS.SelectCommand = cmd;
            CourseRepeaterSqlDS.SelectParameters.Add("TutorId", tutorId.ToString());
            CourseRepeaterSqlDS.ConnectionString = cs;
            CourseRepeater.DataBind();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            bool NotNullEmptyWhiteSpace(string str) => !(String.IsNullOrEmpty(str) || String.IsNullOrWhiteSpace(str));
            string redirectUrl = "/Tutor/MyCourses.aspx?";

            if (NotNullEmptyWhiteSpace(SearchTextBox.Text))
            {
                redirectUrl += $"search={Server.UrlEncode(SearchTextBox.Text)}&";
            }

            // Remove the trailing '&' and '?' if present
            if (redirectUrl.EndsWith("&") || redirectUrl.EndsWith("?"))
            {
                redirectUrl = redirectUrl.Substring(0, redirectUrl.Length - 1);
            }

            // Redirect to the constructed URL
            Response.Redirect(redirectUrl);

        }

        protected void CourseRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCourse")
            {
                int courseId = Convert.ToInt32(e.CommandArgument.ToString());
                // check if the course they try to delete alrd has ppl enrolled
                string selectCourseEnrollCount = "SELECT COUNT(*) FROM [PurchasedCourses] WHERE [course_id] = @courseId";
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand command = new SqlCommand(selectCourseEnrollCount, con);
                    command.Parameters.AddWithValue("@courseId", courseId);
                    int rows = Convert.ToInt32(command.ExecuteScalar());
                    if (rows > 0)
                    {
                        Session["toast"] = new Toast($"Cannot delete course that already has student enrolled", "fail");
                        Response.Redirect(Request.RawUrl);
                    }

                    string vidResourceIdCmd = @"
                        SELECT vid_res_id 
                        FROM ChapterContents 
                        WHERE chapter_id IN (SELECT id FROM Chapters WHERE course_id=@courseId);
                    ";

                    List<string> resourceId = new List<string>();

                    using (SqlCommand cmd =  new SqlCommand(vidResourceIdCmd, con))
                    {
                        cmd.Parameters.AddWithValue("@courseId", courseId);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                resourceId.Add(dr["vid_res_id"].ToString());
                            }
                        }
                    }

                    string contentResourceIdCmd = @"
                        SELECT resource_id 
                        FROM ContentResources 
                        WHERE content_id IN 
                            (SELECT cc.id FROM ChapterContents cc WHERE chapter_id IN (
                                SELECT c.id FROM Chapters c WHERE course_id = @courseId
                            ));
                    ";

                    using (SqlCommand cmd = new SqlCommand(contentResourceIdCmd, con))
                    {
                        cmd.Parameters.AddWithValue("@courseId", courseId);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                resourceId.Add(dr["resource_id"].ToString());
                            }
                        }
                    }

                    string courseResourceIdCmd = @"
                        SELECT cover_pic_res_id 
                        FROM Courses 
                        WHERE id = @courseId
                    ";

                    using (SqlCommand cmd = new SqlCommand(courseResourceIdCmd, con))
                    {
                        cmd.Parameters.AddWithValue("@courseId", courseId);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                resourceId.Add(dr["cover_pic_res_id"].ToString());
                            }
                        }
                    }


                    // delete statement to delete the entire course
                    string deleteQuiz = @"
                        BEGIN TRANSACTION;
                        DELETE FROM QuizAnswers WHERE question_id IN (SELECT id FROM QuizQuestions WHERE quiz_id IN (SELECT id FROM ChapterQuiz WHERE chapter_id IN (SELECT id FROM Chapters WHERE course_id = @courseId)));
                        DELETE FROM QuizQuestions WHERE quiz_id IN (SELECT cq.id FROM ChapterQuiz cq WHERE chapter_id IN (SELECT c.id FROM Chapters c WHERE course_id = @courseId));
                        DELETE FROM ChapterQuiz WHERE chapter_id IN (SELECT c.id FROM Chapters c WHERE course_id = @courseId);
                        DELETE FROM ChapterContents WHERE chapter_id IN (SELECT c.id FROM Chapters c WHERE course_id = @courseId);
                        DELETE FROM Chapters WHERE course_id = @courseId;
                        DELETE FROM Courses WHERE id = @courseId;
                        COMMIT TRANSACTION;
                    ";

                    int affectedRows;

                    using (SqlCommand cmd = new SqlCommand(deleteQuiz, con))
                    {
                        cmd.Parameters.AddWithValue("@courseId", courseId);
                        affectedRows = cmd.ExecuteNonQuery();
                    }

                    foreach (var resId in resourceId)
                    {
                        Util.DeleteFile(Convert.ToInt32(resId), Server);
                    }

                    if (affectedRows > 0)
                    {
                        Session["toast"] = new Toast($"Course deleted successfully", "success");
                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
        }
    }
}