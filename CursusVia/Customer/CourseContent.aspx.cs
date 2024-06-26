﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class CourseContent : System.Web.UI.Page
    {
        private string customerId;
        private string courseId;
        private readonly string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                customerId = authTicket.Name;
            }

            courseId = Request.Params["id"];
            backControl.NavigateUrl = $"~/MyCourses.aspx";

            // check if the student has purchased this course
            CheckHasPurchased();

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

            CustomerChapterOverview.CourseId = courseId; // dk why server inline tags aren't working

            InitRatingSection();
        }

        protected void CheckHasPurchased()
        {
            string query = "SELECT COUNT(*) FROM PurchasedCourses WHERE student_id = @customerId AND course_id = @courseId";

            using (SqlConnection connection = new SqlConnection(cs))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@customerId", customerId);
                    command.Parameters.AddWithValue("@courseId", courseId);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    // Check if the user has purchased the course
                    if (count == 0)
                    {
                        Session["toast"] = new Toast("It seems like you have not bought this course yet", "fail");
                        Response.Redirect("~/Customer/MyCourses.aspx");
                    }
                    // No need for an else block; if purchased, the function exits without redirecting
                }
            }
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
                using (SqlCommand command1 = new SqlCommand(selectCourseRatingCmd, con))
                {
                    command1.Parameters.AddWithValue("@CourseId", courseId);
                    command1.Parameters.AddWithValue("@CustomerId", customerId);
                    object courseRating = command1.ExecuteScalar();
                    if (courseRating != DBNull.Value)
                    {
                        CourseRating.SelectedValue = courseRating.ToString();
                        CourseRating.Enabled = false;
                    }
                }

                string selectTutorRatingCmd = @"
                    SELECT [tr].[rating] AS tutor_rating 
                    FROM [TutorRatings] tr
                    INNER JOIN [Courses] c ON [tr].[tutor_id] = [c].[tutor_id]
                    WHERE [c].[id] = @CourseId
                    AND [tr].[student_id] = @CustomerId
                ";
                using (SqlCommand command2 = new SqlCommand(selectTutorRatingCmd, con))
                {
                    command2.Parameters.AddWithValue("@CourseId", courseId);
                    command2.Parameters.AddWithValue("@CustomerId", customerId);
                    object tutorRating = command2.ExecuteScalar();
                    if (tutorRating != null && tutorRating != DBNull.Value)
                    {
                        TutorRating.SelectedValue = tutorRating.ToString();
                        TutorRating.Enabled = false;
                        SubmitRating.Enabled = false;
                    }
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
                        Session["toast"] = new Toast("Successfully submitted ratings", "success");
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
}