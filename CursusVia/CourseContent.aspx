<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="CourseContent.aspx.cs" Inherits="CursusVia.CourseContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CourseContent.css" rel="stylesheet" />
    <link href="Accordian.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="courseContentMain">
        <asp:HyperLink ID="backControl" runat="server" CssClass="backControl">HyperLink
            <span class="material-symbols-outlined">arrow_back
            </span>
            Browse Courses
        </asp:HyperLink>
        <asp:FormView runat="server" ID="CourseDetailHeroView" DataSourceID="CourseDetailHeroDS" DefaultMode="ReadOnly" CssClass="w-full">
            <ItemTemplate>
                <div class="hero">
                    <img src='<%# Eval("courseImgPath").ToString().Substring(1) %>' alt="Course Image" />
                    <div class="overlay">
                        <p><%# Eval("tutorName") %></p>
                        <p class="courseName"><%# Eval("courseName") %></p>
                        <p class="courseDesc"><%# Eval("courseDesc") %></p>
                        <p class="rating">Rating: <%# Eval("rating") %>/5.0 (<%# Eval("ratingCount") %>)</p>
                        <div class="actions">
                            <asp:HyperLink ID="Enroll" runat="server" CssClass="btn btnPrimary">Enroll</asp:HyperLink>
                            <asp:HyperLink ID="AddToCart" runat="server" CssClass="btnOutlinePrimary" NavigateUrl='<%# "~/Customer/AddToCart.aspx?courseId=" + Eval("id") %>'>
                                <span class="material-symbols-outlined">
                                add_shopping_cart
                                </span>
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource runat="server" ID="CourseDetailHeroDS" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
        <div class="courseContent">
            <div class="chapterOverview">
                <h1>Chapter Overview</h1>
                <div class="accordianContainer">
                    <asp:Repeater ID="ChapterRepeater" runat="server" DataSourceID="ChapterDS">
                        <ItemTemplate>
                            <div class="accordianItem">
                                <div class="accordianActivator">
                                    <h2><%# Eval("ChapterTitle") %></h2>
                                    <div class="rightSide">
                                        <p class="itemCount"><%# Eval("ItemCount") %> Items</p>
                                        <span class="material-symbols-outlined chevron">expand_more</span>
                                    </div>
                                </div>
                                <div class="accordianContentWrapper">
                                    <div class="accordianContent">
                                        <asp:Repeater ID="ContentRepeater" runat="server" DataSourceID="ContentDS">
                                            <ItemTemplate>
                                                <div class="contentRow">
                                                    <%# Eval("ContentTitle") %>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <asp:HiddenField ID="ChapIdForContentDS" runat="server" Value='<%# Eval("ChapterId") %>' />
                                        <% // store chapter id to be used by the content data source %>
                                        <asp:SqlDataSource ID="ContentDS" runat="server" SelectCommand='SELECT [title] AS ContentTitle FROM [ChapterContents] WHERE [chapter_id] = @ChapId ORDER BY [order];' ConnectionString='<%$ ConnectionStrings:ConnectionString %>'>
                                            <SelectParameters>
                                                <asp:ControlParameter Name="ChapId" ControlID="ChapIdForContentDS" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:Repeater ID="QuizRepeater" runat="server" DataSourceID="QuizDS">
                                            <ItemTemplate>
                                                <div class="contentRow">
                                                    <%# Eval("QuizTitle") %>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <% // store chapter id to be used by the content data source %>
                                        <asp:SqlDataSource ID="QuizDS" runat="server" SelectCommand='SELECT cq.[quiz_title] AS QuizTitle FROM [ChapterQuiz] cq WHERE cq.[chapter_id] = @ChapId' ConnectionString='<%$ ConnectionStrings:ConnectionString %>'>
                                            <SelectParameters>
                                                <asp:ControlParameter Name="ChapId" ControlID="ChapIdForContentDS" PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource ID="ChapterDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>'></asp:SqlDataSource>
                </div>
            </div>
            <asp:FormView ID="TutorView" runat="server" DataSourceID="TutorDS" CssClass="self-flex-start">
                <ItemTemplate>
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
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="TutorDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>'></asp:SqlDataSource>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src="AccordianInit.js" defer></script>
</asp:Content>
