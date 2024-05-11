using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class CourseContent : System.Web.UI.Page
    {
        // TODO change this to get from cookie
        private string customerId = "1";
        private string courseId;
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Request.Params["id"];
            CourseDetailHeroDS.SelectCommand = @"
                SELECT 
                    [c].[id],
                    [c].[title] AS courseName,
                    [c].[description] AS courseDesc,
                    [f].[file_path] AS courseImgPath,
                    [t].[name] AS tutorName,
                    [t].[qualifications] AS certification,
                    ISNULL((
                        SELECT AVG([rating])
                        FROM [TutorRatings] AS tr
                        WHERE [tr].[tutor_id] = [t].[id]
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT([rating])
                        FROM [TutorRatings] tr
                        WHERE [tr].[tutor_id] = [t].[id]
                    ), 0) AS ratingCount,
                    ISNULL((
                        SELECT COUNT(*)
                        FROM [Courses] AS co
                        WHERE [co].[tutor_id] = [t].[id]
                    ), 0) AS courseNum
                FROM 
                    [Courses] c
                INNER JOIN 
                    [Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN 
                    [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE
                    [c].[id] = @CourseId;
            ";
            CourseDetailHeroDS.SelectParameters.Clear();
            CourseDetailHeroDS.SelectParameters.Add("CourseId", courseId);
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
            ChapterDS.SelectParameters.Clear();
            ChapterDS.SelectParameters.Add("CourseId", courseId);
            ChapterRepeater.DataBind();

            InitRatingSection();
        }

        protected void InitRatingSection()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                string selectCourseRatingCmd = @"
                    SELECT [pc].[rating] AS course_rating 
                    FROM [PurchasedCourses] pc
                    WHERE [pc].[course_id] = @CourseId
                    AND [pc].[student_id] = @CustomerId
                ";
                SqlCommand command1 = new SqlCommand(selectCourseRatingCmd, con);
                command1.Parameters.AddWithValue("@CourseId", courseId);
                command1.Parameters.AddWithValue("@CustomerId", customerId);
                string courseRatingStr = command1.ExecuteScalar().ToString();
                if (!String.IsNullOrEmpty(courseRatingStr))
                {
                    CourseRating.SelectedValue = courseRatingStr;
                    CourseRating.Enabled = false;
                }

                string selectTutorRatingCmd = @"
                    SELECT [tr].[rating] AS tutor_rating 
                    FROM [TutorRatings] tr
                    INNER JOIN [Courses] c ON [tr].[tutor_id] = [c].[tutor_id]
                    WHERE [c].[id] = @CourseId
                    AND [tr].[student_id] = @CustomerId
                ";
                SqlCommand command2 = new SqlCommand( selectTutorRatingCmd, con);
                command2.Parameters.AddWithValue("@CourseId", courseId);
                command2.Parameters.AddWithValue("@CustomerId", customerId);
                string tutorRatingStr = command2.ExecuteScalar().ToString();
                if (!String.IsNullOrEmpty(tutorRatingStr))
                {
                    TutorRating.SelectedValue = tutorRatingStr;
                    TutorRating.Enabled = false;
                    SubmitRating.Enabled = false;
                }
            }
        }

        protected void SubmitRating_Click(object sender, EventArgs e)
        {
            // can do this becuz whole page only that two 
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string updateCourseRatingCmd = @"
                        UPDATE [PurchasedCourses] 
                        SET [rating] = @Rating 
                        WHERE [student_id] = @CustomerId AND [course_id] = @CourseId
                    ";
                    SqlCommand command1 = new SqlCommand(updateCourseRatingCmd, con);
                    command1.Parameters.AddWithValue("@Rating", CourseRating.SelectedValue);
                    command1.Parameters.AddWithValue("@CustomerId", customerId);
                    command1.Parameters.AddWithValue("@CourseId", courseId);
                    int affectedCourseRating = command1.ExecuteNonQuery();

                    // get tutor id of this course
                    string selectTutorIdCmd = "SELECT [tutor_id] FROM [Courses] WHERE [id] = @CourseId";
                    SqlCommand command2 = new SqlCommand(selectTutorIdCmd, con);
                    command2.Parameters.AddWithValue("@CourseId", courseId);
                    int tutorId = Convert.ToInt32(command2.ExecuteScalar());

                    string insertQuery = "INSERT INTO [TutorRatings] ([student_id], [tutor_id], [rating]) VALUES (@CustomerId, @TutorId, @Rating)";
                    SqlCommand command3 = new SqlCommand(insertQuery, con);
                    command3.Parameters.AddWithValue("@Rating", CourseRating.SelectedValue);
                    command3.Parameters.AddWithValue("@CustomerId", customerId);
                    command3.Parameters.AddWithValue("@TutorId", tutorId);
                    int affectedTutorRating = command3.ExecuteNonQuery();

                    if (affectedTutorRating > 0 && affectedCourseRating > 0) 
                    {
                        Response.Redirect(Request.RawUrl);
                    }
                }
            }
        }
    }
}