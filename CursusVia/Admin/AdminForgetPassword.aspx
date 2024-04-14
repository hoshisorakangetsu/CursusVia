<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="AdminForgetPassword.aspx.cs" Inherits="CursusVia.Admin.AdminForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="AccountStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
     <h3>Forget Password</h3>
 <div class="backBtn">
    <asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='AdminAccount.aspx'>   
<span class="material-symbols-outlined backIcon">arrow_back</span>
Back
    </asp:HyperLink>
</div>
<div id="Div1" runat="server" class="Register-container">
<asp:Label ID="Label1" runat="server" Text="Reset Password Via Email" CssClass="lblRegister" ></asp:Label>
<asp:TextBox ID="TextBox1" runat="server" CssClass="txtEmail" PlaceHolder="📧Enter your Email"></asp:TextBox>
  
    <asp:Button ID="Button1" runat="server" Text="Confirm" CssClass="btnSubmit" OnClick="Button1_Click" />
    <asp:Button ID="Button2" runat="server" Text="Cancel" CssClass="btnCancel" OnClick="Button2_Click" />
    

    </div>
</asp:Content>
