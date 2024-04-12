<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="SearchVacancyWithCompany.aspx.cs" Inherits="CursusVia.Customer.VacancyWithCompany" %>
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
                    <input id="txtCompanyName" type="text" Value="Company Name" class="input"/>
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
        <div class="jobContainer">
            <div>  
                <h2 class="surfaceText">Job Title</h2>
                <span class="surfaceText jobCompanyText">Company Name</span>
            </div>
            <div class="jobDetails">
                <span class="jobDetailsText">Working Area</span>
                <span class="jobDetailsText">Salary Range</span>
                <span class="jobDetailsText">Role in Department</span>
            </div>
            <div class="btnViewDetails">
                <asp:HyperLink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='ViewVacancy.aspx'>View Details</asp:HyperLink>
            </div>
        </div>
        <div class="jobContainer">
            <div>  
                <h2 class="surfaceText">Job Title</h2>
                <span class="surfaceText jobCompanyText">Company Name</span>
            </div>
            <div class="jobDetails">
                <span class="jobDetailsText">Working Area</span>
                <span class="jobDetailsText">Salary Range</span>
                <span class="jobDetailsText">Role in Department</span>
            </div>
            <div class="btnViewDetails">
                <asp:HyperLink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl=''>View Details</asp:HyperLink>
            </div>
        </div>
        <div class="jobContainer">
            <div>  
                <h2 class="surfaceText">Job Title</h2>
                <span class="surfaceText jobCompanyText">Company Name</span>
            </div>
            <div class="jobDetails">
                <span class="jobDetailsText">Working Area</span>
                <span class="jobDetailsText">Salary Range</span>
                <span class="jobDetailsText">Role in Department</span>
            </div>
            <div class="btnViewDetails">
                <asp:HyperLink ID="HyperLink3" runat="server" class="btnPrimary newBtn" NavigateUrl=''>View Details</asp:HyperLink>
            </div>
        </div>
        <div class="jobContainer">
            <div>  
                <h2 class="surfaceText">Job Title</h2>
                <span class="surfaceText jobCompanyText">Company Name</span>
            </div>
            <div class="jobDetails">
                <span class="jobDetailsText">Working Area</span>
                <span class="jobDetailsText">Salary Range</span>
                <span class="jobDetailsText">Role in Department</span>
            </div>
            <div class="btnViewDetails">
                <asp:HyperLink ID="HyperLink4" runat="server" class="btnPrimary newBtn" NavigateUrl=''>View Details</asp:HyperLink>
            </div>
        </div>
        <div class="jobContainer">
            <div>  
                <h2 class="surfaceText">Job Title</h2>
                <span class="surfaceText jobCompanyText">Company Name</span>
            </div>
            <div class="jobDetails">
                <span class="jobDetailsText">Working Area</span>
                <span class="jobDetailsText">Salary Range</span>
                <span class="jobDetailsText">Role in Department</span>
            </div>
            <div class="btnViewDetails">
                <asp:HyperLink ID="HyperLink5" runat="server" class="btnPrimary newBtn" NavigateUrl=''>View Details</asp:HyperLink>
            </div>
        </div>
        <div class="jobContainer">
            <div>  
                <h2 class="surfaceText">Job Title</h2>
                <span class="surfaceText jobCompanyText">Company Name</span>
            </div>
            <div class="jobDetails">
                <span class="jobDetailsText">Working Area</span>
                <span class="jobDetailsText">Salary Range</span>
                <span class="jobDetailsText">Role in Department</span>
            </div>
            <div class="btnViewDetails">
                <asp:HyperLink ID="HyperLink6" runat="server" class="btnPrimary newBtn" NavigateUrl=''>View Details</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>
