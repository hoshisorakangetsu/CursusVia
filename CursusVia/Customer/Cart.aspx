<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="CursusVia.Customer.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CartStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2>Shopping Cart</h2>
   
    <asp:Label ID="lblItemNo" runat="server" Text="Cart Item Number" CssClass="lblItemNo"></asp:Label>
 <div class="cart-item">
    <div class="course-image">
        <img src="course-thumbnail.jpg" alt="Course Thumbnail" />
    </div>
    <div class="course-info">
        <h3>Course in Graphic Design</h3>
        <p>Tutor: Dr. Ismawi Ismail</p>
        

        <asp:Label ID="lblcourserating" runat="server" Text="Rate:" CssClass="lblcourserating"></asp:Label>
        <asp:Label ID="lblStar" runat="server" Text="★★★★" CssClass="lblStar"></asp:Label>
        <asp:Literal ID="litRate" runat="server" Text="4.9/5 (105 ratings)"></asp:Literal>
        
    </div>
        <asp:Label ID="lblPrice" runat="server" Text="Price: RM 888" CssClass="lblPrice"></asp:Label>
        <asp:Button ID="btnSelect" runat="server" Text="Select" CssClass="btnSelect" />
        <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="btnRemove" />
</div>
    <asp:Repeater ID="cartRepeater" runat="server">
    <ItemTemplate>
        <div class="cart-item">
            <div class="course-image">
                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("CourseName") %>' />
            </div>
            <div class="course-info">
                <h3><%# Eval("CourseName") %></h3>
                <p>Tutor: <%# Eval("TutorName") %></p>
                <p class="course-rating">Rate: <%# Eval("Rating") %> (<%# Eval("RatingCount") %> ratings)</p>
            </div>
            <div class="course-price">
                <p>Price: RM <%# Eval("Price") %></p>
            </div>
                <asp:Button CommandName="Select" CommandArgument='<%# Eval("CourseId") %>' Text="Select" CssClass="select-btn" runat="server" />
                <asp:Button CommandName="Remove" CommandArgument='<%# Eval("CourseId") %>' Text="Remove" CssClass="remove-btn" runat="server" />
        </div>
    </ItemTemplate>
</asp:Repeater>
</asp:Content>
