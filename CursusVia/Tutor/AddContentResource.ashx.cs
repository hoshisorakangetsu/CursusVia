using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CursusVia.Tutor
{
    public class AddContentResource : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["file"];


            int id = Util.UploadFile(file, context.Server);

            context.Response.ContentType = "text/plain";
            context.Response.Write(id);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}