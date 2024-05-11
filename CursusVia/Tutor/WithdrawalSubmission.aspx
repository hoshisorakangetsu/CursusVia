<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="WithdrawalSubmission.aspx.cs" Inherits="CursusVia.Tutor.WithdrawalSubmission" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="WithdrawSbmStyle.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">

     <h1 style="margin: 1rem; margin-bottom: .5rem;">Tutor Earning</h1>

    <div class="balance-container">
    <div class="balance-text">
        <span class="lblBalance"><asp:Label ID="lblBalance" runat="server" Text="Available Balance:"></asp:Label></span>
        <span class="litBalance"><asp:Literal ID="litBalance" runat="server" Text=""></asp:Literal></span>
    </div>
        <asp:Button ID="btnWithdraw" runat="server" Text="Withdraw" CssClass="balance-button" OnClick="btnWithdraw_Click" />
</div>
    <div class="withdrawal-notice">
        <asp:Literal ID="litWithdrawalNotice" runat="server" Text="Maximum amount to withdraw is more than RM 50 and less than or equal to the available balance." />
    </div>


</asp:Content>
