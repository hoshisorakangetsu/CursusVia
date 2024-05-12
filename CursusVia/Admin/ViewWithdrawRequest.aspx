<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="ViewWithdrawRequest.aspx.cs" Inherits="CursusVia.Admin.ViewWithdrawRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="ViewWithdrawRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
      <div class="modal-background">
    <div class="modal">
        <div class="modal-header">
            <asp:Label ID="lblWithdrawalDetail" runat="server" Text="View Withdraw Request Details"></asp:Label>
        </div>
        <div class="modal-content">
            <div class="detail-item">
                    <asp:Label ID="Label1" runat="server" Text="Tutor Id"></asp:Label>
                    <asp:Literal ID="Literal1" runat="server" Text="02115"></asp:Literal>
            </div>
            <div class="detail-item">
                <asp:Label ID="lblWithdrawalID" runat="server" Text="Total Enorlls:"></asp:Label>
                <asp:Literal ID="Literal5" runat="server" Text="10"></asp:Literal>
                
            </div>
            <div class="detail-item">
                <asp:Label ID="lblWithdrawalAmount" runat="server" Text="Available Balance:"></asp:Label>
                <span class="litAvaiBalance"><asp:Literal ID="litAvaiBalance" runat="server" Text="RM 1,000"></asp:Literal></span>
            </div>
            <div class="detail-item">
                <asp:Label ID="Label2" runat="server" Text="Withdraw Amount:"></asp:Label>
                 <span class="litAvaiBalance"><asp:Literal ID="Literal2" runat="server" Text="RM 1,000"></asp:Literal></span>
            </div>
            
            <div class="detail-item">
                <asp:Label ID="Label3" runat="server" Text="Bank name:"></asp:Label>
                <span class="status pending"><asp:Literal ID="Literal3" runat="server" Text="RHB"></asp:Literal></span>
            </div>
            <div class="detail-item">
                <asp:Label ID="Label4" runat="server" Text="Bank Account:"></asp:Label>
                <span class="status pending"><asp:Literal ID="Literal4" runat="server" Text="121551550052"></asp:Literal></span>
            </div>
            <div class="detail-item">
            <asp:Label ID="Label5" runat="server" Text="Status:"></asp:Label>
             <asp:Literal ID="Literal6" runat="server" Text="Good"></asp:Literal>
    
</div>
        </div>
        <div class="modal-footer">
            <asp:Literal ID="litPaymentInfo" runat="server" Text="The Data Reteraive form the tutor database"></asp:Literal>
            <div class="buttons">
                
                <asp:Button ID="btnCanWithdrawal" runat="server" Text="Back" CssClass="btnCanWithdrawal" OnClick="btnCanWithdrawal_Click" />
            </div>
        </div>
    </div>
</div>
</asp:Content>
