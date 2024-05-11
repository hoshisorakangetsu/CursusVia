<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="WithdrawRequest.aspx.cs" Inherits="CursusVia.Tutor.WithdrawRequest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="WithdrawRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="modal-background">
        <div class="modal">
            <div class="modal-header">
                <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Withdraw Request"></asp:Label>
            </div>
            <div class="modal-content">
                <!-- Bank Name -->
                <div class="detail-item">
                    <asp:Label ID="lblBankName" runat="server" Text="Bank Name"></asp:Label>
                    <asp:DropDownList ID="ddlBankName" runat="server">

                        <asp:ListItem Text="RHB" Value="RHB" />
                        <asp:ListItem Text="PBank" Value="PBank" />
                        <asp:ListItem Text="CIMB" Value="CIMB" />
                        <asp:ListItem Text="MAYBank" Value="MAYBank" />
                        <asp:ListItem Text="HSBC" Value="HSBC" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvBankName" runat="server" ControlToValidate="ddlBankName"
                        ErrorMessage="Bank name is required." InitialValue="" Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                </div>

                <div class="detail-item">
                    <asp:Label ID="lblAccNo" runat="server" Text="Account Number"></asp:Label>
                    <asp:TextBox ID="txtAccNo" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAccNo" runat="server" ControlToValidate="txtAccNo"
                        ErrorMessage="Account number is required." Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revAccNo" runat="server" ControlToValidate="txtAccNo"
                        ValidationExpression="^\d+$" ErrorMessage="Account number must be numeric." Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                </div>

                <div class="detail-item">
                    <asp:Label ID="lblAccHName" runat="server" Text="Account Holder Name"></asp:Label>
                    <asp:TextBox ID="txtAccHName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAccHName" runat="server" ControlToValidate="txtAccHName"
                        ErrorMessage="Account holder name is required." Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revAccHName" runat="server" ControlToValidate="txtAccHName"
                        ValidationExpression="^[a-zA-Z\s]+$" ErrorMessage="Name must be characters only." Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                </div>
                <div class="detail-item">
                    <asp:Label ID="lblWithdrawAmount" runat="server" Text="Withdraw Amount"></asp:Label>
                    <asp:TextBox ID="txtWithdrawAmount" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvWithdrawAmount" runat="server" ControlToValidate="txtWithdrawAmount"
                        ErrorMessage="Withdrawal amount is required." Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revWithdrawAmount" runat="server" ControlToValidate="txtWithdrawAmount"
                        ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Amount must be a number with up to two decimal places." Text="*" ForeColor="Red" CssClass="error" Display="Dynamic" />
                </div>
            </div>
            <div class="modal-footer">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" HeaderText="Please correct the following errors:"
                    ShowSummary="true" ShowMessageBox="false" />
                <asp:Label ID="lblStatus" runat="server" Text="" CssClass="error" Visible="False"></asp:Label>
                <asp:Literal ID="litPaymentInfo" runat="server" Text="Payout Order issuance available between the 20th and until the 30th of each month (UTC+08:00)."></asp:Literal>
                <div class="buttons">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel" CausesValidation="false" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
