using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
    public partial class UpdateCourse : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private string courseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Request.Params["id"];
            if (!Page.IsPostBack)
            {
                if (courseId == null)
                {
                    Response.Redirect("~/Tutor/MyCourses.aspx");
                }
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string cmd = @"
                        SELECT 
                            c.[id],
                            c.[title],
                            c.[description],
                            c.[price],
                            c.[cover_pic_res_id],
                            c.[tutor_id],
                            c.[category],
                            f.[file_path] AS cover_pic_file_path
                        FROM 
                            [dbo].[Courses] c
                        INNER JOIN 
                            [dbo].[FileResources] f ON c.[cover_pic_res_id] = f.[id]
                        WHERE 
                            c.[id] = @CourseId;
                    ";
                    SqlCommand command = new SqlCommand(cmd, con);
                    command.Parameters.AddWithValue("@CourseId", courseId);
                    SqlDataReader dr = command.ExecuteReader();
                    if (dr.Read())
                    {
                        CourseTitle.Text = dr["title"].ToString();
                        Price.Text = Convert.ToDecimal(dr["price"]).ToString("0.00");
                        Description.Text = dr["description"].ToString();
                        CourseCategory.SelectedValue = dr["category"].ToString();
                        CourseImgUploadWithPreview.Src = dr["cover_pic_file_path"].ToString().Substring(1);
                    } else
                    {
                        Response.Redirect("~/Tutor/MyCourses.aspx");
                    }
                }
            }
        }

        protected void submitForm_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs)) 
            { 
                con.Open();
                string cmd = @"
                    UPDATE [dbo].[Courses]
                    SET 
                        [title] = @Title,
                        [description] = @Description,
                        [price] = @Price,
                ";
                string hasFileCmd = "[cover_pic_res_id] = @CoverPicResId,";
                string cmd2 = @"
                    [category] = @Category
                    WHERE 
                        [id] = @CourseId;
                ";

                string finalCmd = cmd;
                if (CourseImgUploadWithPreview.MediaFileUpload.HasFile)
                {
                    finalCmd += hasFileCmd;
                }
                finalCmd += cmd2;
                SqlCommand command = new SqlCommand(finalCmd, con);
                command.Parameters.AddWithValue("@Title", CourseTitle.Text);
                command.Parameters.AddWithValue("@Description", Description.Text);
                command.Parameters.AddWithValue("@Price", Convert.ToDouble(Price.Text));
                if (CourseImgUploadWithPreview.MediaFileUpload.HasFile)
                {
                    int fileId = Util.UploadFile(CourseImgUploadWithPreview.MediaFileUpload.PostedFile, Server);
                    // should actually handle upload file error here
                    if (fileId == 0) { return; }
                    command.Parameters.AddWithValue("@CoverPicResId", fileId);
                }
                command.Parameters.AddWithValue("@Category", CourseCategory.SelectedValue);
                command.Parameters.AddWithValue("@CourseId", courseId);
                int rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully updated course", "success");
                    Response.Redirect("MyCourses.aspx");
                }
                else
                {
                    Session["toast"] = new Toast("Oops! Something unexpected happened, please hang on tight while we attempt to fix it.", "fail");
                    Response.Redirect("MyCourses.aspx");
                }
            }
        }
    }
}