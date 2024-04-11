<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="SupportRequest.aspx.cs" Inherits="CursusVia.Admin.SupportRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="SupportRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="headerContainer">
        <div class="search">
            <span class="material-symbols-outlined searchIcon">search</span>
            <input id="Text1" type="text" placeholder="Search Request" class="input"/>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" />
        </div>
        <div class="">
            <div>
                <span class="surfaceText"><b>Status</b></span>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem>Respond Needed</asp:ListItem>
                    <asp:ListItem>Completed</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <div>
                    <span class="surfaceText"><b>Date</b></span>
                    <asp:Button ID="btnToday" runat="server" Text="Today" CssClass="btnPrimary btn"/>
                </div>
                <div class="dateInput">
                    <div class="width-min">
                        <span class="surfaceText">Start Date</span>
                        <asp:TextBox ID="TextBox3" runat="server" placeholder="Start Date" type="date" CssClass="dateInputField"></asp:TextBox>
                    </div>
                    <div>
                        <span class="surfaceText"><b>~</b></span>
                    </div>
                    <div class="width-min">
                        <span class="surfaceText">End Date</span>
                        <asp:TextBox ID="TextBox4" runat="server" placeholder="End Date" type="date" CssClass="dateInputField"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <h2 class="surfaceText">Support Request List</h2>
    </div>
</asp:Content>
