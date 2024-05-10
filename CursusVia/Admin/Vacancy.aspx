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
            <input id="Text1" type="text" placeholder="Search Job" class="input genericInputField"/>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" />
        </div>
    </div>
    <div class="contentContainer">
        <div>
            <h2 class="surfaceText contentHeader">Job List</h2>
        </div>
        <div class="table">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="id" DataSourceID="SqlDataSource1" ShowHeaderWhenEmpty="True" AutoGenerateSelectButton="false" CssClass="rounded-corners" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id"/>
                    <asp:BoundField DataField="job_title" HeaderText="Job Title Offer" SortExpression="job_title"/>
                    <asp:BoundField DataField="name" HeaderText="Company Name" SortExpression="name"/>
                    <asp:HyperLinkField Text="View" DataNavigateUrlFields="id" DataNavigateUrlFormatString="ViewVacancy.aspx?id={0}" />
                    <asp:HyperLinkField Text="Update" DataNavigateUrlFields="id" DataNavigateUrlFormatString="UpdateVacancy.aspx?id={0}"  />
                    <asp:HyperLinkField Text="Delete" DataNavigateUrlFields="id" DataNavigateUrlFormatString="DeleteVacancy.aspx?id={0}"  />

                    <asp:TemplateField>
                        <ItemTemplate>
                          
                            <asp:HyperLink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='ViewVacancy.aspx?id={0}'>View</asp:HyperLink>
                            <asp:HyperLink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='UpdateVacancy.aspx'>Update</asp:HyperLink>
                            <asp:HyperLink ID="HyperLink3" runat="server" class="btnPrimary newBtn" NavigateUrl='DeleteVacancy.aspx'>Delete</asp:HyperLink>
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
