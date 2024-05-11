<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="CursusVia.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CartStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-header">
        <h2 style="margin-left: 1rem;">Shopping Cart</h2>
    </div>
    <div class="main-container">
            <!-- Shopping Cart -->
            <div class="cart-container">
                           <asp:Repeater ID="CartRepeater" runat="server" OnItemCommand="CartRepeater_ItemCommand">
                    <HeaderTemplate>
                        <div class="item-header">
                            <div class="cart-column">Select</div>
                             <div class="cart-column">Image</div>
                            <div class="cart-column">Item Name</div>
                            <div class="cart-column">Description</div>
                            <div class="cart-column">Price</div>        
                            <div class="cart-column">Delete Item</div>
                        </div>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="cart-row">
                            <div class="cart-cell"><asp:CheckBox ID="ItemSelector" runat="server" /></div>
                            <% 
    // this comment should not be shown to the public as it concerns the internal working, so will be enclosing in server tags
    // Substring 1 because the upload file utils include "~", which is not understandable by client browsers 
%>
                   <div class="cart-cell"> <img src='<%# Eval("ImagePath").ToString().Substring(1) %>' alt="Item Image"  width="80" height="80"/></div>
                        <div class="cart-cell"><%# Eval("Title") %></div>
                            <div class="cart-cell"><%# Eval("Description") %></div>
                            <div class="cart-cell">$<%# Eval("Price") %></div>
                            <div class="cart-cell">
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btnDelet" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="order-summary">
            <h3>Order Summary</h3>
            <p>Item(s) subtotal: <asp:Label ID="lblSubtotal" runat="server"></asp:Label></p>
            <p>Tax (7%): <asp:Label ID="lblTax" runat="server"></asp:Label></p>
            <p>Total: <asp:Label ID="lblTotal" runat="server"></asp:Label></p>
            <asp:Button ID="Button1" runat="server" Text="Checkout" CssClass="Button"/>
        </div>
    </div>
</asp:Content>


