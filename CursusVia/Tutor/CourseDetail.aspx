﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="CursusVia.Tutor.CourseDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Modal.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Tutor/TutorCourseDetail.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="tutorCourseContentMain">
        <asp:HyperLink ID="backControl" runat="server" CssClass="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            All Courses
        </asp:HyperLink>
        <asp:FormView runat="server" ID="CourseDetailHeroView" DataSourceID="CourseDetailHeroDS" DefaultMode="ReadOnly" CssClass="w-full">
            <ItemTemplate>
                <div class="hero">
                    <img src='<%# Eval("courseImgPath").ToString().Substring(1) %>' alt="Course Image" />
                    <div class="overlay">
                        <div>
                            <p><%# Eval("tutorName") %></p>
                            <p class="courseName"><%# Eval("title") %></p>
                            <p class="courseDesc"><%# Eval("description") %></p>
                        </div>
                        <div class="action">
                            <asp:HyperLink ID="UpdateCourse" runat="server" CssClass="updateCourseBtn btn btnPrimary" NavigateUrl='<%# "~/Tutor/UpdateCourse.aspx?id=" + Eval("id") %>'>
                                    <span class="updateIcon material-symbols-outlined">edit</span>
                                    Edit
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource runat="server" ID="CourseDetailHeroDS" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
        <div class="courseOverview">
            <div class="courseOverviewHeading">
                <h1>Course Overview</h1>
                <button id="newChapterBtn" class="btn btnPrimary" onclick='openModalForEdit(event, -1, "")'>New Chapter</button>
            </div>
            <div class="accordianContainer">
                <asp:Repeater ID="ChapterRepeater" runat="server" DataSourceID="ChapterDS">
                    <ItemTemplate>
                        <div class="accordianItem">
                            <div class="accordianActivator">
                                <div class="chapterTitleAction" onclick='openModalForEdit(event, <%# Eval("ChapterId") %>, `<%# Eval("ChapterTitle") %>`)'>
                                    <h2><%# Eval("ChapterTitle") %></h2>
                                    <span class="updateIcon material-symbols-outlined">edit</span>
                                </div>
                                <div class="rightSide">
                                    <div class="newItemControls">
                                        <% // save courseId for use of redirect %>
                                        <asp:HyperLink ID="NewChapterContent" runat="server" CssClass="btn btnPrimary" NavigateUrl='<%# "~/Tutor/CreateCourseContent.aspx?chapId=" + Eval("ChapterId") + "&courseId=" + Eval("CourseId") %>'>New Content</asp:HyperLink>
                                        <button id="NewChapterQuiz" class="btn btnOutlinePrimary" onclick='openModalForNewQuiz(event, <%# Eval("ChapterId") %>)'>New Quiz</button>
                                    </div>
                                    <p class="itemCount"><%# Eval("ItemCount") %> Items</p>
                                    <span class="material-symbols-outlined chevron">expand_more</span>
                                </div>
                            </div>
                            <div class="accordianContentWrapper">
                                <div class="accordianContent">
                                    <asp:Repeater ID="ContentRepeater" runat="server" DataSourceID="ContentDS">
                                        <ItemTemplate>
                                            <asp:HyperLink CssClass="contentRow" NavigateUrl='<%# "~/Tutor/UpdateCourseContent.aspx?contentId=" + Eval("ContentId") + "&courseId=" + Eval("CourseId") %>' runat="server">
                                                <%# Eval("ContentTitle") %>
                                                <span class="updateIcon material-symbols-outlined">edit</span>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <% // store chapter id to be used by the content data source %>
                                    <asp:HiddenField ID="ChapIdForContentDS" runat="server" Value='<%# Eval("ChapterId") %>' />
                                    <asp:SqlDataSource ID="ContentDS" runat="server" SelectCommand='SELECT [id] AS ContentId, [title] AS ContentTitle, (SELECT [course_id] FROM [Chapters] ch WHERE [ch].[id] = @ChapId) AS [CourseId] FROM [ChapterContents] WHERE [chapter_id] = @ChapId ORDER BY [order];' ConnectionString='<%$ ConnectionStrings:ConnectionString %>'>
                                        <SelectParameters>
                                            <asp:ControlParameter Name="ChapId" ControlID="ChapIdForContentDS" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Repeater ID="QuizRepeater" runat="server" DataSourceID="QuizDS">
                                        <ItemTemplate>
                                            <asp:HyperLink CssClass="contentRow" NavigateUrl='<%# "~/Tutor/UpdateQuiz.aspx?quizId=" + Eval("QuizId") + "&chapterId=" + Eval("ChapterId") + "&courseId=" + Eval("CourseId") %>' runat="server">
                                                <%# Eval("QuizTitle") %>
                                                <span class="updateIcon material-symbols-outlined">edit</span>
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <% // store chapter id to be used by the content data source %>
                                <asp:SqlDataSource ID="QuizDS" runat="server" SelectCommand='SELECT cq.[id] AS QuizId, cq.[quiz_title] AS QuizTitle, cq.[chapter_id] AS ChapterId, c.[course_id] AS CourseId FROM [ChapterQuiz] cq INNER JOIN [Chapters] c ON cq.[chapter_id] = c.[id] WHERE cq.[chapter_id] = @ChapId' ConnectionString='<%$ ConnectionStrings:ConnectionString %>'>
                                    <SelectParameters>
                                        <asp:ControlParameter Name="ChapId" ControlID="ChapIdForContentDS" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="ChapterDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>'></asp:SqlDataSource>
            </div>
        </div>
    </div>
    <div class="modalContainer" id="chapterFieldModalContainer">
        <div class="modal" id="chapterFieldModal">
            <button id="closeChapterModal" class="closeModal">
                <span class="material-symbols-outlined">close
                </span>
            </button>
            <div class="chapterField">
                <!-- use this to keep track whether is create new quiz or create/update chapter -->
                <asp:HiddenField ID="ModalType" runat="server" />
                <!-- see if possible, if not then use js and AJAX handle alrd, use this hidden input to track whether it is new chapter or edit current chapter -->
                <asp:HiddenField ID="ChapterModalId" runat="server" />
                <asp:TextBox ID="ChapterTitleTxt" runat="server" placeholder="Type Title Here"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a title" ControlToValidate="ChapterTitleTxt" Display="Dynamic" CssClass="validationMessage"></asp:RequiredFieldValidator>
                <asp:Button ID="ChapterModalBtn" runat="server" Text="Submit" CssClass="btn btnPrimary surface-text" OnClick="ChapterModalBtn_Click" />
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/AccordianInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/ModalGeneral.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
    <!-- no need extract, specific to this file one -->
    <script defer>
        const chapterModal = document.querySelector("#chapterFieldModalContainer");
        document.querySelector("#newChapterBtn").addEventListener("click", e => {
            e.preventDefault();
            openModal(chapterModal);
        });

        chapterModal.addEventListener("click", _e => {
            closeModal(chapterModal);
        })

        chapterModal.querySelector("#closeChapterModal").addEventListener("click", e => {
            e.preventDefault();
            closeModal(chapterModal);
        })

        // dont bubble up the event when click inside the modal
        document.querySelector("#chapterFieldModal").addEventListener("click", e => e.stopPropagation());

        function openModalForEdit(e, chapterId, currentTitle) {
            e.stopPropagation();
            chapterModal.querySelector("#<%= ModalType.ClientID %>").value = "CHAPTER";
            chapterModal.querySelector("#<%= ChapterModalId.ClientID %>").value = chapterId;
            // same applies, directly get the one and only text input
            chapterModal.querySelector("input[type=text]").value = currentTitle;
            openModal(chapterModal);
        }

        function openModalForNewQuiz(e, chapId) {
            e.preventDefault();
            e.stopPropagation();
            chapterModal.querySelector("#<%= ModalType.ClientID %>").value = "QUIZ";
            chapterModal.querySelector("#<%= ChapterModalId.ClientID %>").value = chapId;
            // same applies, directly get the one and only text input
            chapterModal.querySelector("input[type=text]").value = "";
            openModal(chapterModal);
        }
    </script>
</asp:Content>
