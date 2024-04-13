<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="WithdrawRequestStatus.aspx.cs" Inherits="CursusVia.Tutor.WithdrawRequestStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
     <link href="WithdrawSbmStyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
        <h2>Withdraw Requests</h2>

    <div class="balance-container">
    <div class="Status-text">
        <span class="lbRequestID"><asp:Label ID="lbRequestID" runat="server" Text="Request ID:"></asp:Label></span>
        <span class="litID"><asp:Literal ID="litID" runat="server" Text="0001"></asp:Literal></span>
    </div>
        <span class="litStatus"><asp:Literal ID="litStatus" runat="server" Text="Pending"></asp:Literal></span>
</div>
    <div class="withdrawal-notice">
        <asp:Literal ID="litWithdrawalNotice" runat="server" Text="The Status Will change when the update made from the Admin side." />
    </div>
</asp:Content>
