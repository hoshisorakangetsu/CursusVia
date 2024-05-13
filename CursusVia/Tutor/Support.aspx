<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="CursusVia.Tutor.Support" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="Support.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div>
        <div class="topField"> 
            <asp:HyperLink ID="newRequestLink" runat="server" class="btnPrimary newBtn newRequestText" NavigateUrl='NewRequest.aspx'>   
                New Request
            </asp:HyperLink>
            <div class="search">
                <span class="material-symbols-outlined searchIcon">search</span>
                <asp:TextBox ID="txtJobTitle" runat="server" placeholder="Search Request" CssClass="input"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" OnClick="btnSearch_Click" />
            </div>
        </div>
        <div class="content">
            <div>
                <div class="filterHeader">
                    <span class="surfaceText filterText">FILTER</span>
                    <div>
                        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btnPrimary btn" OnClick="btnFilter_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btnPrimary btn" OnClick="btnClear_Click"/>
                    </div>
                </div>
                <div class="filterStatus">
                    <span class="surfaceText statusText">STATUS</span>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputField">
                        <asp:ListItem>None</asp:ListItem>
                        <asp:ListItem>Processing</asp:ListItem>
                        <asp:ListItem>Completed</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="filterDate">
                    <span class="surfaceText dateText">DATE</span>
                    <div class="dateInput">
                        <div class="width-max">
                            <span class="surfaceText">Start Date</span>
                            <asp:TextBox ID="startDate" runat="server" placeholder="Start Date" type="date" CssClass="dateInputField"></asp:TextBox>
                        </div>
                        <div class="to">
                            <span class="surfaceText"><b>TO</b></span>
                        </div>
                        <div>
                            <span class="surfaceText">End Date</span>
                            <asp:TextBox ID="EndDate" runat="server" placeholder="End Date" type="date" CssClass="dateInputField"></asp:TextBox>
                        </div>
                    </div>
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
                                <div>
                                    <p class="surfaceText margin-top"><b>Status: <%# Eval("status") %></b></p>
                                    <p class="surfaceText"><b>Posted On: <%# Eval("date_send") %></b></p>
                                </div>
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
