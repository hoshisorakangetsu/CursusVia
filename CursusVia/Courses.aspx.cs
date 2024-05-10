using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // doesn't care whether if it is postback, make the repeater fetch everytime the page loads
            string finalCommand = @"
                SELECT 
                    c.[id],
                    c.[title],
                    c.[price],
                    f.[file_path] AS courseImgPath,
                    t.[name] AS tutorName
                FROM 
                    [dbo].[Courses] c
                INNER JOIN 
                    [dbo].[Tutors] t ON c.[tutor_id] = t.[id]
                INNER JOIN 
                    [dbo].[FileResources] f ON c.[cover_pic_res_id] = f.[id];
            ";
            CourseRepeaterSqlDS.SelectCommand = finalCommand;
            CourseRepeaterSqlDS.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            CourseRepeater.DataBind();
        }
    }
}