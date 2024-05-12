<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="ViewRequest.aspx.cs" Inherits="CursusVia.Admin.ViewRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="ViewRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='SupportRequest.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="contentContainer">
        <div class="requestTitle">
            <asp:Label ID="lblRequestTitle" runat="server" Text="Label" CssClass="surfaceText h1"></asp:Label>
            <asp:Label ID="lblPostTime" runat="server" Text="Label" CssClass="surfaceText"></asp:Label>
        </div>
        <div>
            <asp:Label ID="lblDescr" runat="server" Text="Label" CssClass="surfaceText"></asp:Label>
        </div>
        <div class="edit">    
            <asp:HyperLink ID="replyLink" runat="server" class="editBtn btnPrimary" NavigateUrl='ReplySupport.aspx'>   
                <span class="material-symbols-outlined editIcon">reply</span>
                Reply
            </asp:HyperLink>
        </div>
    </div>
    <div>
        <span class="surfaceText reply">Replies</span>
    </div>
    <asp:Repeater ID="Repeater1" runat="server">
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
                <div class="edit">    
                    <asp:HyperLink ID="editLink" runat="server" class="editBtn btnPrimary" NavigateUrl='<%# "WithdrawStatusUpdate.aspx?id=" + Eval("id")%>'>   
                        <span class="material-symbols-outlined editIcon">edit</span>
                        Edit
                    </asp:HyperLink>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Repeater ID="Repeater2" runat="server">
        <ItemTemplate>
            <div class="contentContainer">
                <div class="requestTitle">
                    <h1 class="surfaceText"><%# "Requester ID: " + Eval("student_id") +  Eval("tutor_id")%></h1>
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
</asp:Content>
