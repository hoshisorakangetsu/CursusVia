<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="CursusVia.Customer.Support" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="Support.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div>
        <div class="topField"> 
            <asp:HyperLink ID="newRequestLink" runat="server" class="btnPrimary newBtn newRequestText" NavigateUrl='NewRequest.aspx'>   
                New Request
            </asp:HyperLink>
            <div class="search">
                <span class="material-symbols-outlined searchIcon">search</span>
                <input id="Text1" type="text" placeholder="Search Request" class="input"/>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" />
            </div>
        </div>
        <div class="content">
            <div>
                <div class="filterHeader">
                    <span class="surfaceText filterText">FILTER</span>
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btnPrimary btn"/>
                </div>
                <div class="filterStatus">
                    <span class="surfaceText statusText">STATUS</span>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputField">
                        <asp:ListItem>None</asp:ListItem>
                        <asp:ListItem>Procssing</asp:ListItem>
                        <asp:ListItem>Completed</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="filterDate">
                    <span class="surfaceText dateText">DATE</span>
                    <div class="dateInput">
                        <div class="width-min">
                            <span class="surfaceText">Start Date</span>
                            <asp:TextBox ID="startDate" runat="server" placeholder="Start Date" type="date" CssClass="dateInputField"></asp:TextBox>
                        </div>
                        <div>
                            <div>
                                <br />
                                <br />
                            </div>
                            <span class="surfaceText"><b>~</b></span>
                        </div>
                        <div class="width-min">
                            <span class="surfaceText">End Date</span>
                            <asp:TextBox ID="EndDate" runat="server" placeholder="End Date" type="date" CssClass="dateInputField"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="filterBtn">
                    <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btnPrimary btn" OnClick="btnFilter_Click" />
                </div>
            </div>
            <div class="requestContentArea">
                <asp:Repeater ID="Repeater1" runat="server" >
                    <ItemTemplate>
                        <div class="request">
                            <div class="requestContent">
                                <h1 class="surfaceText"><%# Eval("title") %></h1>
                                <p class="surfaceText margin-top">
                                    <%# Eval("description") %>
                                </p>
                                <p class="surfaceText margin-top"><b>Status: <%# Eval("status") %></b></p>
                            </div>
                            <div class="requestBtn">
                                <asp:HyperLink ID="btnViewDetails" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "ViewRequest.aspx?id=" + Eval("id") %>'>   
                                    View Request
                                </asp:HyperLink>
                                <asp:HyperLink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "EditSupport.aspx?id="+ Eval("id") %>'>   
                                    Update Request
                                </asp:HyperLink>
                                <asp:HyperLink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "DeleteRequest.aspx?id="+ Eval("id") %>'>   
                                    Delete Request
                                </asp:HyperLink>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>   
    </div>
</asp:Content>
