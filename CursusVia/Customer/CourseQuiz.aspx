<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="CourseQuiz.aspx.cs" Inherits="CursusVia.Customer.CourseQuiz" %>

<%@ Register Src="~/Controls/CustomerChapterOverview.ascx" TagPrefix="uc" TagName="CustomerChapterOverview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Customer/CustomerCourseQuiz.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="courseQuizMain">
        <asp:HyperLink ID="backControl" runat="server" class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            All Courses
        </asp:HyperLink>
        <% // does not store the user's responses so they can try again next time by reloading or coming back to the same page %>
        <asp:Repeater ID="RptQuestions" runat="server" DataSourceID="QuestionDS">
            <ItemTemplate>
                <div class="question" data-qid='<%# Eval("QuestionId") %>'>
                    <h1>Question <%# Eval("QuestionNumber") %></h1>
                    <p class="questionDesc"><%# Eval("QuestionContent") %></p>
                    <div class="questionAnswerSection">
                        <asp:Repeater ID="rptAnswers" runat="server" DataSourceID="AnswerDS">
                            <ItemTemplate>
                                <div class="questionAnswer">
                                    <input type="checkbox" value='<%# Eval("AnswerId") %>' id='<%# Eval("AnswerId") %>' />
                                    <label for='<%# Eval("AnswerId") %>'><%# Eval("AnswerContent") %></label>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:HiddenField ID="QuestionIdControl" runat="server" Value='<%# Eval("QuestionId") %>' />
                        <asp:SqlDataSource ID="AnswerDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT [QA].[answer_id] AS AnswerId, [A].[answer_content] AS AnswerContent FROM [QuizAnswers] QA INNER JOIN [Answers] A ON [QA].[answer_id] = [A].[id] WHERE [QA].[question_id] = @QuestionId">
                            <SelectParameters>
                                <asp:ControlParameter Name="QuestionId" Type="Int32" ControlID="QuestionIdControl" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="QuestionDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
        <button onclick="submitQuiz(event)" class="btn btnPrimary" id="submitQuizAnswers">Submit Answers</button>
        <div class="navigateCourse">
            <h1>Navigate Course</h1>
            <uc:CustomerChapterOverview runat="server" ID="CustomerChapterOverviewControl" />
        </div>
    </div>
    <% // in case got very long load time, show user loading overlay %>
    <div class="loading">
        <span class="material-symbols-outlined loadingIcon">
            progress_activity
        </span>
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/Customer/CourseQuizSubmit.js") %>' defer></script>
</asp:Content>
