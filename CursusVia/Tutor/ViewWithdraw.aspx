<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="ViewWithdraw.aspx.cs" Inherits="CursusVia.Tutor.ViewWithdraw" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="ViewWithdraw.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">

    <div class="modal-background">
    <div class="modal">
        <div class="modal-header">
            <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Balance Details"></asp:Label>
        </div>
        <div class="modal-content">
            <div class="detail-item">
                <asp:Label ID="lblWithdrawalID" runat="server" Text="Total Enorlls"></asp:Label>
                <asp:Literal ID="litWithdrawalID" runat="server" Text="10 Students"></asp:Literal>
            </div>
            <div class="detail-item">
                <asp:Label ID="lblWithdrawalAmount" runat="server" Text="Available Balance"></asp:Label>
                <span class="litAvaiBalance"><asp:Literal ID="litAvaiBalance" runat="server" Text="RM 1,000"></asp:Literal></span>
            </div>
            <div class="detail-item">
                <asp:Label ID="lblStatus" runat="server" Text="Status"></asp:Label>
                <span class="status pending"><asp:Literal ID="litStatus" runat="server" Text="Available"></asp:Literal></span>
            </div>
        </div>
        <div class="modal-footer">
            <asp:Literal ID="litPaymentInfo" runat="server" Text="Payout Order issuance available betweenn 20th (UTC+08:00) and until 30th of each month (UTC+08:00)"></asp:Literal>
            <div class="buttons">
                <asp:Button ID="btnWithdrawal" runat="server" Text="WITHDRAWAL" CssClass="btnWithdrawal" OnClick="btnWithdrawal_Click" />
                <asp:Button ID="btnCanWithdrawal" runat="server" Text="Cancel" CssClass="btnCanWithdrawal" OnClick="btnCanWithdrawal_Click" />
            </div>
        </div>
    </div>
</div>

</asp:Content>
