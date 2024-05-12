<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="loginEmailOtp.aspx.cs" Inherits="CursusVia.Tutor.loginEmailOtp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
         <link href="LoginTutor.css" rel="stylesheet" />
<link href="LoginTutor2.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        

    <asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='LoginTutor.aspx'>   
<span class="material-symbols-outlined backIcon">arrow_back</span>
Back
    </asp:HyperLink>
</div>
<div id="Div1" runat="server" class="Register-container">
<asp:Label ID="Label1" runat="server" Text="log in via email OTP" CssClass="lblRegister" ></asp:Label>  
<asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Enter your Email"></asp:TextBox>
    <asp:Button ID="btnRequest" runat="server" Text="RequestOTP" CssClass="btnSubmit" OnClick="btnRequest_Click"  />
  
        <asp:TextBox ID="txtOtp" runat="server" Placeholder="Enter the OTP you received" CssClass="txtEmail"></asp:TextBox>

    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnCancel" OnClick="btnSubmit_Click" />
    <div style="margin-bottom:20px;">
    <asp:Label ID="otp" runat="server" Text=""></asp:Label>
    </div>

    </div>
</asp:Content>
