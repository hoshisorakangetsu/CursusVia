<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="deleteMsg.aspx.cs" Inherits="CursusVia.Tutor.deleteMsg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="deleteLogoutMsg.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <!-- This can be use for the pop messages -->
          <div class="modal-background">
            <div class="modal">
                <div class="modal-header">
                    <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Account Deletion Successfully !"></asp:Label>
                </div>
                <div class="modal-content">
                   <span class="material-symbols-outlined">
delete
</span>
                </div> 
                <div class="modal-footer">
                    <span class="ConfirmNote"><asp:Literal ID="litPaymentInfo" runat="server" Text="Your account has been deleted successfully."></asp:Literal></span>
                    <div class="buttons">
                        <asp:Button ID="btnExit" runat="server" Text="Ok" CssClass="btnExit" OnClick="btnExit_Click"  />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
