<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="NewVacancy.aspx.cs" Inherits="CursusVia.Admin.NewVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="NewVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='Vacancy.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="mainBody">
        <div>
            <span class="surfaceText headerContainer">Job Information</span>
            <div class="contentContainer">
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Job Title</b></span>
                        <div class="search">
                            <input id="txtSearch" type="text" placeholder="Job Title" class="input"/>
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
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Role & Department</b></span>
                        <div class="search">
                            <input id="txtRoleDepartment" type="text" placeholder="Role (Department)" class="input"/>
                        </div>
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Job Requirements</b></span>
                        <div class="search">
                            <textarea id="TextArea1" cols="40" rows="5" class="txtAreaInput" placeholder="Job Requirements"></textarea>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Job Description</b></span>
                        <div class="search">
                            <textarea id="TextArea" cols="40" rows="5" class="txtAreaInput" placeholder="Job Description"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <span class="surfaceText headerContainer">Company Information</span>
            <div class="contentContainer">
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Company Name</b></span>
                        <div class="search">
                            <input id="txtCompanyName" type="text" placeholder="Company Name" class="input"/>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>HR Email</b></span>
                        <div class="search">
                            <input id="txtWorkingArea" type="text" placeholder="HR Email" class="input"/>
                        </div>
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Company Address</b></span>
                        <div class="search">
                            <input id="txtCompanyAddress" type="text" placeholder="Company Address" class="input"/>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Company Postcode</b></span>
                        <div class="search">
                            <input id="txtCompanyPostcode" type="text" placeholder="Company Postcode" class="input"/>
                        </div>
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Company State</b></span>
                        <div class="search">
                            <input id="txtCompanyState" type="text" placeholder="Company State" class="input"/>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Company Country</b></span>
                        <div class="search">
                            <input id="txtCompanyCountry" type="text" placeholder="Company Country" class="input"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="btnCreate">
        <asp:Button ID="btnCreate" runat="server" Text="Create" CssClass="btnPrimary Btn" OnClick="btnCreate_Click"/>
    </div>
</asp:Content>
