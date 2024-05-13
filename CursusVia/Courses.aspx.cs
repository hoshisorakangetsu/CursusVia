using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class Courses : System.Web.UI.Page
    {
        private string custId;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                custId = authTicket.Name;
            }

            if (!Page.IsPostBack)
            {
                FetchCourses();
            }
        }

        private void FetchCourses()
        {
            // the where 1=1 is to make afterwards adding additional where clauses with AND clause easier to handle
            string finalCommand = @"
                SELECT 
                    c.[id],
                    c.[title],
                    c.[price],
                    f.[file_path] AS courseImgPath,
                    t.[name] AS tutorName,
                    ISNULL((
                        SELECT AVG(rating)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS rating,
                    ISNULL((
                        SELECT COUNT(rating)
                        FROM [PurchasedCourses] pc
                        WHERE pc.course_id = c.id AND pc.rating > 0
                    ), 0) AS ratingCount
                FROM 
                    [Courses] c
                INNER JOIN 
                    [Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN 
                    [FileResources] f ON c.[cover_pic_res_id] = f.[id]
                WHERE
                    1 = 1
            ";
            // only used in course related files so I figure no need to extract out yet
            bool NotNullEmptyWhiteSpace(string str) => !(String.IsNullOrEmpty(str) || String.IsNullOrWhiteSpace(str));
            string searchKeyword = Request.Params["search"];
            string category = Request.Params["category"];
            string priceMin = Request.Params["pricemin"];
            string priceMax = Request.Params["pricemax"];
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
                CourseRepeaterSqlDS.SelectParameters.Add("category", category);
                CourseCategoryFilter.SelectedValue = category;
            }
            if (NotNullEmptyWhiteSpace(priceMin))
            {
                finalCommand += "AND c.[price] >= @minPrice\n";
                CourseRepeaterSqlDS.SelectParameters.Add("minPrice", System.Data.DbType.Decimal, priceMin);
                MinPrice.Text = priceMin;
            }

            if (NotNullEmptyWhiteSpace(priceMax))
            {
                finalCommand += "AND c.[price] <= @maxPrice\n";
                CourseRepeaterSqlDS.SelectParameters.Add("maxPrice", System.Data.DbType.Decimal, priceMax);
                MaxPrice.Text = priceMax;
            }
            if (NotNullEmptyWhiteSpace(tutorName))
            {
                finalCommand += "AND t.[name] LIKE '%@tutorName%'\n";
                CourseRepeaterSqlDS.SelectParameters.Add("tutorName", tutorName);
                UploadedBy.Text = tutorName;
            }
            if (NotNullEmptyWhiteSpace(custId))
            {
                finalCommand += "AND c.[id] NOT IN (SELECT pc.[course_id] FROM [PurchasedCourses] pc WHERE pc.[student_id] = @custId)\n";
                CourseRepeaterSqlDS.SelectParameters.Add("custId", custId);
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

            if (NotNullEmptyWhiteSpace(MinPrice.Text))
            {
                redirectUrl += $"pricemin={MinPrice.Text}&";
            }

            if (NotNullEmptyWhiteSpace(MaxPrice.Text))
            {
                redirectUrl += $"pricemax={MaxPrice.Text}&";
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