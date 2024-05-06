﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="LoginStudent.aspx.cs" Inherits="CursusVia.Customer.LoginStudent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="LoginStudent.css" rel="stylesheet" />
    <link href="LoginStudent2" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <h2 style="margin: 1rem; margin-bottom: .5rem;">Student Account</h2>
     
    <asp:Panel ID="pnlLogin" runat="server" Visible="true">
         <h3 style="margin-left: 1rem;">Login</h3>
    <div id="loginContainer" runat="server" class="login-container">
        <asp:Label ID="lblhavAcc" runat="server" Text="Have an account?" CssClass="lblhavAcc"></asp:Label>
        <asp:Label ID="lblLogin" runat="server" Text="Login" CssClass="lblLogin" ></asp:Label> 
        <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername" PlaceHolder="👤 Username / Email"></asp:TextBox>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="🔒 Password" />
        <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login" OnClick="btnLogin_Click" />
        <asp:LinkButton runat="server" ID="lbtnForgetPass" CssClass="lbtnForgetPass" >Forget password?</asp:LinkButton>
        <asp:CheckBox runat="server" ID="cbRememberMe" Text="Remember me" CssClass="cbRememberMe"></asp:CheckBox>
        <asp:LinkButton runat="server" ID="lbtnShowRegister" Text="Register"  CssClass="lbtnRegister" />
          <asp:Label ID="lblMessage" runat="server"/>
</div>
    </asp:Panel>
   <%-- 
     <asp:Panel ID="pnlRegister" runat="server" Visible="false">
         <h3 style="margin-left:20px;">Register</h3>
         <div class="backBtn">
            <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='LoginStudent.aspx'>   
        <span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em; margin-top:20px;">arrow_back</span>
        Back
            </asp:HyperLink>
        </div>
        <div id="RegisterContainer" runat="server" class="Register-container">
        <asp:Label ID="lblRegister" runat="server" Text="Register Student" CssClass="lblRegister" ></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Email"></asp:TextBox>
        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔑 Password" />
        <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password" />
       
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit"/>
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel"/>
            <asp:LinkButton runat="server" ID="lbtnLogin" Text="Login" OnClick="lbtnShowLogin_Click" CssClass="lbtnLogin" />

            </div>
   
          </asp:Panel>

    <asp:Panel ID="pnlForgetPw" runat="server" Visible="true">
     <h3>Forget Password</h3>
     <div class="backBtn">
        <asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='LoginStudent.aspx'>   
    <span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
    Back
        </asp:HyperLink>
    </div>
    <div id="Div1" runat="server" class="Register-container">
    <asp:Label ID="Label1" runat="server" Text="Reset Password Via Email" CssClass="lblRegister" ></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server" CssClass="txtEmail" PlaceHolder="📧Enter your Email"></asp:TextBox>
  
        <asp:Button ID="Button1" runat="server" Text="Confirm" CssClass="btnSubmit"/>
        <asp:Button ID="Button2" runat="server" Text="Cancel" CssClass="btnCancel"/>
        

        </div>
   
      </asp:Panel>

   --%>

</asp:Content>
