<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="DeleteTutor.aspx.cs" Inherits="CursusVia.Tutor.DeleteTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="DeleteTutor.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
     <div>
           <div class="backbtn" style="padding: 2em 2em 0 2em;">
   <asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='Tutor.aspx'>   
   <span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
   Back
   </asp:HyperLink>
    </div>
     <table class="table1">
         <tr>
             <th>
                 <span class="dot">
                 <span class="material-symbols-outlined deleteicon">
                 delete
                 </span>
                 </span>
                 <p id="deletetxt">Delete Account</p> 
              </th>
          </tr>
        <tr>
         <td>
         <p>If you delete your account, your personal information will be wiped from CursusVia's servers, all of your course activity 
             will be anonymized and  will be deleted. This action cannot be undone! Think carefully before you delete your account.

         </p>
         </td>
        </tr>
         <tr>
             <td>
                 <asp:Button ID="Button1" runat="server" Text="Delete Now" CssClass="btnPrimary btn" />

             </td>
         </tr>
          </table>
     <table class="table1">
         <tr>
             <th>
                 <span class="dot">
                 <span class="material-symbols-outlined logouticon">
                 logout
                 </span>
                 </span>
                 <p id="logouttxt">Logout</p>    
             </th>
         </tr>
         <tr>
                 <td>
                 <p>If your account has been logged into on multiple devices, you can log out from here.</p>
                 </td>
         </tr>
          <tr>
          <td>
              <asp:Button ID="Button2" runat="server" Text="Delete Now" CssClass="btnPrimary btn" />

          </td>
          </tr>
     </table>
        
     </div>
</asp:Content>
