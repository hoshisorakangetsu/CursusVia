<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="UpdateVacancy.aspx.cs" Inherits="CursusVia.Admin.UpdateVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="UpdateVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='ViewVacancy.aspx'>   
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
                            <input id="txtSearch" type="text" value="Job Title" class="input"/>
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
                                <input id="txtMinSalary" type="text" class="input" value="3,000"/>
                            </div>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Maximum Salary (Monthly)</b></span>
                        <div class="salaryInput">
                            <span class="rm">RM</span>
                            <div class="search">
                                <input id="txtMaxSalary" type="text" class="input" value="5,000"/>
                            </div>
                        </div>             
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Role & Department</b></span>
                        <div class="search">
                            <input id="txtRoleDepartment" type="text" value="Role (Department)" class="input"/>
                        </div>
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Job Requirements</b></span>
                        <div class="search">
                            <textarea id="TextArea1" cols="40" rows="5" class="txtAreaInput">Job Requirements</textarea>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Job Description</b></span>
                        <div class="search">
                            <textarea id="TextArea" cols="40" rows="5" class="txtAreaInput">Job Description</textarea>
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
                            <input id="txtCompanyName" type="text" value="Company Name" class="input"/>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>HR Email</b></span>
                        <div class="search">
                            <input id="txtWorkingArea" type="text" value="HR Email" class="input"/>
                        </div>
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Company Address</b></span>
                        <div class="search">
                            <input id="txtCompanyAddress" type="text" value="Company Address" class="input"/>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Company Postcode</b></span>
                        <div class="search">
                            <input id="txtCompanyPostcode" type="text" value="Company Postcode" class="input"/>
                        </div>
                    </div>
                </div>
                <div class="searchSection">
                    <div>
                        <span class="surfaceText inputName"><b>Company State</b></span>
                        <div class="search">
                            <input id="txtCompanyState" type="text" value="Company State" class="input"/>
                        </div>
                    </div>
                    <div>
                        <span class="surfaceText inputName"><b>Company Country</b></span>
                        <div class="search">
                            <input id="txtCompanyCountry" type="text" value="Company Country" class="input"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="btnCreate">
        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btnPrimary Btn" OnClick="btnUpdate_Click" />
    </div>
</asp:Content>
