﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdatePasswordTutor.aspx.cs" Inherits="CursusVia.Tutor.UpdatePasswordTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="UpdatePassword.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
        <div class="layer-1">
       
     <table style="border: solid 2px black;" id="t1">
        <tr>
            <th>
               <span class="material-symbols-outlined pwicon">key</span>

                Update Password</th>
        </tr>
     
        <tr>
            <td>
                <div class="input-grp">
                    
                <asp:TextBox ID="TextBox3" runat="server" cssClass="form-control" TextMode="Password" Placeholder="Old Password" Height="30px" Width="70%"></asp:TextBox>
                       
                    </div>
                     </td>
        </tr>
        <tr>
            <td>
                 <div class="input-grp">
              
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="Password" Placeholder="New Password" Height="30px" Width="70%"></asp:TextBox>
                  
                     </div>
                     </td>
        </tr>
         <tr>
    <td>
         <div class="input-grp">
            
        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirmed New Password" Height="30px" Width="70%" ></asp:TextBox>
          
             </div>
             </td>
</tr>
       
        <tr>
            <td>
                
              &nbsp;&nbsp;  <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btnPrimary btn"/>
                
            </td>
        </tr>
    
        </table>
</div>
</asp:Content>
