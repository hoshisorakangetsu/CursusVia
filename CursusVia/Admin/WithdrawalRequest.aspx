<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="WithdrawalRequest.aspx.cs" Inherits="CursusVia.Admin.WithdrawalRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="SupportRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="headerContainer">
        <div class="search">
            <span class="material-symbols-outlined searchIcon">search</span>
           <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Request" CssClass="input genericInputField"></asp:TextBox>
<asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" OnClick="btnSearch_Click" />
        </div>
           <div class="filterSection">
        <div class="statusSection">
            <span class="surfaceText inputName"><b>Status</b></span>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputField">
                <asp:ListItem>None</asp:ListItem>
                <asp:ListItem>Pending</asp:ListItem>
                <asp:ListItem>Approve</asp:ListItem>
                <asp:ListItem>Paid</asp:ListItem>
                <asp:ListItem Text="Reject" />
                <asp:ListItem Text="Need addtional details" />
            </asp:DropDownList>
        </div>
        <div class="">
            <div class="dateSection">
                <span class="surfaceText inputName"><b>Date</b></span>
                <asp:Button ID="btnToday" runat="server" Text="Today" CssClass="btnPrimary Btn" OnClick="btnToday_Click1" />
            </div>
            <div class="dateInput inputField">
                <div class="width-min">
                    <span class="surfaceText">Start Date</span>
                   <asp:TextBox ID="TextBox3" runat="server" placeholder="Start Date" Type="Date" CssClass="dateInputField"></asp:TextBox>
                </div>
                <div>
                    <div>
                        <br />
                    </div>
                    <span class="surfaceText"><b>:</b></span>
                </div>
                <div class="width-min">
                    <span class="surfaceText">End Date</span>
                    <asp:TextBox ID="TextBox4" runat="server" placeholder="End Date" Type="Date" CssClass="dateInputField"></asp:TextBox>          
                </div>
            </div>
        </div>
    </div>
      <div class="filter">
     <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btnPrimary btn" OnClick="btnFilter_Click"/>
     <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btnPrimary btn" OnClick="btnClear_Click"/>
 </div>
</div>
<div>
    <h2 class="surfaceText contentHeader">Withdrawal Request List</h2>
</div>
    <div class="table">
<asp:GridView ID="gvWithdrawalRequests" runat="server"   AutoGenerateColumns="False"  CssClass="rounded-corners" ShowFooter="True">
    <Columns>
        <asp:BoundField DataField="id" HeaderText="ID" />
        <asp:BoundField DataField="name" HeaderText="Name" />
        <asp:BoundField DataField="balance" HeaderText="Balance" />
        <asp:BoundField DataField="request_date" HeaderText="Request Date" />
        <asp:BoundField DataField="withdraw_amount" HeaderText="Withdraw Amount" />
        <asp:BoundField DataField="status" HeaderText="Status" />
        <asp:TemplateField>
            <ItemTemplate>
               <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("id", "ViewWithdrawRequest.aspx?id={0}") %>' Text="View" CssClass="btnPrimary newBtn"></asp:HyperLink>
                <asp:Hyperlink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "WithdrawStatusUpdate.aspx?id=" + Eval("id")%>'>Update</asp:Hyperlink>
            </ItemTemplate>
            <headertemplate>
  Action
</headertemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>
</div>
</asp:Content>
