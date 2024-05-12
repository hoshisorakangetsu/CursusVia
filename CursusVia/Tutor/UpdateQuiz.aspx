<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdateQuiz.aspx.cs" Inherits="CursusVia.Tutor.UpdateQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Tutor/UpdateQuiz.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Modal.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="updateQuizMain">
        <div class="backControl">
            <span class="material-symbols-outlined">arrow_back
            </span>
            Course Menu
        </div>

        <div class="newQuestionField">
            <asp:TextBox ID="NewQuestion" runat="server" placeholder="Type question here" TextMode="MultiLine" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'" Rows="1"></asp:TextBox>
            <asp:RequiredFieldValidator ID="NewQuestionFieldValidator" runat="server" ErrorMessage="Please enter a question" ControlToValidate="NewQuestion" Display="Dynamic" CssClass="validationMessage" ValidationGroup="ValNewQuestion"></asp:RequiredFieldValidator>
            <asp:Button ID="AddQuestion" runat="server" Text="Add Question" CssClass="btn btnPrimary" OnClick="AddQuestion_Click" ValidationGroup="ValNewQuestion" />
        </div>
        <asp:Repeater ID="rptQuestions" runat="server" DataSourceID="questionDS" OnItemCommand="rptQuestions_ItemCommand">
            <ItemTemplate>
                <div class="question" data-qid='<%# Eval("QuestionId") %>'>
                    <div class="flex justify-between items-center">
                        <h1>Question <%# Eval("QuestionNumber") %></h1>
                        <asp:Button ID="DeleteAns" runat="server" Text="DeleteQuestion" CssClass="btn btnPrimary" CommandName="DeleteQuestion" CommandArgument='<%# Eval("QuestionId") %>' OnClientClick="return confirm('Are you sure you want to delete this question?');" />
                    </div>
                    <p class="questionDesc" onclick='<%# "openQuestionModalForEdit(event, " + Eval("QuestionId") + ", `" + Eval("QuestionContent") + "`)" %>'>
                        <%# Eval("QuestionContent") %>
                        <span class="editIcon material-symbols-outlined">edit</span>
                    </p>
                    <!-- Answer Section -->
                    <div class="questionAnswerSection">
                        <asp:Repeater ID="rptAnswer" runat="server" DataSourceID="AnswerDS" OnItemCommand="rptAnswer_ItemCommand">
                            <ItemTemplate>
                                <div class="questionAnswer">
                                    <label class="answerDesc" onclick='<%# "openAnswerModalForEdit(event, " + Eval("AnswerId") + ", `" + Eval("AnswerContent") + "`)" %>'><%# Eval("AnswerContent") %><span class="editIcon material-symbols-outlined">edit</span></label>
                                    <div class="flex items-center answerRight">
                                        <div class="flex items-center">
                                            <% // format is questionId;answerId %>
                                            <asp:HiddenField ID="AnswerAndQuestionIdControl" runat="server" Value='<%# Eval("QuestionId") + ";" + Eval("AnswerId") %>' />
                                            <asp:CheckBox ID="chkIsCorrect" runat="server" Checked='<%# Eval("IsCorrect") %>' OnCheckedChanged="chkIsCorrect_CheckedChanged" AutoPostBack="true" />
                                            <label>Is Correct?</label>
                                        </div>
                                        <asp:Button ID="DeleteAns" runat="server" Text="Delete" CssClass="btn btnPrimary" CommandName="DeleteAnswer" CommandArgument='<%# Eval("QuestionId") + ";" + Eval("AnswerId") %>' OnClientClick="return confirm('Are you sure you want to delete this answer?');"  />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:HiddenField ID="QuestionIdControl" runat="server" Value='<%# Eval("QuestionId") %>' />
                        <asp:SqlDataSource ID="AnswerDS" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                            SelectCommand="SELECT [QA].[answer_id] AS AnswerId, [QA].[question_id] AS QuestionId, [A].[answer_content] AS AnswerContent, [QA].[is_correct] AS IsCorrect FROM [QuizAnswers] QA INNER JOIN [Answers] A ON [QA].[answer_id] = [A].[id] WHERE [QA].[question_id] = @QuestionId">
                            <SelectParameters>
                                <asp:ControlParameter Name="QuestionId" Type="Int32" ControlID="QuestionIdControl" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <!-- New Answer Field -->
                    <div class="newAnswerField">
                        <asp:TextBox ID="NewAnswer" runat="server" placeholder="Type New Answer Here"></asp:TextBox>
                        <div></div>
                        <asp:Button ID="AddAnswer" runat="server" Text="Add Answer" CommandName="NewAnswer" CommandArgument='<%# Eval("QuestionId") %>' CssClass="btn btnPrimary btnGrid" />
                        <asp:Label ID="NewAnswerRequiredText" runat="server" Text="Please enter an answer" CssClass="validationMessage" Visible="False"></asp:Label>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:SqlDataSource ID="questionDS" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"></asp:SqlDataSource>
    </div>
    <div class="modalContainer" id="quizQuestionModalContainer">
        <div class="modal" id="quizQuestionFieldModal">
            <button id="closeQuizModal" class="closeModal">
                <span class="material-symbols-outlined">close
                </span>
            </button>
            <div class="quizQuestionField">
                <asp:HiddenField ID="QuizQuestionID" runat="server" />
                <asp:TextBox ID="EditQuizQuestion" runat="server" TextMode="MultiLine" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'" Rows="1" placeholder="Type question here"></asp:TextBox>
                <asp:RequiredFieldValidator ID="EditQuestionFieldValidator" runat="server" ErrorMessage="Please enter a question" ControlToValidate="EditQuizQuestion" Display="Dynamic" CssClass="validationMessage" ValidationGroup="ValEditQuestion"></asp:RequiredFieldValidator>
                <asp:Button ID="QuizQuestionModalBtn" runat="server" Text="Submit" CssClass="btn btnPrimary" OnClick="QuizQuestionModalBtn_Click" ValidationGroup="ValEditQuestion" />
            </div>
        </div>
    </div>
    <div class="modalContainer" id="quizAnswerModalContainer">
        <div class="modal" id="quizAnswerFieldModal">
            <button id="closeAnswerModal" class="closeModal">
                <span class="material-symbols-outlined">close
                </span>
            </button>
            <div class="quizAnswerField">
                <asp:HiddenField ID="QuizAnswerIDAnswerModal" runat="server" />
                <asp:TextBox ID="EditQuizAnswer" runat="server" placeholder="Type answer here"></asp:TextBox>
                <asp:RequiredFieldValidator ID="EditAnswerFieldValidator" runat="server" ErrorMessage="Please enter a answer" ControlToValidate="EditQuizAnswer" Display="Dynamic" CssClass="validationMessage" ValidationGroup="ValEditAnswer"></asp:RequiredFieldValidator>
                <asp:Button ID="QuizAnswerModalBtn" runat="server" Text="Submit" CssClass="btn btnPrimary" OnClick="QuizAnswerModalBtn_Click" ValidationGroup="ValEditAnswer" />
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/ModalGeneral.js") %>'></script>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
    <!-- no need extract, specific to this file one -->
    <script defer>
        /* quiz modal */
        const questionEditModal = document.querySelector("#quizQuestionModalContainer");
        questionEditModal.addEventListener("click", _e => {
            closeModal(questionEditModal);
        })

        // dont bubble up the event when click inside the modal
        document.querySelector("#quizQuestionFieldModal").addEventListener("click", e => e.stopPropagation());

        function openQuestionModalForEdit(e, questionId, currentQuestion) {
            e.stopPropagation();
            // HACK: access the one and only hidden input field
            questionEditModal.querySelector("input[type=hidden]").value = questionId;
            // same applies, directly get the one and only text input
            questionEditModal.querySelector("textarea").value = currentQuestion;
            openModal(questionEditModal);
        }
        /* end quiz modal */

        /* quiz answer modal */
        const answerEditModal = document.querySelector("#quizAnswerModalContainer");
        answerEditModal.addEventListener("click", _e => {
            closeModal(answerEditModal);
        })

        // dont bubble up the event when click inside the modal
        document.querySelector("#quizAnswerFieldModal").addEventListener("click", e => e.stopPropagation());

        function openAnswerModalForEdit(e, answerId, currentAnswer) {
            e.stopPropagation();
            // HACK: to access the one and only hidden input field
            answerEditModal.querySelector("input[type=hidden]").value = answerId;
            // same applies, directly get the one and only text input
            answerEditModal.querySelector("input[type=text]").value = currentAnswer;
            openModal(answerEditModal);
        }
        /* end quiz answer modal */
    </script>

</asp:Content>
