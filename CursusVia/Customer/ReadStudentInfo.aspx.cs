using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Customer
{
	public partial class ReadStudentInfo : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

			if (!IsPostBack)
			{
				// Check if the user is authenticated
				if (HttpContext.Current.User.Identity.IsAuthenticated)
				{
					// Retrieve the authentication cookie
					HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];

					if (authCookie != null)
					{
						// Decrypt the authentication ticket
						FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(authCookie.Value);

						// Retrieve the user ID from the authentication ticket
						string authenticatedUserId = authTicket.Name;

						// Check if SqlDataSource1 and its SelectParameters collection are not null
						if (SqlDataSource1 != null && SqlDataSource1.SelectParameters != null)
						{
							// Set the parameter value for the SqlDataSource
							SqlDataSource1.SelectParameters["id"].DefaultValue = authenticatedUserId;

							// Refresh the data bound to the SqlDataSource
							SqlDataSource1.DataBind();

						}

					}
				}
			}


		}


			protected void Button1_Click(object sender, EventArgs e)
			{
				Response.Redirect("UpdateStudentDetails.aspx");
			}
		}
	}
