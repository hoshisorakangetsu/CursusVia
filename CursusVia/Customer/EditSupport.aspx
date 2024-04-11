﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="EditSupport.aspx.cs" Inherits="CursusVia.Customer.EditSupport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="EditSupport.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='ViewRequest.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="editRequestContent">
        <div class="contentContainer">
            <div>
                <h1 class="surfaceText header">Edit Support Request</h1>
            </div>
            <div class="editReplyDisplay"">
                 <div>
                     <span class="surfaceText inputText">Title</span>
                 </div>
                 <div>
                     <textarea id="Text1" cols="120" rows="1" class="inputArea">Current Title</textarea>
                 </div>
                <div>
                    <span class="surfaceText inputText">Description</span>
                </div>
                <div>
                    <textarea id="TextArea" cols="120" rows="10" class="inputArea">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget ex vitae sem tincidunt venenatis posuere eget elit. Etiam vel sagittis dui. Integer aliquet sapien a tellus tristique, eu tristique eros tincidunt. Cras bibendum metus eu quam fermentum, ut eleifend nunc elementum. Nulla sodales erat quis massa pulvinar, non volutpat orci finibus. Mauris ultrices non leo id ornare. Vivamus ipsum lacus, volutpat sit amet est eget, convallis dapibus ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer egestas nisi pulvinar, pretium tellus eu, accumsan odio. Integer ornare ex non ipsum gravida blandit. Nullam vulputate ligula ut tristique facilisis. Sed sed orci velit. Duis sagittis ante eget ligula mattis auctor. Vivamus vel sem dolor. Cras euismod tortor vitae nisl feugiat vestibulum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
                    </textarea>
                </div>
                 <div class="updateBtn">
                     <asp:Button ID="btnReply" runat="server" Text="Update" CssClass="btnPrimary btn" />
                 </div>
            </div>
        </div>
    </div>
</asp:Content>
