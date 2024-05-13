<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="LoginTutor.aspx.cs" Inherits="CursusVia.Tutor.LoginTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="LoginTutor.css" rel="stylesheet" />
    <link href="LoginTutor2.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <h2 style="margin: 1rem; margin-bottom: .5rem;">Tutor Account</h2>
     
    <asp:Panel ID="pnlLogin" runat="server" Visible="true">
         <h3 style="margin-left: 1rem;">Login</h3>
    <div id="loginContainer" runat="server" class="login-container" style="height:470px; width:700px;">
        <asp:Label ID="lblhavAcc" runat="server" Text="Have an account?" CssClass="lblhavAcc"></asp:Label>
        <asp:Label ID="lblLogin" runat="server" Text="Login" CssClass="lblLogin" ></asp:Label> 
        <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername" PlaceHolder="👤 Username / Email"></asp:TextBox>
         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="cannot leave blank" ControlToValidate="txtUsername" ValidationGroup="loginValidation" Forecolor="red"></asp:RequiredFieldValidator>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="🔒 Password" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="cannot Leave Blank" controlToValidate="txtPassword" ValidationGroup="loginValidation" Forecolor="red"></asp:RequiredFieldValidator>
        <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login" OnClick="btnLogin_Click" ValidationGroup="loginValidation"/>
        <asp:LinkButton runat="server" ID="lbtnForgetPass" CssClass="lbtnForgetPass" OnClick="lbtnForgetPass_Click">Log in with email OTP</asp:LinkButton>
        <asp:CheckBox runat="server" ID="cbRememberMe" Text="Remember me" CssClass="cbRememberMe"></asp:CheckBox>
        <asp:LinkButton runat="server" ID="lbtnShowRegister" Text="Register" CssClass="lbtnRegister" OnClick="lbtnShowRegister_Click" />
                   <asp:Image ID="captchaImage" runat="server" Height="50px" Width="150px"  ImageUrl="~/Tutor/MyCaptcha.aspx" /><br>
<asp:TextBox ID="captchacode" runat="server" Placeholder="Enter captcha code" CssClass="txtEmail"></asp:TextBox>
        <asp:Label ID="lblMessage" runat="server"/>

</div>
    </asp:Panel>
   
   

 
   

   
</asp:Content>
