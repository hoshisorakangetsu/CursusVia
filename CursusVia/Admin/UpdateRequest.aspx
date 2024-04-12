﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="UpdateRequest.aspx.cs" Inherits="CursusVia.Admin.UpdateRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="UpdateRequest.css" rel="stylesheet" />
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
            <h1 class="surfaceText">Title</h1>
            <p class="surfaceText">Posted on: 4/9/2024 09:00</p>
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
        <div class="edit"> 
            <div class="statusSection">
                <span class="surfaceText inputName"><b>Status: </b></span>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputField">
                    <asp:ListItem>Respond Needed</asp:ListItem>
                    <asp:ListItem>Completed</asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btnPrimary updateBtn"/>

        </div>
    </div>
    <div>
        <span class="surfaceText reply">Replies</span>
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
        <div class="edit">    
            <asp:HyperLink ID="editLink" runat="server" class="editBtn btnPrimary" NavigateUrl='EditSupport.aspx'>   
                <span class="material-symbols-outlined editIcon">edit</span>
                Edit
            </asp:HyperLink>
        </div>
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