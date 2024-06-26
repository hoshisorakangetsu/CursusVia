﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace CursusVia
{
    public class Toast
    {
        public string Msg { get; set; }
        public string Type { get; set; }
        public Toast(string msg, string type) { Msg = msg; Type = type; }
    }
    public class Util
    {

        public static int UploadFile(HttpPostedFile file, HttpServerUtility server)
        {
            Int32 uploadedId;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                Directory.CreateDirectory(server.MapPath("~/files/"));
                SqlCommand cmd = new SqlCommand("INSERT INTO FileResources(file_path, file_name) VALUES(@filepath, @orifilename); SELECT SCOPE_IDENTITY()", con);
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

                SqlCommand cmd = new SqlCommand("SELECT * FROM FileResources WHERE id=@id", con);
                cmd.Parameters.AddWithValue("@id", fileId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string path = (string)dr["file_path"];
                    string oriFileName = (string)dr["file_name"];
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

        public static void DeleteFile(int fileId, HttpServerUtility server)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {

                SqlCommand cmd = new SqlCommand("SELECT * FROM FileResources WHERE id=@id", con);
                cmd.Parameters.AddWithValue("@id", fileId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string path = server.MapPath((string)dr["file_path"]);
                    if (System.IO.File.Exists(path))
                    {
                        System.IO.File.Delete(path);
                    }
                }
            }
        }


        public static class SecurityHelper
        {
            public static string HashPassword(string password)
            {
                using (var provider = new SHA256Managed())
                {
                    byte[] inputBytes = Encoding.UTF8.GetBytes(password);
                    byte[] hashedBytes = provider.ComputeHash(inputBytes);
                    return BitConverter.ToString(hashedBytes).Replace("-", "");
                }
            }
        }
    }
}