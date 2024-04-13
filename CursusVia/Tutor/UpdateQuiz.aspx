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
            <asp:Button ID="AddQuestion" runat="server" Text="Add Question" CssClass="btn btnPrimary" />
        </div>
        <div class="question" data-qid="1">
            <h1>Question 1</h1>
            <p class="questionDesc" onclick="openQuestionModalForEdit(event, 1, 'This is a question')">This is a question <span class=" editIcon material-symbols-outlined">edit</span></p>
            <!-- use individual html checkboxes rather than checkboxlist to ease custom behaviors and use of ajax -->
            <div class="questionAnswerSection">
                <div class="questionAnswer">
                    <label class="answerDesc" onclick="openAnswerModalForEdit(event, 1, 'This is an answer')">This is an answer <span class="editIcon material-symbols-outlined">edit</span></label>
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
            <!-- maybe will change to ajax -->
            <div class="newAnswerField">
                <asp:TextBox ID="NewAnswer" runat="server" placeholder="Type New Answer Here"></asp:TextBox>
                <asp:Button ID="AddAnswer" runat="server" Text="Add Answer" CssClass="btn btnPrimary" />
            </div>
        </div>
    </div>
    <div class="modalContainer" id="quizQuestionModalContainer">
        <div class="modal" id="quizQuestionFieldModal">
            <button id="closeQuizModal" class="closeModal">
                <span class="material-symbols-outlined">close
                </span>
            </button>
            <div class="quizQuestionField">
                <!-- see if possible, if not then use js and AJAX handle alrd, use this hidden input to track whether it is new chapter or edit current chapter -->
                <asp:HiddenField ID="QuizQuestionID" runat="server" />
                <asp:TextBox ID="QuizQuestion" runat="server" TextMode="MultiLine" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'" Rows="1" placeholder="Type question here"></asp:TextBox>
                <asp:Button ID="QuizQuestionModalBtn" runat="server" Text="Submit" CssClass="btn btnPrimary" />
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
                <!-- see if possible, if not then use js and AJAX handle alrd, use this hidden input to track whether it is new chapter or edit current chapter -->
                <asp:HiddenField ID="QuizAnswerID" runat="server" />
                <asp:TextBox ID="QuizAnswer" runat="server" placeholder="Type answer here"></asp:TextBox>
                <asp:Button ID="QuizAnswerModalBtn" runat="server" Text="Submit" CssClass="btn btnPrimary" />
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/ModalGeneral.js") %>'></script>
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
            // dk how to access the hidden input field becuz the csharp scrambles the id, but for now the hack is to access the one and only hidden input field
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
            // dk how to access the hidden input field becuz the csharp scrambles the id, but for now the hack is to access the one and only hidden input field
            answerEditModal.querySelector("input[type=hidden]").value = answerId;
            // same applies, directly get the one and only text input
            answerEditModal.querySelector("input[type=text]").value = currentAnswer;
            openModal(answerEditModal);
        }
        /* end quiz answer modal */
    </script>

</asp:Content>
