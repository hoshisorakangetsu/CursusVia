<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdateQuiz.aspx.cs" Inherits="CursusVia.Tutor.UpdateQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Tutor/UpdateQuiz.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="updateQuizMain">
        <div class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            Course Menu
        </div>

        <div class="newQuestionField">
            <asp:TextBox ID="NewQuestion" runat="server" placeholder="Type Question Here" TextMode="MultiLine" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'" Rows="1"></asp:TextBox>
            <asp:Button ID="AddQuestion" runat="server" Text="Add Question" CssClass="btn btnPrimary" />
        </div>
        <div class="question" data-qid="1">
            <h1>Question 1</h1>
            <p class="questionDesc">This is a question <span class="material-symbols-outlined">edit</span></p>
            <!-- use individual html checkboxes rather than checkboxlist to ease custom behaviors and use of ajax -->
            <div class="questionAnswerSection">
                <div class="questionAnswer">
                    <label>This is an answer</label>
                    <!-- use AJAX to toggle, use repeater when populate, value=questionId;answerId -->
                    <div class="flex items-center">
                        <input type="checkbox" id="answer1" />
                        <label for="answer1">Is Correct?</label>
                    </div>
                </div>
                <div class="questionAnswer">
                    <label>This is an answer</label>
                    <div class="flex items-center">
                        <input type="checkbox" id="answer2" checked />
                        <label for="answer2">Is Correct?</label>
                    </div>
                </div>
            </div>
            <div class="newAnswerField">
                <asp:TextBox ID="NewAnswer" runat="server" placeholder="Type New Answer Here"></asp:TextBox>
                <asp:Button ID="AddAnswer" runat="server" Text="Add Answer" CssClass="btn btnPrimary" />
            </div>
        </div>
    </div>
</asp:Content>
