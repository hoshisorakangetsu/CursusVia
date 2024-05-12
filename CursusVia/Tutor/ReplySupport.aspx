<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="ReplySupport.aspx.cs" Inherits="CursusVia.Tutor.ReplySupport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="ReplySupport.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='ViewRequest.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="repliesHeader">
        <span class="surfaceText replies">Replies</span>
    </div>
    <div class="contentContainer">
        <div class="requestTitle">
            <asp:Label ID="lblAdminID" runat="server" Text="Label" CssClass="surfaceText h1"></asp:Label>
            <asp:Label ID="lblReplyTime" runat="server" Text="Label" CssClass="surfaceText"></asp:Label>
        </div>
        <div>
            <asp:Label ID="lblReply" runat="server" Text="Label" CssClass="surfaceText"></asp:Label>
        </div>
    </div>
    <div class="repliesHeader">
        <span class="surfaceText replies">Your Reply</span>
    </div>
    <div class="contentContainer replyDisplay">
        <div>
            <span class="surfaceText reply">Replies</span>
        </div>
        <div>
            <asp:TextBox ID="txtReply" runat="server" placeholder="Your Reply" Columns="100" Rows="10" TextMode="MultiLine" CssClass="inputArea"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtReply" ErrorMessage="Please enter the reply for the request" CssClass="validationMessage"></asp:RequiredFieldValidator>
        </div>
        <div class="replyBtn">
            <asp:Button ID="btnReply" runat="server" Text="Reply" CssClass="btnPrimary btn" OnClick="btnReply_Click" />
        </div>
    </div>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>
