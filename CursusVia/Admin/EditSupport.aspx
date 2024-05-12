<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="EditSupport.aspx.cs" Inherits="CursusVia.Admin.EditSupport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="EditSupport.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText">   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="editRequestContent">
        <div class="contentContainer">
            <div>
                <h1 class="surfaceText header">Edit Support Request Reply</h1>
            </div>
            <div class="editReplyDisplay"">
                <div>
                    <span class="surfaceText inputText">Description</span>
                </div>
                <div class="genericInputField">
                    <asp:TextBox ID="txtReplyContent" runat="server" Columns="120" Rows="10" TextMode="MultiLine" CssClass="inputArea"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="txtReplyContent" ErrorMessage="Please enter the reply content" CssClass="validationMessage"></asp:RequiredFieldValidator>
                </div>
                 <div class="updateBtn">
                     <asp:Button ID="btnEdit" runat="server" Text="Update" CssClass="btnPrimary btn" OnClick="btnEdit_Click" />
                 </div>
            </div>
        </div>
    </div>
</asp:Content>
