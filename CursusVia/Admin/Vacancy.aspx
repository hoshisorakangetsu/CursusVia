    <%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="Vacancy.aspx.cs" Inherits="CursusVia.Admin.Vacancy" %>
<asp:Content ID="headerContent" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="Vacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="bodyContent" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Vacancies.id, Vacancies.job_title, Companies.name FROM Vacancies INNER JOIN Companies ON Vacancies.company_id = Companies.id"></asp:SqlDataSource>
    
    
    <div class="topField"> 
        <asp:HyperLink ID="newRequestLink" runat="server" class="btnPrimary newBtn newRequestText" NavigateUrl='NewVacancy.aspx'>   
            Create New Job
        </asp:HyperLink>
        <div class="search">
            <span class="material-symbols-outlined searchIcon">search</span>
            <asp:TextBox ID="txtJobTitle" runat="server" placeholder="Job Title" CssClass="input genericInputField"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" OnClick="btnSearch_Click" />
        </div>
    </div>
    <div class="contentContainer">
        <div>
            <h2 class="surfaceText contentHeader">Job List</h2>
        </div>
        <div class="table">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="id"  ShowHeaderWhenEmpty="True" CssClass="rounded-corners">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id"/>
                    <asp:BoundField DataField="job_title" HeaderText="Job Title Offer" SortExpression="job_title"/>
                    <asp:BoundField DataField="name" HeaderText="Company Name" SortExpression="name"/>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Hyperlink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "ViewVacancy.aspx?id=" + Eval("id")%>'>View</asp:Hyperlink>
                            <asp:Hyperlink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "UpdateVacancy.aspx?id=" + Eval("id")%>'>Update</asp:Hyperlink>
                            <asp:Hyperlink ID="HyperLink3" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "DeleteVacancy.aspx?id=" + Eval("id")%>'>Delete</asp:Hyperlink>
                        </ItemTemplate>
                        <headertemplate>
                          Action
                        </headertemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
