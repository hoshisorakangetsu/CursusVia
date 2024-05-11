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
    <div class="contentContainer">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="requestTitle">
                    <h1 class="surfaceText"><%# Eval("admin_id") %></h1>
                    <p class="surfaceText">Replies on: <%# Eval("datetime") %></p>
                </div>
                <div>
                    <p class="surfaceText">
                        <%# Eval("reply") %>
                    </p>
                </div>
                <div class="edit">    
                    <asp:HyperLink ID="editLink" runat="server" class="editBtn btnPrimary" NavigateUrl='<%# "EditSupport.aspx?id=" + Eval("id")%>'>   
                        <span class="material-symbols-outlined editIcon">edit</span>
                        Edit
                    </asp:HyperLink>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="contentContainer">
        <div class="requestTitle">
            <h1 class="surfaceText">Student/Tutor Name</h1>
            <p class="surfaceText">Replies on: 4/9/2024 15:00</p>
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
</asp:Content>
