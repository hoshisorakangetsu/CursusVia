<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="UpdatePayOrder.aspx.cs" Inherits="CursusVia.Admin.UpdatePayOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="WithdrawUpdate.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="modal-background">
    <div class="modal">
        <div class="modal-header">
            <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Withdraw Request"></asp:Label>
        </div>
        <div class="modal-content">
            <div class="detail-item">
                <asp:Label ID="lblPaymentID" runat="server" Text="Request ID"></asp:Label>
                <span class="litPaymentID"><asp:Literal ID="litPaymentID" runat="server" Text="00001"></asp:Literal></span>
            </div>
            <div class="detail-item">
                <asp:Label ID="lbPayMethod" runat="server" Text="Update the status"></asp:Label>
                <div class="ddlPaymentmethods">
                <asp:DropDownList ID="ddlWithdrawStatus" runat="server">
                    <asp:ListItem Text="Paid" />
                    <asp:ListItem Text="Reject" />
                     <asp:ListItem Text="Need addtional details" />
                </asp:DropDownList>
                    </div>
            </div>
            <div class="detail-item">
            </div>
            <div class="detail-item">
                <asp:Label ID="lblNotes" runat="server" Text="Notes:"></asp:Label>
                <asp:TextBox ID="txtNotes" runat="server" PlaceHolder="Add details comment"></asp:TextBox>
            </div>
        </div>
        <div class="modal-footer">
            <asp:Literal ID="litPaymentInfo" runat="server" Text="Request Status will be updated accordingly"></asp:Literal>
            <div class="buttons">
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btnSubmit" OnClick="btnUpdate_Click" />

                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel" OnClick="btnCancel_Click" />
            </div>
        </div>
    </div>
</div>
</asp:Content>
