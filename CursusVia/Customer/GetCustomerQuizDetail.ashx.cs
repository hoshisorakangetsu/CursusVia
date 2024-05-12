using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CursusVia.Customer
{
    /// <summary>
    /// Summary description for GetCustomerQuizDetail
    /// </summary>
    public class GetCustomerQuizDetail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
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