<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="CreateCourseContent.aspx.cs" Inherits="CursusVia.Tutor.CreateCourseContent" %>

<%@ Register Src="~/Controls/FileUploadWithPreview.ascx" TagPrefix="uc" TagName="FileUploadWithPreview" %>
<%@ Register Src="~/Controls/MultiFileUpload.ascx" TagPrefix="uc" TagName="MultiFileUpload" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Tutor/CreateUpdateCourseContent.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="createUpdateCourseContentMain">
        <asp:HyperLink ID="backControl" runat="server" CssClass="backControl">
            <span class="material-symbols-outlined">
            arrow_back
            </span>
            Course Menu
        </asp:HyperLink>
        <uc:FileUploadWithPreview runat="server" ID="FileUploadWithPreview" FileType="video" IsRequired="true" />
        <div class="fields">
            <div class="genericInputField">
                <asp:Label AssociatedControlID="ContentTitle" runat="server">Content Title</asp:Label>
                <asp:TextBox ID="ContentTitle" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a title for the course content" ControlToValidate="ContentTitle" CssClass="validationMessage" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="genericInputField">
                <asp:Label AssociatedControlID="Description" runat="server">Content Description</asp:Label>
                <!-- 
                    quick one liner for auto resizing textbox based on number of rows 
                    drawbacks: won't work for copy paste, will resize for the first time the user hits enter
                -->
                <asp:TextBox ID="Description" runat="server" TextMode="MultiLine" Rows="10" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter a description for the course content" ControlToValidate="Description" CssClass="validationMessage" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>

        <label for="courseContentRes">Content Resources</label>
        <uc:MultiFileUpload runat="server" ID="MultiFileUpload" />
        <asp:Button ID="submitForm" CssClass="btn btnPrimary" Text="Create Course Content" runat="server" OnClientClick="populateFileIDs()" OnClick="submitForm_Click" />
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>

