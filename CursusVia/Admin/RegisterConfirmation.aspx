<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="RegisterConfirmation.aspx.cs" Inherits="CursusVia.Admin.RegisterConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="../SuccessfulMessage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
   
              <div class="modal-background">
            <div class="modal">
                <div class="modal-header">
                    <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Register Successfully"></asp:Label>
                </div>
                <div class="modal-content">
                   <span class="material-symbols-outlined">
check_circle
</span>
                </div> 
                <div class="modal-footer">
                    <span class="ConfirmNote"><asp:Literal ID="litPaymentInfo" runat="server" Text="Login Now!"></asp:Literal></span>
                    <div class="buttons">
                        <asp:Button ID="btnExit" runat="server" Text="Exit" CssClass="btnExit" OnClick="btnExit_Click" />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>