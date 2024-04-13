<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ChapterContent.aspx.cs" Inherits="CursusVia.Customer.ChapterContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Customer/CustomerChapterContent.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="customerChapterContentMain">
        <div class="backControl">
            <span class="material-symbols-outlined">
            arrow_back
            </span>
            All Courses
        </div>
        <div class="vid">
            <video controls src="https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" alt="Course Image" />
        </div>
        <div class="chapterContentContainer">
            <h1 class="contentTitle">Content 1</h1>
            <p class="contentDesc">Content Description</p>
            <div class="fileResources">
                <div class="fileObject">file1.js</div>
                <div class="fileObject">file2.js</div>
            </div>
        </div>
        <div class="navigateCourse">
            <h1>Navigate Course</h1>
            <div class="accordianContainer">
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <h2>Chapter 1</h2>
                        <div class="rightSide">
                            <p class="itemCount">1 Items</p>
                            <span class="material-symbols-outlined chevron">expand_more
                            </span>
                        </div>
                    </div>
                    <div class="accordianContentWrapper">
                        <div class="accordianContent">
                            <asp:HyperLink ID="GoToContent" runat="server" CssClass="contentRow" NavigateUrl="~/Customer/ChapterContent.aspx">
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
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/AccordianInit.js") %>' defer></script>
</asp:Content>
