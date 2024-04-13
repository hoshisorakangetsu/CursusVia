<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="SuccsessfulMessage.aspx.cs" Inherits="CursusVia.Customer.SuccsessfulMessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="SuccessfulMessage.css" rel="stylesheet"  />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- This can be use for the pop messages -->
          <div class="modal-background">
            <div class="modal">
                <div class="modal-header">
                    <asp:Label ID="lblWithdrawalDetail" runat="server" Text="Payment Successful"></asp:Label>
                </div>
                <div class="modal-content">
                   <span class="material-symbols-outlined">
check_circle
</span>
                </div> 
                <div class="modal-footer">
                    <span class="ConfirmNote"><asp:Literal ID="litPaymentInfo" runat="server" Text="Thank you for Shopping with us, Time to build future"></asp:Literal></span>
                    <div class="buttons">
                        <asp:Button ID="btnExit" runat="server" Text="Exit" CssClass="btnExit" OnClick="btnExit_Click" />
                    </div>
                </div>
            </div>
        </div>

</asp:Content>
