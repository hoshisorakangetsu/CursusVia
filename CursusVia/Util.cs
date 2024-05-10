using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

namespace CursusVia
{
    public class Util
    {
        public static int UploadFile(HttpPostedFile file, HttpServerUtility server)
        {
            Int32 uploadedId;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                Directory.CreateDirectory(server.MapPath("~/files/"));
                SqlCommand cmd = new SqlCommand("INSERT INTO Files(FilePath, OriFileName) VALUES(@filepath, @orifilename); SELECT SCOPE_IDENTITY()", con);
                string filePath = "~/files/" + System.Guid.NewGuid().ToString("N") + "." + file.FileName.Split('.').Last();
                file.SaveAs(server.MapPath(filePath));
                con.Open();

                cmd.Parameters.AddWithValue("@filepath", filePath);
                cmd.Parameters.AddWithValue("@orifilename", file.FileName);

                try
                {
                    uploadedId = Convert.ToInt32(cmd.ExecuteScalar());
                } catch (Exception)
                {
                    uploadedId = 0;
                }

            }            
            return uploadedId;
        }

        public static void DownloadFile(int fileId, HttpServerUtility server)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM Files WHERE id=@id", con);
                cmd.Parameters.AddWithValue("@id", fileId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string path = (string)dr["FilePath"];
                    string oriFileName = (string)dr["OriFileName"];
                    string contentType = MimeMapping.GetMimeMapping(server.MapPath(path));
                    HttpResponse response = HttpContext.Current.Response;
                    response.ClearContent();
                    response.Clear();
                    response.ContentType = contentType;
                    // standard header needed by the client to know that we wanna make them download stuff
                    response.AddHeader("Content-Disposition", "attachment; filename=" + oriFileName + ";");
                    // get file size and add to header so client knows how large the file is when it is being downloaded
                    FileInfo fi = new FileInfo(server.MapPath(path));
                    response.AddHeader("Content-Length", fi.Length.ToString());
                    response.TransmitFile(server.MapPath(path));
                    response.Flush();
                    response.End();
                }

            }
        }
    }
}