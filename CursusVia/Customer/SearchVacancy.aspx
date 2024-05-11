<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="SearchVacancy.aspx.cs" Inherits="CursusVia.Customer.Vacancy1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="SearchVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='Vacancy.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="headerContainer">
        <div class="searchSection">
            <div>
                <span class="surfaceText inputName"><b>Job Title</b></span>
                <div class="search">
                    <span class="material-symbols-outlined searchIcon">search</span>
                    <input id="txtSearch" type="text" placeholder="Search Job" class="input"/>
                </div>
            </div>
            <div class="jobTypeSection">
                <span class="surfaceText inputName"><b>Job Type</b></span>
                <asp:DropDownList ID="ddlJobType" runat="server" CssClass="inputField">
                    <asp:ListItem>Full Time</asp:ListItem>
                    <asp:ListItem>Part Time</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="searchSection">
            <div>
                <span class="surfaceText inputName"><b>Company Name</b></span>
                <div class="search">
                    <span class="material-symbols-outlined searchIcon">search</span>
                    <input id="txtCompanyName" type="text" placeholder="Search Company Name" class="input"/>
                </div>
            </div>
            <div>
                <span class="surfaceText inputName"><b>Working Area</b></span>
                <div class="search">
                    <span class="material-symbols-outlined searchIcon">search</span>
                    <input id="txtWorkingArea" type="text" placeholder="Search Working Area" class="input"/>
                </div>
            </div>
        </div>
        <div class="searchSection">
            <div>
                <span class="surfaceText inputName"><b>Minimum Salary (Monthly)</b></span>
                <div class="salaryInput">
                    <span class="rm">RM</span>
                    <div class="search">
                        <input id="txtMinSalary" type="text" class="input"/>
                    </div>
                </div>
            </div>
            <div>
                <span class="surfaceText inputName"><b>Maximum Salary (Monthly)</b></span>
                <div class="salaryInput">
                    <span class="rm">RM</span>
                    <div class="search">
                        <input id="txtMaxSalary" type="text" class="input"/>
                    </div>
                </div>             
            </div>
        </div>
        <div class="btnSection">
            <asp:Button ID="Button1" runat="server" Text="Clear" CssClass="btnPrimary btn"/>
            <asp:Button ID="Button2" runat="server" Text="Search" CssClass="btnPrimary btn"/>
        </div>
    </div>
    <div class="jobSection">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="jobContainer">
                    <div>  
                        <h2 class="surfaceText"><%# Eval("job_title") %></</h2> <br />
                        <span class="surfaceText jobCompanyText"><%# Eval("name") %></span>
                    </div>
                    <div class="jobDetails">
                        <span class="jobDetailsText"><%# Eval("area") %>, <%# Eval("state") %></span>
                        <span class="jobDetailsText"><%# Eval("min_salary") %>  ~  <%# Eval("max_salary") %></span>
                        <span class="jobDetailsText"><%# Eval("role") %></span>
                    </div>
                    <div class="btnViewDetails">
                        <asp:HyperLink ID="HyperLink6" runat="server" class="btnPrimary newBtn" NavigateUrl='<%# "ViewVacancy.aspx?id="+ Eval("id") %>'>View Details</asp:HyperLink>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
