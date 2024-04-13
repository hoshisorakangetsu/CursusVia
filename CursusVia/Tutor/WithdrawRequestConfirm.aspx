<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="WithdrawRequestConfirm.aspx.cs" Inherits="CursusVia.Tutor.WithdrawRequestConfirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
 <link href="ViewWithdraw.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <!-- This can be use for the pop messages -->
          <div class="modal-background">
            <div class="modal">
                <div class="modal-header">
                    <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Withdraw Request Confirmation"></asp:Label>
                </div>
                <div class="modal-content">
                    <div class="detail-item">
                        <asp:Label ID="lblWithdrawalID" runat="server" Text="Bank Name"></asp:Label>
                        <asp:Literal ID="litWithdrawalID" runat="server" Text="RHB"></asp:Literal>
                    </div>
                    <div class="detail-item">
                        <asp:Label ID="lblAccHName" runat="server" Text="Account Holder Name:"></asp:Label>
                        <span class="litAvaiBalance"><asp:Literal ID="litHName" runat="server" Text="Matt Abukkai"></asp:Literal></span>
                    </div>
                    <div class="detail-item">
                        <asp:Label ID="lblAccount" runat="server" Text="Account Number:"></asp:Label>
                        <span class="litAvaiBalance"><asp:Literal ID="LitAccNo" runat="server" Text="1212155515"></asp:Literal></span>
                    </div>
                    <div class="detail-item">
                        <asp:Label ID="lblAmount" runat="server" Text="Amount:"></asp:Label>
                        <span class="litAvaiBalance"><asp:Literal ID="litAmount" runat="server" Text="RM 1,000"></asp:Literal></span>
                    </div>
                </div> 
                <div class="modal-footer">
                    <span class="ConfirmNote"><asp:Literal ID="litPaymentInfo" runat="server" Text="By confirming this details, the update or cancellation might not be accepted"></asp:Literal></span>
                    <div class="buttons">
                        <asp:Button ID="btnWithdrawal" runat="server" Text="Confirm" CssClass="btnWithdrawal" OnClick="btnWithdrawal_Click" />
                        <asp:Button ID="btnCanWithdrawal" runat="server" Text="Cancel" CssClass="btnCanWithdrawal" OnClick="btnCanWithdrawal_Click" />
                    </div>
                </div>
            </div>
        </div>

</asp:Content>
