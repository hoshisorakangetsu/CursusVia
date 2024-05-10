using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Controls
{
    public partial class FileUploadWithPreview : System.Web.UI.UserControl
    {
        public bool IsRequired { get; set; }
        public FileUpload MediaFileUpload { get { return _MediaFileUpload; } }
        public string Src { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}