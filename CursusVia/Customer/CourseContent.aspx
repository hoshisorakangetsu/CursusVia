<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="CourseContent.aspx.cs" Inherits="CursusVia.Customer.CourseContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Customer/CustomerCourseContent.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="customerCourseContentMain">
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
                <div class="tutorCard">
                    <div class="tutorCardTopPart">
                        <div class="tutorCardHeading">
                            <span class="material-symbols-outlined">for_you
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
        <div class="courseOverview">
            <h1>Course Overview</h1>
            <div class="accordianContainer">
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <h2>Chapter 1</h2>
                        <div class="rightSide">
                            <p class="itemCount">2 Items</p>
                            <span class="material-symbols-outlined chevron">expand_more
                            </span>
                        </div>
                    </div>
                    <div class="accordianContentWrapper">
                        <div class="accordianContent">
                            <asp:HyperLink ID="GoToContent" runat="server" CssClass="contentRow" NavigateUrl="~/Customer/CourseContent.aspx">
                                Content 1
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
                <!-- replace with repeater when coding backend -->
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <h2>Chapter 2</h2>
                        <div class="rightSide">
                            <p class="itemCount">2 Items</p>
                            <span class="material-symbols-outlined chevron">expand_more
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
        <div class="giveARating">
            <h1>Give a Rating</h1>
            <div class="giveRatingContainer">
                <p>How satisfied are you with the course?</p>
                <div class="ratingControl">
                    <span>Not Satisfied</span>
                    <div class="ratingRBL">
                        <asp:RadioButtonList ID="CourseRating" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="1"></asp:ListItem>
                            <asp:ListItem Value="2"></asp:ListItem>
                            <asp:ListItem Value="3"></asp:ListItem>
                            <asp:ListItem Value="4"></asp:ListItem>
                            <asp:ListItem Value="5"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <span>Very Satisfied</span>
                </div>
                <p>How satisfied are you with the tutor?</p>
                <div class="ratingControl">
                    <span>Not Satisfied</span>
                    <div class="ratingRBL">
                        <asp:RadioButtonList ID="TutorRating" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="1"></asp:ListItem>
                            <asp:ListItem Value="2"></asp:ListItem>
                            <asp:ListItem Value="3"></asp:ListItem>
                            <asp:ListItem Value="4"></asp:ListItem>
                            <asp:ListItem Value="5"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <span>Very Satisfied</span>
                </div>
                <asp:Button ID="SubmitRating" Text="Submit" runat="server" CssClass="btn btnPrimary" />
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/AccordianInit.js") %>' defer></script>
</asp:Content>
