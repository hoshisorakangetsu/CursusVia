<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="UpdateStudentPassword.aspx.cs" Inherits="CursusVia.Customer.UpdateStudentPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="UpdateStudentPassword.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
     <div class="layer-1">
 <div class="background-1">
     <table id="t1">
         <tr>
             <th>
                <span class="material-symbols-outlined pwicon">key</span>

                 Update Password</th>
         </tr>
      
         <tr>
             <td>
                 <div class="input-grp">
                      <label for="TextBox3">Old Password</label>
                 <asp:TextBox ID="TextBox3" runat="server" cssClass="form-control" TextMode="Password"></></asp:TextBox>
                        
                     </div>
                      </td>
         </tr>
         <tr>
             <td>
                  <div class="input-grp">
                      <label for="TextBox1">New Password</label>
                 <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                   
                      </div>
                      </td>
         </tr>
          <tr>
     <td>
          <div class="input-grp">
              <label for="TextBox1">Confirmed Password</label>
         <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
           
              </div>
              </td>
 </tr>
        
         <tr>
             <td>
                 
                 <asp:Button ID="Button1" runat="server" Text="Update" cssClass="Button1"/>
                 
             </td>
         </tr>
     
         </table>
 </div>
     </div>
</asp:Content>
