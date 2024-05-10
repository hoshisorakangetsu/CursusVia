<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="AdminAccount.aspx.cs" Inherits="CursusVia.Admin.AdminAccount" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="AccountStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 style="margin: 1rem; margin-bottom: .5rem;">Admin Account - Login</h2>
        <h3 style="margin-left: 1rem;">Login</h3>
        <div id="loginContainer" runat="server" class="login-container">
            <asp:Label ID="lblhavAcc" runat="server" Text="Have an account??" CssClass="lblhavAcc"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername" Placeholder="👤 Username / Email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
ErrorMessage="Username or email is required." CssClass="error" Display="Dynamic" />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="🔒 Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
ErrorMessage="Password is required." CssClass="error" Display="Dynamic" />
            <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login" OnClick="btnLogin_Click" />
            <asp:LinkButton ID="lbtnShowRegister" runat="server" Text="Register" PostBackUrl="RegisterAdmin.aspx" CssClass="lbtnRegister" />
            <asp:Label ID="lblStatus" runat="server" Visible="false"></asp:Label>

        </div>
   
</asp:Content>
