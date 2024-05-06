<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="CursusVia.Customer.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="LoginStudent.css" rel="stylesheet" />
    <link href="LoginStudent2" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <h3>Forget Password</h3>
 <div class="backBtn">
    <asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='AdminAccount.aspx'>   
<span class="material-symbols-outlined backIcon">arrow_back</span>
Back
    </asp:HyperLink>
</div>
<div id="Div1" runat="server" class="Register-container">
<asp:Label ID="Label1" runat="server" Text="Reset Password Via Email" CssClass="lblRegister" ></asp:Label>
<asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Enter your Email"></asp:TextBox>
  
    <asp:Button ID="Button1" runat="server" Text="Confirm" CssClass="btnSubmit" OnClick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" Text="Cancel" CssClass="btnCancel" />
    

    <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label>
    

    </div>
</asp:Content>
