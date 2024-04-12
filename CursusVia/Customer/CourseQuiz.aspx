<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="CourseQuiz.aspx.cs" Inherits="CursusVia.Customer.CourseQuiz" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Customer/CustomerCourseQuiz.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/Accordian.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="courseQuizMain">
        <div class="backControl">
            <span class="material-symbols-outlined">
            arrow_back
            </span>
            All Courses
        </div>
        <!-- can use data attributes to get the question id when performing ajax -->
        <div class="question" data-qid="1">
            <h1>Question 1</h1>
            <p class="questionDesc">This is a question</p>
            <!-- use individual html checkboxes rather than checkboxlist to ease custom behaviors and use of ajax -->
            <div class="questionAnswerSection">
                <div class="questionAnswer">
                    <input type="checkbox" value="answer1" id="answer1" />
                    <label for="answer1">This is an answer</label>
                </div>
                <div class="questionAnswer">
                    <input type="checkbox" value="answer1" id="answer2" />
                    <label for="answer2">This is an answer</label>
                </div>
                <div class="questionAnswer correctAnswer">
                    <input type="checkbox" value="answer1" id="answer3" />
                    <label for="answer3">This is a correct answer</label>
                </div>
                <div class="questionAnswer wrongAnswer">
                    <input type="checkbox" value="answer1" id="answer4" />
                    <label for="answer4">This is an wrong answer</label>
                </div>
            </div>
        </div>
        <!-- TODO extract into js file and add functionality-->
        <button onclick="return false" class="btn btnPrimary" id="submitQuizAnswers">Submit Answers</button>
        <div class="navigateCourse">
            <h1>Navigate Course</h1>
            <div class="accordianContainer">
                <div class="accordianItem">
                    <div class="accordianActivator">
                        <h2>Chapter 1</h2>
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
</asp:Content>
