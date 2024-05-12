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
            <asp:TextBox ID="txtRequestTitle" runat="server" placeholder="Search Applied Job" CssClass="input genericInputField"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" OnClick="btnSearch_Click" />
        </div>
    </div>
    <div class="table">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" CssClass="rounded-corners">
            <Columns>
                <asp:BoundField DataField="job_title" HeaderText="Job Title Applied" SortExpression="job_title" />
                <asp:BoundField DataField="name" HeaderText="Company Name" SortExpression="name" />
                <asp:BoundField DataField="expecred_salary" HeaderText="Expected Salary" SortExpression="expecred_salary" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
