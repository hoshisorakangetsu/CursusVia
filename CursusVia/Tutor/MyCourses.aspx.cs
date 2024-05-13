using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
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
                string courseId = e.CommandArgument.ToString();
                // check if the course they try to delete alrd has ppl enrolled
                string selectCourseEnrollCount = "SELECT COUNT(*) FROM [PurchasedCourses] WHERE [course_id] = @courseId";
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand command = new SqlCommand(selectCourseEnrollCount, con);
                    command.Parameters.AddWithValue("@courseId", courseId);
                }
                Toast t = new Toast($"Deleting Course {e.CommandArgument}", "fail");
                Session["toast"] = t;
                //Response.Write($"<script>alert({e.CommandArgument})</script>");
            }
        }
    }
}