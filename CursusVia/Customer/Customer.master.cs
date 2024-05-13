using CursusVia.Tutor;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
    public partial class CustomerMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string tutorId;
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

            if (authCookie != null)
            {
                FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                tutorId = authTicket.Name;
            }
            if (!Page.IsPostBack)
            {
                ProfileCardDS.SelectCommand = "SELECT name, email FROM Students WHERE id = @AdminId";
                ProfileCardDS.SelectParameters.Add("AdminId", authCookie.Values["AdminID"]);
                ProfileCard.DataBind();
            }
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