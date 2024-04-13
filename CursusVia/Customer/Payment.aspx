<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="CursusVia.Customer.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="Payment.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal-background">
        <div class="modal">
            <div class="modal-header">
                <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Payment"></asp:Label>
            </div>
            <div class="modal-content">
                <div class="detail-item">
                    <asp:Label ID="lblPaymentID" runat="server" Text="Payment ID"></asp:Label>
                    <span class="litPaymentID"><asp:Literal ID="litPaymentID" runat="server" Text="00001"></asp:Literal></span>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lbPayMethod" runat="server" Text="Select Payment Method"></asp:Label>
                    <div class="ddlPaymentmethods">
                    <asp:DropDownList ID="ddlPaymentmethods" runat="server">
                        <asp:ListItem Text="TNG" />
                        <asp:ListItem Text="Online Banking" />
                         <asp:ListItem Text="Debit Card" />
                        <asp:ListItem Text="Visa" />
                        <asp:ListItem Text="Master Card" />
                        <asp:ListItem Text="Credit Card" />
                    </asp:DropDownList>
                        </div>
                </div>
                <div class="acceptedPayments">
                        <img src='<%= ResolveUrl("~/res/visa.png") %>' alt="Visa" class="payment-logo" />
                        <img src='<%= ResolveUrl("~/res/mastercard.png") %>' alt="MasterCard" class="payment-logo" />
                        <img src='<%= ResolveUrl("~/res/fpx.png") %>' alt="FPX" class="payment-logo" />
                        <img src='<%= ResolveUrl("~/res/touchngo.png") %>' alt="Touch 'n Go" class="payment-logo" />
                </div>
                <div class="detail-item">
                   
                    <asp:Label ID="lblCardNo" runat="server" Text="Card Number"></asp:Label>
                    <asp:TextBox ID="txtCardNo" runat="server" PlaceHolder="121######"></asp:TextBox>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblAccHName" runat="server" PlaceHolder="Card Holder Name"></asp:Label>
                    <asp:TextBox ID="txtAccHName"  runat="server" PlaceHolder="121######"></asp:TextBox>
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblCvs" runat="server" Text="CVS"></asp:Label>
                    <asp:TextBox ID="txtCvs" runat="server" PlaceHolder="3 to 4 Digit"></asp:TextBox>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Literal ID="litPaymentInfo" runat="server" Text="Your Payment Details will be secured and not shared with any third parties."></asp:Literal>
                <div class="buttons">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>


