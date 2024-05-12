<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="CourseContent.aspx.cs" Inherits="CursusVia.Customer.CourseContent" %>

<%@ Register Src="~/Controls/CustomerChapterOverview.ascx" TagPrefix="uc" TagName="CustomerChapterOverview" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Customer/CustomerCourseContent.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="customerCourseContentMain">
        <div class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            All Courses
        </div>
        <asp:FormView runat="server" ID="CourseDetailHeroView" DataSourceID="CourseDetailHeroDS" DefaultMode="ReadOnly" CssClass="w-full">
            <ItemTemplate>
                <div class="hero">
                    <img src='<%# Eval("courseImgPath").ToString().Substring(1) %>' alt="Course Image" />
                    <div class="overlay">
                        <div>
                            <p><%# Eval("tutorName") %></p>
                            <p class="courseName"><%# Eval("courseName") %></p>
                            <p class="courseDesc"><%# Eval("courseDesc") %></p>
                        </div>
                        <div class="tutorCard">
                            <div class="tutorCardTopPart">
                                <div class="tutorCardHeading">
                                    <span class="material-symbols-outlined">for_you</span> Tutor
                                </div>
                                <h2><%# Eval("tutorName") %></h2>
                                <p class="certification"><%# Eval("certification") %></p>
                                <p class="courseNum"><%# Eval("courseNum") %> Courses</p>
                            </div>
                            <div class="tutorCardRating">
                                <span>Rating</span>
                                <span><%# Eval("rating") %> / 5.0 (<%# Eval("ratingCount") %>)</span>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource runat="server" ID="CourseDetailHeroDS" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
        <div class="courseOverview">
            <h1>Course Overview</h1>
            <uc:CustomerChapterOverview runat="server" ID="CustomerChapterOverview" />
        </div>
        <div class="giveARating">
            <h1>Give a Rating</h1>
            <div class="giveRatingContainer">
                <div>
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a course rating" CssClass="validationMessage" ControlToValidate="CourseRating" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div>
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please select a tutor rating" CssClass="validationMessage" ControlToValidate="TutorRating" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <asp:Button ID="SubmitRating" Text="Submit" runat="server" CssClass="btn btnPrimary" OnClick="SubmitRating_Click" />
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>
