<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdateCourse.aspx.cs" Inherits="CursusVia.Tutor.UpdateCourse" %>

<%@ Register Src="~/Controls/FileUploadWithPreview.ascx" TagPrefix="uc" TagName="FileUploadWithPreview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Tutor/CreateUpdateCourse.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="createUpdateCourseMain">
        <div class="backControl">
            <span class="material-symbols-outlined">
            arrow_back
            </span>
            All Courses
        </div>
        <% // no need is required because there will always be an image d, the user cannot remove the uploaded image %>
        <uc:FileUploadWithPreview runat="server" ID="CourseImgUploadWithPreview" IsRequired="false" />
        <div class="fields">
            <div class="genericInputField">
                <asp:Label AssociatedControlID="CourseTitle" runat="server">Course Title</asp:Label>
                <asp:TextBox ID="CourseTitle" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a title for the course" ControlToValidate="CourseTitle" CssClass="validationMessage" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="genericInputField">
                <asp:Label AssociatedControlID="Price" runat="server">Price</asp:Label>
                <asp:TextBox ID="Price" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter a price (RM) for the course" ControlToValidate="Price" CssClass="validationMessage" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Please only enter numbers (accepted 0-9 and .)" ControlToValidate="Price" CssClass="validationMessage" ValidationExpression="\d+\.?\d+" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>
            <div class="genericInputField">
                <asp:Label AssociatedControlID="CourseCategory" runat="server">Category</asp:Label>
                <asp:DropDownList ID="CourseCategory" runat="server">
                    <asp:ListItem Selected="True" Value="cannot_select">-</asp:ListItem>
                    <asp:ListItem Value="web_development">Web Development</asp:ListItem>
                    <asp:ListItem Value="digital_marketing">Digital Marketing</asp:ListItem>
                    <asp:ListItem Value="graphic_design">Graphic Design</asp:ListItem>
                    <asp:ListItem Value="mobile_apps">Mobile Apps</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select a category to place this course in" ControlToValidate="CourseCategory" 
                InitialValue="cannot_select" CssClass="validationMessage" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="genericInputField">
                <asp:Label AssociatedControlID="Description" runat="server">Course Description</asp:Label>
                <!-- 
                    quick one liner for auto resizing textbox based on number of rows 
                    drawbacks: won't work for copy paste, will resize for the first time the user hits enter
                -->
                <asp:TextBox ID="Description" runat="server" TextMode="MultiLine" Rows="10" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter a description for the course" ControlToValidate="Description" CssClass="validationMessage" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
        </div>
        <asp:Button ID="submitForm" CssClass="btn btnPrimary" Text="Save Updated Course" runat="server" OnClick="submitForm_Click" />
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>
