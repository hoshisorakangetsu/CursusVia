<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="LogoutMsg.aspx.cs" Inherits="CursusVia.Tutor.LogoutMsg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="deleteLogoutMsg.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <!-- This can be use for the pop messages -->
          <div class="modal-background">
            <div class="modal">
                <div class="modal-header">
                    <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Logout Successfully !"></asp:Label>
                </div>
                <div class="modal-content">
                   <span class="material-symbols-outlined">
logout
</span>
                </div> 
                <div class="modal-footer">
                    <span class="ConfirmNote"><asp:Literal ID="litPaymentInfo" runat="server" Text="You Have Been Logged Out From Your Account."></asp:Literal></span>
                    <div class="buttons">
                        <asp:Button ID="btnExit" runat="server" Text="Ok" CssClass="btnExit" OnClick="btnExit_Click"   />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
