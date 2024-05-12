<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ViewRequest.aspx.cs" Inherits="CursusVia.Customer.ViewRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ViewRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
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
                <div class="edit">    
                    <asp:HyperLink ID="editLink" runat="server" class="editBtn btnPrimary" NavigateUrl='<%# "EditSupport.aspx?id=" + Eval("id")%>'>   
                        <span class="material-symbols-outlined editIcon">edit</span>
                        Edit
                    </asp:HyperLink>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <div>
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
                    <div class="edit">    
                        <asp:HyperLink ID="editLink" runat="server" class="editBtn btnPrimary" NavigateUrl='<%# "ReplySupport.aspx?id=" + Eval("id")%>'>   
                            <span class="material-symbols-outlined editIcon">reply</span>
                            Reply
                        </asp:HyperLink>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater3" runat="server">
            <ItemTemplate>
                <div class="contentContainer">
                    <div class="requestTitle">
                        <h1 class="surfaceText"><%# "Student ID: " + Eval("student_id") %></h1>
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
    </div>
</asp:Content>
