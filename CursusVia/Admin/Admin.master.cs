using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // TODO highlight the repeater based on nested url
                var currentUrl = new Uri(Request.Url.ToString());

                if (((SiteMapNode)e.Item.DataItem).Url != null && currentUrl.LocalPath.Contains(((SiteMapNode)e.Item.DataItem).Url))
                {
                    ((HyperLink)e.Item.FindControl("HyperLink1")).CssClass += " active";
                }
            }
        }

    }
}