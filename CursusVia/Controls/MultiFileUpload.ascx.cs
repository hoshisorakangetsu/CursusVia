using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Controls
{
    public partial class MultiFileUpload : System.Web.UI.UserControl
    {
        public HiddenField UploadedFileIDs { get { return FileIDS; } }
        public HiddenField DeletedFileIDs { get { return DeletedFileIDS; } }
        /// <summary>
        /// Should be in the format of "1,oriFileName;2,oriFileName2"
        /// </summary>
        public string Files { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}