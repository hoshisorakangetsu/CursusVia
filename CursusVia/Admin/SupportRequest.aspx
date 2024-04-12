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
        <div class="filterSection">
            <div class="statusSection">
                <span class="surfaceText inputName"><b>Status</b></span>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputField">
                    <asp:ListItem>Respond Needed</asp:ListItem>
                    <asp:ListItem>Completed</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="">
                <div class="dateSection">
                    <span class="surfaceText inputName"><b>Date</b></span>
                    <asp:Button ID="btnToday" runat="server" Text="Today" CssClass="btnPrimary Btn"/>
                </div>
                <div class="dateInput inputField">
                    <div class="width-min">
                        <span class="surfaceText">Start Date</span>
                        <asp:TextBox ID="TextBox3" runat="server" placeholder="Start Date" type="date" CssClass="dateInputField"></asp:TextBox>
                    </div>
                    <div>
                        <div>
                            <br />
                        </div>
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
        <h2 class="surfaceText contentHeader">Support Request List</h2>
    </div>
    <div class="table">
        <table class="rounded-corners">
            <tr>
                <th>ID</th>
                <th>Request Title</th>
                <th>Date Send</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <tr>
                <td>1</td>
                <td>Add more course</td>
                <td>9/4/2024</td>
                <td>Response Needed</td>
                <td>
                    <asp:HyperLink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='ViewRequest.aspx'>View</asp:HyperLink>
                    <asp:HyperLink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='UpdateRequest.aspx'>Update</asp:HyperLink>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
