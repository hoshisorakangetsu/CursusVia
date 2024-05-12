<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerChapterOverview.ascx.cs" Inherits="CursusVia.Customer.CustomerChapterOverview" %>

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
                                <asp:HyperLink ID="GoToContent" runat="server" CssClass="contentRow" NavigateUrl='<%# "~/Customer/ChapterContent.aspx?contentId=" + Eval("ContentId") + "&courseId=" + Eval("CourseId") %>'> 
                    <%# Eval("ContentTitle") %>
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
                                <asp:HyperLink CssClass="contentRow" NavigateUrl='<%# "~/Customer/CourseQuiz.aspx?quizId=" + Eval("QuizId") + "&chapterId=" + Eval("ChapterId") + "&courseId=" + Eval("CourseId") %>' runat="server">
                                                <%# Eval("QuizTitle") %>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="QuizDS" runat="server" SelectCommand='SELECT cq.[id] AS QuizId, cq.[quiz_title] AS QuizTitle, cq.[chapter_id] AS ChapterId, c.[course_id] AS CourseId FROM [ChapterQuiz] cq INNER JOIN [Chapters] c ON cq.[chapter_id] = c.[id] WHERE cq.[chapter_id] = @ChapId' ConnectionString='<%$ ConnectionStrings:ConnectionString %>'>
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
