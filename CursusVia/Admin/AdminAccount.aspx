<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="AdminAccount.aspx.cs" Inherits="CursusVia.Admin.AdminAccount" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
      <link href="AccountStyle.css" rel="stylesheet" />
   
    rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">

    <h2> Admin Account</h2>

    <div class="login-container">
        <asp:Label ID="lblhavAcc" runat="server" Text="Have an account?" CssClass="lblhavAcc"></asp:Label><br />
        <asp:Label ID="lblLogin" runat="server" Text="Login" CssClass="lblLogin" ></asp:Label> <br />
        <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername" PlaceHolder="Username / Email"></asp:TextBox><br/>
      <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="Password" />
        <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login"/>
        <asp:LinkButton runat="server" ID="lbtnForgetPass" CssClass="lbtnForgetPass">Forget password?</asp:LinkButton>
        <asp:CheckBox runat="server" ID="cbRememberMe" Text="Remember me" CssClass="cbRememberMe"></asp:CheckBox>
        <asp:LinkButton runat="server" ID="lbtnRegister" CssClass="lbtnRegister">Register</asp:LinkButton>


</div>

   
</asp:Content>
