﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdateDetailsTutor.aspx.cs" Inherits="CursusVia.Tutor.UpdateDetailsTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="UpdateDetailsTutor.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="backbtn">
    <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='ReadTutorInformation.aspx'>   
<span class="material-symbols-outlined backIcon">arrow_back</span>
Back
    </asp:HyperLink>
        </div>
    <div class="layer-1">
<div class="background-1">
    <table id="t1">
        <tr>
            <th>
               <span class="material-symbols-outlined accicon ">manage_accounts</span>

                Update Personal Details</th>
        </tr>
     
        <tr>
            <td>
                <div class="input-grp">
                     <label for="TextBox3">Name</label>
                <asp:TextBox ID="TextBox3" runat="server" cssClass="form-control" ></asp:TextBox>
                       
                    </div>
                     </td>
        </tr>
        <tr>
            <td>
                 <div class="input-grp2">
                     <label for="TextBox1">Email</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ></asp:TextBox>
                  
                     </div>
                     </td>
        </tr>
        <tr>
     <td>
         <div class="input-grp" >
            <label for="DropDownList1">Qualifications</label>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                <asp:ListItem Value="phd">PHD</asp:ListItem>
                <asp:ListItem Value="master">Master</asp:ListItem>
                <asp:ListItem Value="degree">Degree</asp:ListItem>
            </asp:DropDownList>
        </div>
              </td>
 </tr>
        <tr>
            <td>
                  
                <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btnPrimary btn"/>
                  
            </td>
        </tr>
    
        </table>
</div>
    </div>
</asp:Content>
