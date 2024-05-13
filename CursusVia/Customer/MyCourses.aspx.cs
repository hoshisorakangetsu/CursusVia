using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class MyCourses : System.Web.UI.Page
    {
        private string studentId;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                studentId = authTicket.Name;
            }

            string finalCommand = @"
                SELECT [c].[id], [c].[title], [c].[description], [c].[price], [fr].[file_path] AS courseImgPath, [t].[name] AS tutorName
                FROM [Courses] c
                INNER JOIN [PurchasedCourses] pc ON [c].[id] = [pc].[course_id]
                INNER JOIN [FileResources] fr ON [c].[cover_pic_res_id] = [fr].[id]
                INNER JOIN [Tutors] t ON [c].[tutor_id] = [t].[id]
                WHERE [pc].[student_id] = @StudentId
            ";
            CourseRepeaterSqlDS.SelectParameters.Add("StudentId", studentId);

            bool NotNullEmptyWhiteSpace(string str) => !(String.IsNullOrEmpty(str) || String.IsNullOrWhiteSpace(str));
            string searchKeyword = Request.Params["search"];
            string category = Request.Params["category"];
            string sortBy = Request.Params["sortby"];
            string tutorName = Request.Params["tutorname"];
            if (NotNullEmptyWhiteSpace(searchKeyword))
            {
                finalCommand += "AND c.[title] LIKE @keyword\n";
                CourseRepeaterSqlDS.SelectParameters.Add("keyword", $"%{searchKeyword}%");
                SearchTextBox.Text = searchKeyword;
            }
            if (NotNullEmptyWhiteSpace(category) && category != "All Category")
            {
                finalCommand += "AND c.[category] = @category\n";
                CourseRepeaterSqlDS.SelectParameters.Add("category", "web_development");
                CourseCategoryFilter.SelectedValue = category;
            }
            if (NotNullEmptyWhiteSpace(tutorName))
            {
                finalCommand += "AND t.[name] LIKE '%@tutorName%'\n";
                CourseRepeaterSqlDS.SelectParameters.Add("tutorName", tutorName);
                UploadedBy.Text = tutorName;
            }
            if (NotNullEmptyWhiteSpace(sortBy))
            {
                SortBy.SelectedValue = sortBy;
                switch (sortBy)
                {
                    case "priceLTH":
                        finalCommand += "ORDER BY c.[price] ASC\n";
                        break;
                    case "priceHTL":
                        finalCommand += "ORDER BY c.[price] DESC\n";
                        break;
                    case "ratingLTH":
                        finalCommand += "ORDER BY rating ASC\n";
                        break;
                    case "ratingHTL":
                        finalCommand += "ORDER BY rating DESC\n";
                        break;
                    default:
                        break;
                }
            }
            CourseRepeaterSqlDS.SelectCommand = finalCommand;
            CourseRepeaterSqlDS.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            CourseRepeater.DataBind();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            bool NotNullEmptyWhiteSpace(string str) => !(String.IsNullOrEmpty(str) || String.IsNullOrWhiteSpace(str));
            string redirectUrl = "Courses.aspx?";

            if (NotNullEmptyWhiteSpace(SearchTextBox.Text))
            {
                redirectUrl += $"search={Server.UrlEncode(SearchTextBox.Text)}&";
            }

            if (NotNullEmptyWhiteSpace(CourseCategoryFilter.SelectedValue))
            {
                redirectUrl += $"category={CourseCategoryFilter.SelectedValue}&";
            }

            if (NotNullEmptyWhiteSpace(SortBy.SelectedValue))
            {
                redirectUrl += $"sortby={SortBy.SelectedValue}&";
            }

            if (NotNullEmptyWhiteSpace(UploadedBy.Text))
            {
                redirectUrl += $"tutorname={Server.UrlEncode(UploadedBy.Text)}&";
            }

            // Remove the trailing '&' and '?' if present
            if (redirectUrl.EndsWith("&") || redirectUrl.EndsWith("?"))
            {
                redirectUrl = redirectUrl.Substring(0, redirectUrl.Length - 1);
            }

            // Redirect to the constructed URL
            Response.Redirect(redirectUrl);

        }
    }
}