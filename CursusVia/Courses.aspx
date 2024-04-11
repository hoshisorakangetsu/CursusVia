﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="CursusVia.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Courses.css" rel="stylesheet" />
    <link href="BrowseCourseCard.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="coursesMain">
        <!-- why vs eh auto format for inline expressions so ugly eh -->
        <% if (String.IsNullOrEmpty(Request.QueryString.Get("search")))
            {  %>
        <h1>Browse Courses</h1>
        <% }
            else
            { %>
        <h1>Showing "<%= Request.QueryString.Get("search") %>" Courses</h1>
        <% } %>

        <div class="coursesSearch">
            <div class="searchAlwaysShown">
                <div class="searchBox">
                    <span class="material-symbols-outlined searchIcon">search
                    </span>
                    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="searchTextBox" placeholder="Search Courses"></asp:TextBox>
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btnPrimary searchBtn" />
                </div>
                <div class="rightControl">
                    <asp:DropDownList ID="CourseCategoryFilter" runat="server" CssClass="filterCategory">
                        <asp:ListItem Selected="True">All Category</asp:ListItem>
                        <asp:ListItem Value="web_development">Web Development</asp:ListItem>
                        <asp:ListItem Value="digital_marketing">Digital Marketing</asp:ListItem>
                        <asp:ListItem Value="graphic_design">Graphic Design</asp:ListItem>
                        <asp:ListItem Value="mobile_apps">Mobile Apps</asp:ListItem>
                    </asp:DropDownList>
                    <button class="advancedFilter btnOutlinePrimary" id="advancedFilterCourse">
                        <span class="material-symbols-outlined">tune
                        </span>
                    </button>
                </div>
            </div>
            <div class="searchExpandable" id="advancedFilterCourseExpandable">
                <div class="advancedFilterCourseControl">
                    <div class="priceFilter">
                        <label>Price</label>
                        <div class="priceRange">
                            <div class="priceField">
                                RM
                                <asp:TextBox ID="MinPrice" runat="server" CssClass="priceBox"></asp:TextBox>
                            </div>
                            ~ 
                            <div class="priceField">
                                RM
                                <asp:TextBox ID="MaxPrice" runat="server" CssClass="priceBox"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="sortBy genericInputField">
                        <label for="SortBy">Sort By</label>
                        <asp:DropDownList ID="SortBy" runat="server">
                            <asp:ListItem Value="priceLTH">Price (Low to High)</asp:ListItem>
                            <asp:ListItem Value="priceHTL">Price (High to Low)</asp:ListItem>
                            <asp:ListItem Value="ratingLTH">Rating (Low to High)</asp:ListItem>
                            <asp:ListItem Value="ratingHTL">Rating (High to Low)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="uploadedBy genericInputField">
                        <label for="UploadedBy">Uploaded By</label>
                        <asp:TextBox ID="UploadedBy" runat="server" placeholder="Tutor Name"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="coursesList">
            <div class="courseCard">
                <img src="https://placehold.co/600x400" alt="Placeholder" />
                <p class="courseName">Course Name</p>
                <p class="tutorName">Tutor Name</p>
                <p class="rating">Rating 4.9/5.0 (10)</p>
                <p class="coursePrice">RM 888</p>
                <div class="actions">
                    <asp:HyperLink ID="ViewDetails" runat="server" CssClass="btn btnPrimary" NavigateUrl="~/CourseContent.aspx">View Details</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart" runat="server" CssClass="btnOutlinePrimary addToCartBtn">
                        <span class="material-symbols-outlined">
                        add_shopping_cart
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
            <div class="courseCard">
                <img src="https://placehold.co/600x400" alt="Placeholder" />
                <p class="courseName">Course Name</p>
                <p class="tutorName">Tutor Name</p>
                <p class="rating">Rating 4.9/5.0 (10)</p>
                <p class="coursePrice">RM 888</p>
                <div class="actions">
                    <asp:HyperLink ID="ViewDetails2" runat="server" CssClass="btn btnPrimary">View Details</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart2" runat="server" CssClass="btnOutlinePrimary addToCartBtn">
                        <span class="material-symbols-outlined">
                        add_shopping_cart
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
            <div class="courseCard">
                <img src="https://placehold.co/600x400" alt="Placeholder" />
                <p class="courseName">Course Name</p>
                <p class="tutorName">Tutor Name</p>
                <p class="rating">Rating 4.9/5.0 (10)</p>
                <p class="coursePrice">RM 888</p>
                <div class="actions">
                    <asp:HyperLink ID="ViewDetails3" runat="server" CssClass="btn btnPrimary">View Details</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart3" runat="server" CssClass="btnOutlinePrimary addToCartBtn">
                        <span class="material-symbols-outlined">
                        add_shopping_cart
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
    <script src="Courses.js" defer></script>
</asp:Content>
