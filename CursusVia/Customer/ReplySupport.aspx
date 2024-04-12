<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ReplySupport.aspx.cs" Inherits="CursusVia.Customer.ReplySupport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ReplySupport.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
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
            <h1 class="surfaceText">Admin ID</h1>
            <p class="surfaceText">Replies on: 4/9/2024 12:00</p>
        </div>
        <div>
            <p class="surfaceText">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget ex vitae sem tincidunt venenatis posuere eget elit. 
                Etiam vel sagittis dui. Integer aliquet sapien a tellus tristique, eu tristique eros tincidunt. 
                Cras bibendum metus eu quam fermentum, ut eleifend nunc elementum. Nulla sodales erat quis massa pulvinar, non volutpat orci finibus. 
                Mauris ultrices non leo id ornare. Vivamus ipsum lacus, volutpat sit amet est eget, convallis dapibus ligula. 
                Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer egestas nisi pulvinar, pretium tellus eu, accumsan odio. 
                Integer ornare ex non ipsum gravida blandit. Nullam vulputate ligula ut tristique facilisis. Sed sed orci velit. 
                Duis sagittis ante eget ligula mattis auctor. Vivamus vel sem dolor. Cras euismod tortor vitae nisl feugiat vestibulum. 
                Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
            </p>
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
            <textarea id="TextArea1" cols="120" rows="10" placeholder="Your Reply" class="inputArea"></textarea>
        </div>
        <div class="replyBtn">
            <asp:Button ID="btnReply" runat="server" Text="Reply" CssClass="btnPrimary btn" />
        </div>
    </div>
</asp:Content>
