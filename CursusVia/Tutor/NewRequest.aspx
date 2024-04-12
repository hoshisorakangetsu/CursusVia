<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="NewRequest.aspx.cs" Inherits="CursusVia.Tutor.NewRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="NewRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='Support.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="editRequestContent">
        <div class="contentContainer">
            <div>
                <h1 class="surfaceText header">Create a new Support Request</h1>
            </div>
            <div class="editReplyDisplay"">
                 <div>
                     <span class="surfaceText inputText">Title</span>
                 </div>
                 <div>
                     <textarea id="Text1" cols="120" rows="1" class="inputArea" placeholder="Request Title"></textarea>
                 </div>
                <div>
                    <span class="surfaceText inputText">Description</span>
                </div>
                <div>
                    <textarea id="TextArea" cols="120" rows="10" class="inputArea" placeholder="Request Content"></textarea>
                </div>
                 <div class="updateBtn">
                     <asp:Button ID="btnCreate" runat="server" Text="Create" CssClass="btnPrimary btn" OnClick="btnCreate_Click" />
                 </div>
            </div>
        </div>
    </div>
</asp:Content>
