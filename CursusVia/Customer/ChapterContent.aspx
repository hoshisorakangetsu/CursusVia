<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ChapterContent.aspx.cs" Inherits="CursusVia.Customer.ChapterContent" %>

<%@ Register Src="~/Controls/CustomerChapterOverview.ascx" TagPrefix="uc" TagName="CustomerChapterOverview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/CourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Customer/CustomerChapterContent.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="customerChapterContentMain">
        <asp:HyperLink ID="backControl" runat="server" class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            All Courses
        </asp:HyperLink>
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
            <uc:CustomerChapterOverview runat="server" ID="CustomerChapterOverview" />
        </div>
    </div>
</asp:Content>
