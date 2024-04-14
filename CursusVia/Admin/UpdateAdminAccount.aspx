<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="UpdateAdminAccount.aspx.cs" Inherits="CursusVia.Admin.UpdateAdminAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="AccountStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">



    <h2>Update Account Information</h2>
      <div id="UpdateAccountContainer" runat="server" class="Update-container">
       <asp:Label ID="lblUpdateAcc" runat="server" Text="Update Admin Account" CssClass="lblUpdateAcc" ></asp:Label>
       <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Email"></asp:TextBox>
         <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔑 Password" />
       <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password" />
         <asp:TextBox ID="txtVerify" runat="server" CssClass="txtVerify" Placeholder="🔐 Verification key word"/>
          <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
          <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel" OnClick="btnCancel_Click" />
      </div>


</asp:Content>
