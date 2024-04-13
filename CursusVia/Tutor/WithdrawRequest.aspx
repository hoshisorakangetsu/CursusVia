<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="WithdrawRequest.aspx.cs" Inherits="CursusVia.Tutor.WithdrawRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="WithdrawRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="modal-background">
        <div class="modal">
            <div class="modal-header">
                <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Withdraw Request"></asp:Label>
            </div>
            <div class="modal-content">
                <div class="detail-item">
                    <asp:Label ID="lblRequestID" runat="server" Text="Request ID"></asp:Label>
                    <span class="litRequestID"><asp:Literal ID="litRequestID" runat="server" Text="00001"></asp:Literal></span>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblBankName" runat="server" Text="Bank Name"></asp:Label>
                    <asp:DropDownList ID="ddlBankName" runat="server">
                        <asp:ListItem Text="RHB" />
                        <asp:ListItem Text="PBank" />
                        <asp:ListItem Text="CIMB" />
                        <asp:ListItem Text="MAYBank" />
                        <asp:ListItem Text="HSBC" />
                    </asp:DropDownList>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblAccNo" runat="server" Text="Account Number"></asp:Label>
                    <asp:TextBox ID="txtAccNo" runat="server"></asp:TextBox>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblAccHName" runat="server" Text="Account Holder Name"></asp:Label>
                    <asp:TextBox ID="txtAccHName" runat="server"></asp:TextBox>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblWithdrawAmount" runat="server" Text="Withdraw Amount"></asp:Label>
                    <asp:TextBox ID="txtWithdrawAmount" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Literal ID="litPaymentInfo" runat="server" Text="Payout Order issuance available between the 20th and until the 30th of each month (UTC+08:00)."></asp:Literal>
                <div class="buttons">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
