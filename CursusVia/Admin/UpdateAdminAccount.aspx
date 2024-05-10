<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="UpdateAdminAccount.aspx.cs" Inherits="CursusVia.Admin.UpdateAdminAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="AccountStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">



    <h2 style="margin: 1rem; margin-bottom: .5rem;">Update Account Information</h2>
    <div id="UpdateAccountContainer" runat="server" class="login-container">
        <asp:Label ID="lblUpdateAcc" runat="server" Text="Update Admin Account" CssClass="lblUpdateAcc" ></asp:Label>
        
        <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" Placeholder="📧 Email"></asp:TextBox>
        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
            ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$" 
            ErrorMessage="Enter a valid email address." CssClass="error" Display="Dynamic" />
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
            ErrorMessage="Email is required." CssClass="error" Display="Dynamic" />
        
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔑 Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPass"
            ErrorMessage="Password is required." CssClass="error" Display="Dynamic" />
        
        <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPass"
            ErrorMessage="Confirm Password is required." CssClass="error" Display="Dynamic" />
        <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPass"
            ControlToCompare="txtPass" ErrorMessage="Passwords do not match." CssClass="error" Display="Dynamic" />

        <asp:TextBox ID="txtVerify" runat="server" CssClass="txtVerify" Placeholder="🔐 Verification key word"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvVerify" runat="server" ControlToValidate="txtVerify"
            ErrorMessage="Verification key word is required." CssClass="error" Display="Dynamic" />
        <asp:Label ID="lblStatus" runat="server" CssClass="statusMessage" Visible="False"></asp:Label>
        <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel"  CausesValidation="False" CssClass="btnCancel" OnClick="btnCancel_Click" />
    </div>


</asp:Content>
