<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="MyCourses.aspx.cs" Inherits="CursusVia.Customer.MyCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Courses.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="coursesMain">
        <!-- why vs eh auto format for inline expressions so ugly eh -->
        <% if (String.IsNullOrEmpty(Request.QueryString.Get("search")))
            {  %>
        <h1>Purchased Courses</h1>
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
            <asp:Repeater runat="server" ID="CourseRepeater" DataSourceID="CourseRepeaterSqlDS">
                <ItemTemplate>
                    <div class="courseCard">
                        <% 
                            // this comment should not be shown to the public as it concerns the internal working, so will be enclosing it in server tags
                            // Substring 1 because the upload file utils include "~", which is not understandable by client browsers 
                        %>
                        <img src='<%# Eval("courseImgPath").ToString().Substring(1) %>' alt="Placeholder" />
                        <p class="courseName"><%# Eval("title") %></p>
                        <p class="tutorName"><%# Eval("tutorName") %></p>
                        <div class="actions">
                            <asp:HyperLink ID="ViewDetails" runat="server" CssClass="btn btnPrimary" NavigateUrl='<%# "~/Customer/CourseContent.aspx?id=" + Eval("id") %>'>Start Learning</asp:HyperLink>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="CourseRepeaterSqlDS" runat="server"></asp:SqlDataSource>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/Courses.js") %>' defer></script>
</asp:Content>
