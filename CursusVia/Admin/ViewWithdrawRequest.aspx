<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="ViewWithdrawRequest.aspx.cs" Inherits="CursusVia.Admin.ViewWithdrawRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="ViewWithdrawRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">

    <div class="withdrawal-request">
        <a href="#" class="back-link">&larr; Back</a>
        <div class="withdrawal-details">
            <label class="detail-label">Withdrawal Request ID:</label>
            <asp:Literal ID="ltRequestID" runat="server" Text="0001" />
            
            <label class="detail-label">Tutor Name:</label>
            <asp:Literal ID="ltTutorName" runat="server" Text="Matt Albu" />
            
            <label class="detail-label">Courses Qty:</label>
            <asp:Literal ID="ltCoursesQty" runat="server" Text="3" />
            
            <label class="detail-label">Student Enrolls:</label>
            <asp:Literal ID="ltStudentEnrolls" runat="server" Text="6" />
            
            <label class="detail-label">Available Balance:</label>
            <asp:Literal ID="ltAvailableBalance" runat="server" Text="RM 1000" />
            
            <label class="detail-label">Withdraw Amount:</label>
            <asp:Literal ID="ltWithdrawAmount" runat="server" Text="RM 500" />
        </div>
        
        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="update-button" />
    </div>


</asp:Content>
