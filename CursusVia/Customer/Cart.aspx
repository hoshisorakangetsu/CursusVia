<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="CursusVia.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CartStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-header">
        <h2 style="margin-left: 1rem;">Shopping Cart</h2>
    </div>
    <div class="main-container">
        <div class="cart-container">
            <asp:Button ID="btnDeleteSelected" runat="server" Text="Delete Selected" OnClick="btnDeleteSelected_Click" CssClass="Button" style="margin-bottom: 20px;" />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="CartItemId" CssClass="cart-table" OnRowDeleting="GridView1_RowDeleting" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="Select">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelect" runat="server" CssClass="checkbox-style" />
                        </ItemTemplate>
                        <HeaderStyle CssClass="item-header" />
                        <ItemStyle CssClass="cart-row" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='<%# Eval("ImagePath").ToString().Substring(1) %>' alt="Item Image" class="product-image" />
                        </ItemTemplate>
                        <HeaderStyle CssClass="item-header" />
                        <ItemStyle CssClass="cart-row" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Title" HeaderText="Item Name" HeaderStyle-CssClass="item-header" ItemStyle-CssClass="cart-row" />
                    <asp:BoundField DataField="Description" HeaderText="Description" HeaderStyle-CssClass="item-header" ItemStyle-CssClass="cart-row" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" HeaderStyle-CssClass="item-header" ItemStyle-CssClass="cart-row" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' Text="Delete" CssClass="btnDelet" />
                        </ItemTemplate>
                        <HeaderStyle CssClass="item-header" />
                        <ItemStyle CssClass="cart-row" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="cart-row" />
                <HeaderStyle CssClass="item-header" />
            </asp:GridView>
        </div>
       <div class="order-summary">
    <h3>Order Summary</h3>
    <asp:Repeater ID="RepeaterOrderSummary" runat="server">
        <ItemTemplate>
            <p><%# Eval("Title") %> - <%# Eval("Price", "{0:C}") %></p>
        </ItemTemplate>
    </asp:Repeater>
    <p>Item(s) subtotal: <asp:Label ID="lblSubtotal" runat="server"></asp:Label></p>
    <p>Tax (7%): <asp:Label ID="lblTax" runat="server"></asp:Label></p>
    <p>Total: <asp:Label ID="lblTotal" runat="server"></asp:Label></p>
    <asp:Button ID="Button1" runat="server" Text="Checkout" CssClass="Button"/>
</div>

    </div>
</asp:Content>
