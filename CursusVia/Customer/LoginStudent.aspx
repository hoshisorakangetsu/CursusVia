<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="LoginStudent.aspx.cs" Inherits="CursusVia.Customer.LoginStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="LoginStudent.css" rel="stylesheet" />
    <link href="LoginStudent2" rel="stylesheet" />
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <h2 style="margin: 1rem; margin-bottom: .5rem;">Student Account</h2>
     
    <asp:Panel ID="pnlLogin" runat="server" Visible="true">
         <h3 style="margin-left: 1rem;">Login</h3>
    <div id="loginContainer" runat="server" class="login-container" style="height:470px; width:500px;">
        <asp:Label ID="lblhavAcc" runat="server" Text="Have an account?" CssClass="lblhavAcc"></asp:Label>
        <asp:Label ID="lblLogin" runat="server" Text="Login" CssClass="lblLogin" ></asp:Label> 
        <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername" PlaceHolder="👤 Username / Email"></asp:TextBox>
        <div style="height:30px;">
     
            </div>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="🔒 Password" />
        <div style="height:30px;">
            </div>
        <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login" OnClick="btnLogin_Click" />
        <asp:LinkButton runat="server" ID="lbtnForgetPass" CssClass="lbtnForgetPass" OnClick="lbtnForgetPass_Click" >Login with email OTP</asp:LinkButton>
        <asp:CheckBox runat="server" ID="cbRememberMe" Text="Remember me" CssClass="cbRememberMe"></asp:CheckBox>
        <asp:LinkButton runat="server" ID="lbtnShowRegister" Text="Register"  CssClass="lbtnRegister" OnClick="lbtnShowRegister_Click" />
          
          <asp:Image ID="captchaImage" runat="server" Height="50px" Width="150px"  ImageUrl="~/Customer/MyCaptcha.aspx" /><br>
        <asp:TextBox ID="captchacode" runat="server" Placeholder="Enter captcha code" CssClass="txtEmail"></asp:TextBox>
          <asp:Label ID="lblMessage" runat="server"/>

</div>
    </asp:Panel>
 

</asp:Content>

