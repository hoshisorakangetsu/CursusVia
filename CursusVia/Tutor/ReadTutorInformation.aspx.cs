using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Tutor
{
	public partial class ReadTutorInformation : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}
		protected void Page_PreRender(object sender, EventArgs e)
		{
			if(GridView1.SelectedRow ==null)
			{
				DetailsView1.Visible = false;
			}
			else
			{
				DetailsView1.Visible=true;
			}
		}

		protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
		{
			//rebind the data to table so that can refresh when perform update
			GridView1.DataBind();
			//-1 so that no row is selected
			GridView1.SelectRow(-1);
		}

		protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
		{
			//rebind the data to table so that can refresh when perform update
			GridView1.DataBind();
			//-1 so that no row is selected
			GridView1.SelectRow(-1);
		}

		protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
		{
			//rebind the data to table so that can refresh when perform update
			GridView1.DataBind();
			//-1 so that no row is selected
			GridView1.SelectRow(-1);
		}
	}
}