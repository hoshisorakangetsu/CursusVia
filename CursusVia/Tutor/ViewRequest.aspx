<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="ViewRequest.aspx.cs" Inherits="CursusVia.Tutor.ViewRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="ViewRequest.css" rel="stylesheet" />
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
            <span class="surfaceText reply">Replies /No Replies Yet</span>
        </div>
        <asp:Repeater ID="Repeater2" runat="server">
            <ItemTemplate>
                <div class="contentContainer">
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
                        <asp:HyperLink ID="editLink" runat="server" class="editBtn btnPrimary" NavigateUrl='<%# "ReplySupport.aspx?id=" + Eval("id")%>'>   
                            <span class="material-symbols-outlined editIcon">reply</span>
                            Reply
                        </asp:HyperLink>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <div class="noReply">
            <asp:Label ID="lblNoReplies" runat="server" CssClass="surfaceText h2"></asp:Label>
        </div>
        <div class="contentContainer">
            <div class="requestTitle">
                <h1 class="surfaceText">Tutor Name</h1>
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
    </div>
</asp:Content>
