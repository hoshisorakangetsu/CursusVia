using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CursusVia.Admin
{
    public partial class AdminAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbtnShowRegister_Click(object sender, EventArgs e)
        {

            // Toggle visibility of the registration panel
            pnlRegister.Visible = !pnlRegister.Visible;
            pnlLogin.Visible = false;


        }

        protected void lbtnShowLogin_Click(object sender, EventArgs e)
        {
            // Toggle visibility of the Logoin panel
            pnlLogin.Visible = !pnlLogin.Visible;
            pnlRegister.Visible = false;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Redirect the user to the AdminHome  page
            Response.Redirect("~/Admin/SupportRequest.aspx");

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Step 1: Collect data from the form
            var username = txtUsername.Text;
            var email = txtEmail.Text;
            var password = txtPassword.Text;
            // Step 2: Initialize your DbContext
            using (var db = new CursusViaEntities())
            {
                // Step 3: Check if the user exists in the database
                var user = db.Users.FirstOrDefault(u => u.Username == username && u.Password == password);
                if (user == null)
                {
                    // Step 4: If the user does not exist, redirect the user to the login page
                    Response.Redirect("/Admin/AdminAccount.aspx");
                }
                else
                {
                    // Step 5: If the user exists, redirect the user to the AdminHome page
                    Response.Redirect("/Admin/AdminHome.aspx");
                }
            }
         
            Response.Redirect("/Admin/RegisterConfirmation.aspx");

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/AdminAccount.aspx");
 

        }




    }
}