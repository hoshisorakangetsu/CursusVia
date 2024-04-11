<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ViewRequest.aspx.cs" Inherits="CursusVia.Customer.ViewRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ViewRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="backSelfBtn">
        <span class="material-symbols-outlined backIcon">arrow_back</span>
        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="backBtn"/>
    </div>
    <div>
        <div>
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
        <div>
            <span class="material-symbols-outlined">edit</span>
            <asp:Button ID="btnEdit" runat="server" Text="Edit" />
        </div>
    </div>
</asp:Content>
