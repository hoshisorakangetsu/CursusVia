<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="CourseContent.aspx.cs" Inherits="CursusVia.CourseContent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CourseContent.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="courseContentMain">
        <div class="hero">
            <img src="https://placehold.co/600x400" alt="Course Image" />
            <div class="overlay">
                <p>Tutor Name</p>
                <p class="courseName">Course Name</p>
                <p class="courseDesc">This course is a course</p>
                <p class="rating">Rating: 4.9/5.0 (10)</p>
                <div class="actions">
                    <asp:HyperLink ID="Enroll" runat="server" CssClass="btn btnPrimary">Enroll</asp:HyperLink>
                    <asp:HyperLink ID="AddToCart" runat="server" CssClass="btnOutlinePrimary">
                        <span class="material-symbols-outlined">
                        add_shopping_cart
                        </span>
                    </asp:HyperLink>
                </div>
            </div>
        </div>
        <div class="courseContent">
            <div class="chapterOverview">
                <h1>Chapter Overview</h1>
                <div class="accordianContainer">
                    <div class="accordianItem">
                        <div class="accordianActivator">
                            <h2>Chapter 1</h2>
                            <div class="rightSide">
                                <p class="itemCount">2 Items</p>
                                <span class="material-symbols-outlined chevron">
                                expand_more
                                </span>
                            </div>
                        </div>
                        <div class="accordianContentWrapper">
                            <div class="accordianContent">
                                <div class="contentRow">
                                    Content 1
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- replace with repeater when coding backend -->
                    <div class="accordianItem">
                        <div class="accordianActivator">
                            <h2>Chapter 2</h2>
                            <div class="rightSide">
                                <p class="itemCount">2 Items</p>
                                <span class="material-symbols-outlined chevron">
                                expand_more
                                </span>
                            </div>
                        </div>
                        <div class="accordianContentWrapper">
                            <div class="accordianContent">
                                <div class="contentRow">
                                    Content 1
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tutorCard">
                <div class="tutorCardTopPart">
                    <div class="tutorCardHeading">
                        <span class="material-symbols-outlined">
                        for_you
                        </span>
                        Tutor
                    </div>
                    <h2>Tutor Name</h2>
                    <p class="certification">Certification?</p>
                    <p class="courseNum">5 Courses</p>
                </div>
                <div class="tutorCardRating">
                    <span>Rating</span>
                    <span>4.9/5.0 (10)</span>
                </div>
            </div>
        </div>
    </div>
    <script src="AccordianInit.js" defer></script>
</asp:Content>
