<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="Tutor.aspx.cs" Inherits="CursusVia.Tutor.Tutor" %>
<asp:Content ID="head" ContentPlaceHolderID="TutorMasterHead" runat="server">
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="TutorMasterBody" runat="server">
     <h1 style="margin:30px;">Student's Profile Management</h1>
   

     <div style=" border: 2px solid black; position: relative; left: 30px; width:60% ;padding:30px; margin-bottom:40px; margin-top:40px; border-radius:10px;">
         <div  style="background-color:red; border-radius:20px; width:35px;"><span class="material-symbols-outlined profileicon">
             person
         </span> </div>
         Read Student's personal details<div style="position: relative; left: 5px; top: 25px;"><asp:Button ID="Button1" runat="server" Text="Go To Profile" CssClass="btnPrimary btn" OnClick="Button1_Click"  /> </div>
    </div>     
     
  
     <div style=" border: 2px solid black; position: relative; left: 30px; width:60% ;padding:30px;margin-bottom:40px; margin-top:40px;border-radius:10px;">
         <div style="background-color:red; border-radius:20px; width:35px;"><span class="material-symbols-outlined profileicon">
         manage_accounts
         </span> </div>
         Update Student's Personal Details<div style="position: relative; left: 5px; top: 25px;"><asp:Button ID="Button2" runat="server" Text="Go To Update Details" CssClass="btnPrimary btn" OnClick="Button2_Click"  /> </div>
       </div>
   
  
     <div style=" border: 2px solid black; position: relative; left: 30px; width:60% ;padding:30px; margin-bottom:40px; margin-top:40px; border-radius:10px;">
         <div style="background-color:red; border-radius:20px; width:35px;"><span class="material-symbols-outlined profileicon">
         password
         </span> </div>
         Update Student's Password<div style="position: relative; left: 5px; top: 25px;"><asp:Button ID="Button3" runat="server" Text="Go To Update Password " CssClass="btnPrimary btn" OnClick="Button3_Click"  /> </div>
         </div>
      <div  style=" border: 2px solid black; position: relative; left: 30px; width:60% ;padding:30px; margin-bottom:40px; margin-top:40px;border-radius:10px;">
    <div style="background-color:red; border-radius:20px; width:35px;"><span class="material-symbols-outlined profileicon">
    logout
     </span> </div>
    Delete Account & Logout From Account<div style="position: relative; left: 5px; top: 25px;"><asp:Button ID="Button4" runat="server" Text="Go To Delete Account & Log Out" CssClass="btnPrimary btn" OnClick="Button4_Click"   /> </div>
    </div>
        <div  style=" border: 2px solid black; position: relative; left: 30px; width:60% ;padding:30px; margin-bottom:40px; margin-top:40px;border-radius:10px;">
    <div style="background-color:red; border-radius:20px; width:35px;"><span class="material-symbols-outlined profileicon">
    star
    </span> </div>
    Tutor's Ratings<div style="position: relative; left: 5px; top: 25px;"><asp:Button ID="Button5" runat="server" Text="Go To Tutor's Ratings" CssClass="btnPrimary btn" OnClick="Button5_Click"    /> </div>
    </div>
</asp:Content>
