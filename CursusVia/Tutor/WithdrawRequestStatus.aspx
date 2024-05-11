<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="WithdrawRequestStatus.aspx.cs" Inherits="CursusVia.Tutor.WithdrawRequestStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
     <link href="WithdrawSbmStyle.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
  <h1 style="margin: 1rem; margin-bottom: .5rem;">Withdraw Requests</h1>
    <asp:GridView ID="gvWithdrawRequests" runat="server" AutoGenerateColumns="False" CssClass="withdraw-requests-grid">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Request ID" SortExpression="id" />
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
            <asp:BoundField DataField="request_date" HeaderText="Request Date" SortExpression="request_date" DataFormatString="{0:yyyy-MM-dd}" />
        </Columns>
    </asp:GridView>
    <div class="withdrawal-notice">
        <asp:Literal ID="litWithdrawalNotice" runat="server" Text="The Status Will change when the update made from the Admin side." />
    </div>
</asp:Content>
