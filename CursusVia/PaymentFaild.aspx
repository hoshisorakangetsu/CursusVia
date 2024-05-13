<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="PaymentFaild.aspx.cs" Inherits="CursusVia.PaymentFaild" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Response.Write("<script>alert('Payment successful!'); location.href = '~/Customer/Courses.aspx';</script>");
    Response.Redirect("~/Customer/Cart.aspx");

</asp:Content>
