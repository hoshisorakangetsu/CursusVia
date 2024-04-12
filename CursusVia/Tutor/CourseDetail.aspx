<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="CursusVia.Tutor.CourseDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Tutor/TutorCourseDetail.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="tutorCourseContentMain">
        <div class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            All Courses
        </div>
        <div class="hero">
            <img src="https://placehold.co/600x400" alt="Course Image" />
            <div class="overlay">
                <div>
                    <p>Tutor Name</p>
                    <p class="courseName">Course Name</p>
                    <p class="courseDesc">This course is a course</p>
                </div>
                <div class="action">
                    <asp:HyperLink ID="UpdateCourse" runat="server" CssClass="updateCourseBtn btn btnPrimary">
                        <span class="updateIcon material-symbols-outlined">
                        edit
                        </span>
                        Edit
                    </asp:HyperLink>
                </div>
            </div>
        </div>
        <div class="courseOverview">
            <div class="courseOverviewHeading">
                <h1>Course Overview</h1>
                <asp:Button ID="NewChapterBtn" runat="server" Text="New Chapter" CssClass="btn btnPrimary" />
            </div>
            <div class="accordianContainer">
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <h2>Chapter 1</h2>
                        <div class="rightSide">
                            <div class="newItemControls">
                                <asp:HyperLink ID="NewChapterContent" runat="server" CssClass="btn btnPrimary">New Content</asp:HyperLink>
                                <asp:HyperLink ID="NewChapterQuiz" runat="server" CssClass="btn btnOutlinePrimary">New Quiz</asp:HyperLink>
                            </div>
                            <p class="itemCount">2 Items</p>
                            <span class="material-symbols-outlined chevron">expand_more
                            </span>
                        </div>
                    </div>
                    <div class="accordianContentWrapper">
                        <div class="accordianContent">
                            <div class="contentRow">
                                Content 1
                                <span class="updateIcon material-symbols-outlined">edit
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- replace with repeater when coding backend -->
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <h2>Chapter 2</h2>
                        <div class="rightSide">
                            <div class="newItemControls">
                                <asp:HyperLink ID="NewChapterContent2" runat="server" CssClass="btn btnPrimary">New Content</asp:HyperLink>
                                <asp:HyperLink ID="NewChapterQuiz2" runat="server" CssClass="btn btnOutlinePrimary">New Quiz</asp:HyperLink>
                            </div>
                            <p class="itemCount">2 Items</p>
                            <span class="material-symbols-outlined chevron">expand_more
                            </span>
                        </div>
                    </div>
                    <div class="accordianContentWrapper">
                        <div class="accordianContent">
                            <div class="contentRow">
                                Content 1
                                <span class="updateIcon material-symbols-outlined">edit
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/AccordianInit.js") %>' defer></script>
</asp:Content>
