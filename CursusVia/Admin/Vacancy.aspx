<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="Vacancy.aspx.cs" Inherits="CursusVia.Admin.Vacancy" %>
<asp:Content ID="headerContent" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="Vacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="bodyContent" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="topField"> 
        <asp:HyperLink ID="newRequestLink" runat="server" class="btnPrimary newBtn newRequestText" NavigateUrl='NewVacancy.aspx'>   
            Create New Job
        </asp:HyperLink>
        <div class="search">
            <span class="material-symbols-outlined searchIcon">search</span>
            <input id="Text1" type="text" placeholder="Search Job" class="input"/>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" />
        </div>
    </div>
    <div class="contentContainer">
        <div>
            <h2 class="surfaceText contentHeader">Job List</h2>
        </div>
        <div class="table">
            <table class="rounded-corners">
                <tr>
                    <th>ID</th>
                    <th>Job Title Offer</th>
                    <th>Company Name</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Helpdesk and Support Specialist</td>
                    <td>Daikin Malaysia</td>
                    <td>
                        <asp:HyperLink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='ViewVacancy.aspx'>View</asp:HyperLink>
                        <asp:HyperLink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='UpdateVacancy.aspx'>Update</asp:HyperLink>
                        <asp:HyperLink ID="HyperLink3" runat="server" class="btnPrimary newBtn" NavigateUrl='DeleteVacancy.aspx'>Delete</asp:HyperLink>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
