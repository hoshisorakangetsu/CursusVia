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
                 <div class="genericInputField">
                     <asp:TextBox ID="txtReqTitle" runat="server" placeholder="Request Title" Columns="120" Rows="1" TextMode="MultiLine" CssClass="inputArea"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtReqTitle" ErrorMessage="Please enter the request title" CssClass="validationMessage"></asp:RequiredFieldValidator>
                 </div>
                <div class="inputContainer">
                    <span class="surfaceText inputText">Description</span>
                </div>
                <div class="genericInputField">
                    <asp:TextBox ID="txtReqContent" runat="server" placeholder="Request Content" Columns="120" Rows="10" TextMode="MultiLine" CssClass="inputArea"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="txtReqContent" ErrorMessage="Please enter the request content" CssClass="validationMessage"></asp:RequiredFieldValidator>
                </div>
                 <div class="updateBtn">
                     <asp:Button ID="btnCreate" runat="server" Text="Create" CssClass="btnPrimary btn" OnClick="btnCreate_Click" />
                 </div>
            </div>
        </div>
    </div>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>
