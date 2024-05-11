<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ChapterContent.aspx.cs" Inherits="CursusVia.Customer.ChapterContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Customer/CustomerChapterContent.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="customerChapterContentMain">
        <div class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            All Courses
        </div>
        <asp:FormView ID="ChapterContentView" runat="server" DataSourceID="ChapterContentDS">
            <ItemTemplate>
                <div class="vid">
                    <video src='<%# Eval("file_path").ToString().Substring(1) %>' controls></video>
                </div>
                <div class="chapterContentContainer">
                    <h1 class="contentTitle"><%# Eval("title") %></h1>
                    <p class="contentDesc"><%# Eval("content") %></p>
                    <div class="fileResources">
                        <asp:Repeater ID="FileResourcesRepeater" runat="server" DataSourceID="FileResourcesDS" OnItemCommand="FileResources_ItemCommand">
                            <ItemTemplate>
                                <asp:LinkButton ID="FileLinkButton" runat="server" Text='<%# Eval("file_name") %>' CommandName="DownloadFile" CommandArgument='<%# Eval("id") %>' CssClass="fileObject" />
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="FileResourcesDS" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT [fr].[id], [fr].[file_name] FROM [ContentResources] INNER JOIN [FileResources] fr ON [resource_id] = [fr].[id] WHERE ([content_id] = @ContentId)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ContentId" QueryStringField="contentId" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="ChapterContentDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
        <div class="navigateCourse">
            <h1>Navigate Course</h1>
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
                                <asp:Repeater ID="ContentRepeater" runat="server" DataSourceID="ContentDS">
                                    <ItemTemplate>
                                        <div class="accordianContent">
                                            <asp:HyperLink ID="GoToContent" runat="server" CssClass="contentRow" NavigateUrl='<%# "~/Customer/ChapterContent.aspx?contentId=" + Eval("ContentId") + "&courseId=" + Eval("CourseId") %>'> 
                    <%# Eval("ContentTitle") %>
                                            </asp:HyperLink>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% // store chapter id to be used by the content data source %>
                                <asp:HiddenField ID="ChapIdForContentDS" runat="server" Value='<%# Eval("ChapterId") %>' />
                                <asp:SqlDataSource ID="ContentDS" runat="server" SelectCommand='SELECT [id] AS ContentId, [title] AS ContentTitle, (SELECT [course_id] FROM [Chapters] ch WHERE [ch].[id] = @ChapId) AS [CourseId] FROM [ChapterContents] WHERE [chapter_id] = @ChapId ORDER BY [order];' ConnectionString='<%$ ConnectionStrings:ConnectionString %>'>
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
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/AccordianInit.js") %>' defer></script>
</asp:Content>
