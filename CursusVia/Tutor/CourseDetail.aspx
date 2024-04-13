<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="CursusVia.Tutor.CourseDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Modal.css") %>' rel="stylesheet" />
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
                <button id="newChapterBtn" class="btn btnPrimary">New Chapter</button>
            </div>
            <div class="accordianContainer">
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <div class="chapterTitleAction" onclick="openModalForEdit(event, 1, 'Chapter 1')">
                            <h2>Chapter 1</h2>
                            <span class="updateIcon material-symbols-outlined">edit
                            </span>
                        </div>
                        <div class="rightSide">
                            <div class="newItemControls">
                                <asp:HyperLink ID="NewChapterContent" runat="server" CssClass="btn btnPrimary" NavigateUrl="~/Tutor/CreateCourseContent.aspx">New Content</asp:HyperLink>
                                <!-- TODO change me, create a quiz first only redirect to this page -->
                                <asp:HyperLink ID="NewChapterQuiz" runat="server" CssClass="btn btnOutlinePrimary" NavigateUrl="~/Tutor/UpdateQuiz.aspx">New Quiz</asp:HyperLink>
                            </div>
                            <p class="itemCount">1 Items</p>
                            <span class="material-symbols-outlined chevron">expand_more
                            </span>
                        </div>
                    </div>
                    <div class="accordianContentWrapper">
                        <div class="accordianContent">
                            <asp:HyperLink CssClass="contentRow" NavigateUrl="~/Tutor/UpdateCourseContent.aspx" runat="server">
                                Content 1
                                <span class="updateIcon material-symbols-outlined">edit
                                </span>
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
                <!-- replace with repeater when coding backend -->
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <div class="chapterTitleAction" onclick="openModalForEdit(event, 2, 'Chapter 2')">
                            <h2>Chapter 2</h2>
                            <span class="updateIcon material-symbols-outlined">edit
                            </span>
                        </div>
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
    <div class="modalContainer" id="chapterFieldModalContainer">
        <div class="modal" id="chapterFieldModal">
            <button id="closeChapterModal" class="closeModal">
                <span class="material-symbols-outlined">close
                </span>
            </button>
            <div class="chapterField">
                <!-- see if possible, if not then use js and AJAX handle alrd, use this hidden input to track whether it is new chapter or edit current chapter -->
                <asp:HiddenField ID="ChapterModalMode" runat="server" />
                <asp:TextBox ID="ChapterTitle" runat="server" placeholder="Type Chapter Title Here"></asp:TextBox>
                <asp:Button ID="ChapterModalBtn" runat="server" Text="Submit" CssClass="btn btnPrimary" />
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/AccordianInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/ModalGeneral.js") %>'></script>
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
            // dk how to access the hidden input field becuz the csharp scrambles the id, but for now the hack is to access the one and only hidden input field
            chapterModal.querySelector("input[type=hidden]").value = chapterId;
            // same applies, directly get the one and only text input
            chapterModal.querySelector("input[type=text]").value = currentTitle;
            openModal(chapterModal);
        }
    </script>
</asp:Content>
