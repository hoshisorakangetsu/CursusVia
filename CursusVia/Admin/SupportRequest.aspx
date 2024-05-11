<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="SupportRequest.aspx.cs" Inherits="CursusVia.Admin.SupportRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="SupportRequest.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="headerContainer">
        <div class="search">
            <span class="material-symbols-outlined searchIcon">search</span> 
            <asp:TextBox ID="txtRequestTitle" runat="server" placeholder="Search Request" CssClass="input genericInputField"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" OnClick="btnSearch_Click" />
        </div>
        <div class="filterSection">
            <div class="statusSection">
                <span class="surfaceText inputName"><b>Status</b></span>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputField">
                    <asp:ListItem>Processing</asp:ListItem>
                    <asp:ListItem>Completed</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
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
        <div>
            <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btnPrimary btn" OnClick="btnFilter_Click"/>
        </div>
    </div>
    <div>
        <h2 class="surfaceText contentHeader">Support Request List</h2>
    </div>
    <div class="table">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [title], [date_send], [status] FROM [SupportRequests]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id"  ShowHeaderWhenEmpty="True" CssClass="rounded-corners">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="title" HeaderText="Request Title" SortExpression="title" />
                <asp:BoundField DataField="date_send" HeaderText="Date Send" SortExpression="date_send" />
                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Hyperlink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "ViewRequest.aspx?id=" + Eval("id")%>'>View</asp:Hyperlink>
                        <asp:Hyperlink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "UpdateRequest.aspx?id=" + Eval("id")%>'>Update</asp:Hyperlink>
                    </ItemTemplate>
                    <headertemplate>
                      Action
                    </headertemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
