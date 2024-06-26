﻿using System;
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
    public partial class CreateCourse : System.Web.UI.Page
    {
        private string tutorId; 
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                tutorId = authTicket.Name;
            }

            backControl.NavigateUrl = $"~/MyCourses.aspx";
        }

        protected void submitForm_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            if (!Page.IsValid) { return; }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                int fileId = Util.UploadFile(CourseImgUploadWithPreview.MediaFileUpload.PostedFile, Server);
                // should actually handle upload file error here
                if (fileId == 0) { return; }
                string cmd = @"
                    INSERT INTO [Courses] ([title], [description], [price], [cover_pic_res_id], [tutor_id], [category]) 
                    VALUES (@Title, @Description, @Price, @CoverPicResId, @TutorId, @Category)
                ";
                SqlCommand command = new SqlCommand(cmd, con);
                command.Parameters.AddWithValue("@Title", CourseTitle.Text);
                command.Parameters.AddWithValue("@Description", Description.Text);
                command.Parameters.AddWithValue("@Price", Convert.ToDouble(Price.Text));
                command.Parameters.AddWithValue("@CoverPicResId", fileId);
                command.Parameters.AddWithValue("@TutorId", tutorId);
                command.Parameters.AddWithValue("@Category", CourseCategory.SelectedValue);

                int rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    Session["toast"] = new Toast("Successfully created course", "success");
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