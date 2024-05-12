    <%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="Vacancy.aspx.cs" Inherits="CursusVia.Customer.Vacancy2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="Vacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="topField"> 
        <asp:HyperLink ID="newRequestLink" runat="server" class="btnPrimary newBtn newRequestText" NavigateUrl='SearchVacancy.aspx'>   
            Find a Job
        </asp:HyperLink>
        <div class="search">
            <span class="material-symbols-outlined searchIcon">search</span>
            <input id="Text1" type="text" placeholder="Search Applied Job" class="input"/>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" />
        </div>
    </div>
    <div class="table">
        <table class="rounded-corners">
            <tr>
                <th>ID</th>
                <th>Job Title Applied</th>
                <th>Company Name</th>
                <th>Expected Salary</th>
            </tr>
            <tr>
                <td>1</td>
                <td>Helpdesk and Support Specialist</td>
                <td>Daikin Malaysia</td>
                <td>RM 3,000</td>
            </tr>
        </table>
    </div>
</asp:Content>
