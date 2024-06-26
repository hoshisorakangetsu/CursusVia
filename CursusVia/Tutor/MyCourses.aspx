﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="MyCourses.aspx.cs" Inherits="CursusVia.Tutor.MyCourses" %>

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
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btnPrimary searchBtn" OnClick="SearchButton_Click" />
                </div>
                <div class="rightControl">
                    <asp:HyperLink ID="CreateCourse" runat="server" CssClass="btn btnPrimary" NavigateUrl="~/Tutor/CreateCourse.aspx">New Course</asp:HyperLink>
                </div>
            </div>
        </div>
        <div class="coursesList">
            <asp:Repeater runat="server" ID="CourseRepeater" DataSourceID="CourseRepeaterSqlDS" OnItemCommand="CourseRepeater_ItemCommand">
                <ItemTemplate>
                    <div class="courseCard">
                        <% 
                            // this comment should not be shown to the public as it concerns the internal working, so will be enclosing it in server tags
                            // Substring 1 because the upload file utils include "~", which is not understandable by client browsers 
                        %>
                        <img src='<%# Eval("courseImgPath").ToString().Substring(1) %>' alt="Placeholder" />
                        <p class="courseName"><%# Eval("title") %></p>
                        <p class="enrolled">Enrolled: <%# Eval("enrollCount") %></p>
                        <p class="rating">Rating <%# Eval("rating") %>/5.0 (<%# Eval("ratingCount") %>)</p>
                        <p class="coursePrice">RM <%# Convert.ToDecimal(Eval("price")).ToString("0.00") %></p>
                        <div class="actions">
                            <asp:HyperLink ID="ViewDetails" runat="server" CssClass="btn btnPrimary" NavigateUrl='<%# "~/Tutor/CourseDetail.aspx?id=" + Eval("id") %>'>View Details</asp:HyperLink>
                            <asp:LinkButton ID="AddToCart" runat="server" CssClass="btnOutlinePrimary secondaryAction" CommandName="DeleteCourse" CommandArgument='<%# Eval("id") %>'>
                                <span class="material-symbols-outlined">
                                    delete
                                </span>
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="CourseRepeaterSqlDS" runat="server"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
