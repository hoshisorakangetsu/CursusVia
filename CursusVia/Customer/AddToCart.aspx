﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="AddToCart.aspx.cs" Inherits="CursusVia.Customer.AddToCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="addToCartMessage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">

   <div style="background-color: #f9f9f9; border: 1px solid #ccc; padding: 20px; margin: 30px auto; text-align: center; max-width: 300px;">
        <h1 style="margin: 0; margin-bottom: .5rem;">Add To Cart</h1>

        <div class="add-to-cart-confirmation">
            <asp:Button ID="btnAdd" runat="server" Text="Continue" CssClass="continue-button" OnClick="btnAdd_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-button" NavigateUrl='<%# "~/Customer/AddToCart.aspx?courseId=" + Eval("id") %>' />
            <asp:HiddenField ID="HiddenStudentId" runat="server" />
        </div>
    </div>
</asp:Content>


