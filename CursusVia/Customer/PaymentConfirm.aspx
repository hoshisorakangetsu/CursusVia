<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="PaymentConfirm.aspx.cs" Inherits="CursusVia.Customer.PaymentConfirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="<%= ResolveUrl("~/Tutor/ViewWithdraw.css") %>" rel="stylesheet"  />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- This can be use for the pop messages -->
          <div class="modal-background">
            <div class="modal">
                <div class="modal-header">
                    <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Payment Confirmation"></asp:Label>
                </div>
                <div class="modal-content">
                    <div class="detail-item">
                        <asp:Label ID="lbPaymentMethod" runat="server" Text="Payment Method"></asp:Label>
                        <asp:Literal ID="litWithdrawalID" runat="server" Text="TNG"></asp:Literal>
                    </div>
                    <div class="detail-item">
                        <asp:Label ID="lblAccHName" runat="server" Text="Name:"></asp:Label>
                        <span class="litAvaiBalance"><asp:Literal ID="litHName" runat="server" Text="Matt Abukkai"></asp:Literal></span>
                    </div>
                    <div class="detail-item">
                        <asp:Label ID="lblAccount" runat="server" Text="Account Number:"></asp:Label>
                        <span class="litAvaiBalance"><asp:Literal ID="LitAccNo" runat="server" Text="1212155515"></asp:Literal></span>
                    </div>
                    <div class="detail-item">
                        <asp:Label ID="lblAmount" runat="server" Text="Amount:"></asp:Label>
                        <span class="litAvaiBalance"><asp:Literal ID="litAmount" runat="server" Text="RM 300"></asp:Literal></span>
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
