<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="AdminAccount.aspx.cs" Inherits="CursusVia.Admin.AdminAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
      <link href="AccountStyle.css" rel="stylesheet" />
   
    rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">

    <h2> Admin Account</h2>
    <asp:Panel ID="pnlLogin" runat="server" Visible="true">
        <h2> Login</h2>
    <div id="loginContainer" runat="server" class="login-container">
        <asp:Label ID="lblhavAcc" runat="server" Text="Have an account?" CssClass="lblhavAcc"></asp:Label>
        <asp:Label ID="lblLogin" runat="server" Text="Login" CssClass="lblLogin" ></asp:Label> 
        <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername" PlaceHolder="👤 Username / Email"></asp:TextBox>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="🔒 Password" />
        <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login"/>
        <asp:LinkButton runat="server" ID="lbtnForgetPass" CssClass="lbtnForgetPass">Forget password?</asp:LinkButton>
        <asp:CheckBox runat="server" ID="cbRememberMe" Text="Remember me" CssClass="cbRememberMe"></asp:CheckBox>
        <asp:LinkButton runat="server" ID="lbtnShowRegister" Text="Register" OnClick="lbtnShowRegister_Click" CssClass="lbtnRegister" />
</div>
    </asp:Panel>
     <asp:Panel ID="pnlRegister" runat="server" Visible="false">
        <h2>Register</h2>
        <div id="RegisterContainer" runat="server" class="Register-container">
        <asp:Label ID="lblRegister" runat="server" Text="Register Admin" CssClass="lblRegister" ></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Email"></asp:TextBox>
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔑 Password" />
        <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password" />
        <asp:TextBox ID="txtVerify" runat="server" CssClass="txtVerify" Placeholder="🔐 Verification key word"/>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit"/>
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel"/>
            <asp:LinkButton runat="server" ID="lbtnLogin" Text="Login" OnClick="lbtnShowLogin_Click" CssClass="lbtnLogin" />

            </div>
   
          </asp:Panel>
   
</asp:Content>
