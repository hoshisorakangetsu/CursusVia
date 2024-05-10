<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="RegisterAdmin.aspx.cs" Inherits="CursusVia.Admin.RegisterAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="AccountStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h2>Register</h2>
         <div class="backBtn">
            <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='AdminAccount.aspx'>   
<div id="back-button">
        <span class="material-symbols-outlined backIcon">arrow_back</span>
        <h3>Back</h3></div>
            </asp:HyperLink>
        </div>
        <div id="RegisterContainer" runat="server" class="login-container">
        <asp:Label ID="lblRegister" runat="server" Text="Register Admin" CssClass="lblRegister" ></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="txtEmail" PlaceHolder="👤 Username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
ErrorMessage="Username is required." CssClass="error" Display="Dynamic" />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Email"></asp:TextBox>
                    <!-- Regular Expression Validator for Email -->
    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$" 
ErrorMessage="Enter a valid email address." CssClass="error" Display="Dynamic" />
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
ErrorMessage="Email is required." CssClass="error" Display="Dynamic" />
        <asp:CustomValidator ID="CustomValidator1" 
    runat="server" ErrorMessage="Existing Email , Try new one" ControlToValidate="txtEmail" CssClass="error" Display="Dynamic" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔑 Password" />
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPass"
    ErrorMessage="Password is required." CssClass="error" Display="Dynamic" />
        <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password" />
            <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPass"
    ControlToCompare="txtPass" ErrorMessage="Passwords do not match." CssClass="error" Display="Dynamic" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmPass"
ErrorMessage="Password is required." CssClass="error" Display="Dynamic" />
        <asp:TextBox ID="txtVerify" runat="server" CssClass="txtVerify" Placeholder="🔐 Verification key word"/>
            <asp:RequiredFieldValidator ID="rfvVerify" runat="server" ControlToValidate="txtVerify"
    ErrorMessage="Verification key word is required." CssClass="error" Display="Dynamic" />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
        <asp:Label ID="lblStatus" runat="server" CssClass="statusMessage" Visible="False"></asp:Label>
           <asp:Button ID="btnCancel" runat="server" Text="Cancel" CausesValidation="False" OnClick="btnCancel_Click" CssClass="btnCancel" />
        <asp:LinkButton runat="server" ID="lbtnLogin" Text="Login" PostBackUrl="~/Admin/AdminAccount.aspx" CssClass="lbtnLogin" CausesValidation="False" />

        </div>
</asp:Content>
