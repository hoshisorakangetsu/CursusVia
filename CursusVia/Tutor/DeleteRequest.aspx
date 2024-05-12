<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="DeleteRequest.aspx.cs" Inherits="CursusVia.Tutor.DeleteRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="DeleteRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='Support.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
     <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            <div class="contentContainer">
                <div class="requestTitle">
                    <h1 class="surfaceText"><%# Eval("title") %></h1>
                    <p class="surfaceText">Posted on: <%# Eval("date_send") %></p>
                </div>
                <div>
                    <p class="surfaceText">
                        <%# Eval("description") %>
                    </p>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <div>
        <span class="surfaceText reply">Replies</span>
    </div>
    <asp:Repeater ID="Repeater2" runat="server">
        <ItemTemplate>
            <div class="contentContainer">
                <div class="requestTitle">
                    <h1 class="surfaceText"><%# "Admin ID: " + Eval("admin_id") %></h1>
                    <p class="surfaceText">Replies on: <%# Eval("datetime") %></p>
                </div>
                <div>
                    <p class="surfaceText">
                        <%# Eval("reply") %>
                    </p>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Repeater ID="Repeater3" runat="server">
        <ItemTemplate>
            <div class="contentContainer">
                <div class="requestTitle">
                    <h1 class="surfaceText"><%# "Tutor ID: " + Eval("tutor_id") %></h1>
                    <p class="surfaceText">Replies on: <%# Eval("datetime") %></p>
                </div>
                <div>
                    <p class="surfaceText">
                        <%# Eval("reply") %>
                    </p>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <div class="noReply">
        <asp:Label ID="lblNoReplies" runat="server" CssClass="surfaceText h2"></asp:Label>
    </div>
    <div class="cfmDelete">
        <div>
            <p class="surfaceText deleteText">
                Are you sure that you want to permanently delete this support request?
            </p>
        </div>
        <div class="cancelBtn">
            <asp:Button ID="btnDelete" runat="server" Text="Confirm" CssClass="btnPrimary btn" OnClick="btnDelete_Click" />
            <asp:HyperLink ID="cancelLink" runat="server" class="btnPrimary newBtn" NavigateUrl='Support.aspx'>Cancel</asp:HyperLink>
        </div>
    </div>
</asp:Content>
