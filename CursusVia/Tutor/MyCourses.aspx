<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="MyCourses.aspx.cs" Inherits="CursusVia.Tutor.MyCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Courses.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/BrowseCourseCard.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="coursesMain">
        <!-- why vs eh auto format for inline expressions so ugly eh -->
        <% if (String.IsNullOrEmpty(Request.QueryString.Get("search")))
            {  %>
        <h1>My Courses</h1>
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
                    <asp:HyperLink ID="CreateCourse" runat="server" CssClass="btn btnPrimary">New Course</asp:HyperLink>
                </div>
            </div>
        </div>
        <div class="coursesList">
            <div class="courseCard">
                <img src="https://placehold.co/600x400" alt="Placeholder" />
                <p class="courseName">Course Name</p>
                <p class="enrolled">Enrolled: 10</p>
                <p class="rating">Rating 4.9/5.0 (10)</p>
                <p class="coursePrice">RM 888</p>
                <div class="actions">
                    <asp:HyperLink ID="ViewDetails" runat="server" CssClass="btn btnPrimary" NavigateUrl="~/CourseContent.aspx">View Details</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart" runat="server" CssClass="btnOutlinePrimary addToCartBtn">
                        <span class="material-symbols-outlined">
                        delete
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
            <div class="courseCard">
                <img src="https://placehold.co/600x400" alt="Placeholder" />
                <p class="courseName">Course Name</p>
                <p class="enrolled">Enrolled: 10</p>
                <p class="rating">Rating 4.9/5.0 (10)</p>
                <p class="coursePrice">RM 888</p>
                <div class="actions">
                    <asp:HyperLink ID="ViewDetails2" runat="server" CssClass="btn btnPrimary">View Details</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart2" runat="server" CssClass="btnOutlinePrimary addToCartBtn">
                        <span class="material-symbols-outlined">
                        delete
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
            <div class="courseCard">
                <img src="https://placehold.co/600x400" alt="Placeholder" />
                <p class="courseName">Course Name</p>
                <p class="enrolled">Enrolled: 10</p>
                <p class="rating">Rating 4.9/5.0 (10)</p>
                <p class="coursePrice">RM 888</p>
                <div class="actions">
                    <asp:HyperLink ID="ViewDetails3" runat="server" CssClass="btn btnPrimary">View Details</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart3" runat="server" CssClass="btnOutlinePrimary addToCartBtn">
                        <span class="material-symbols-outlined">
                        delete
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
