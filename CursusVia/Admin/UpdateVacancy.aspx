<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="UpdateVacancy.aspx.cs" Inherits="CursusVia.Admin.UpdateVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="UpdateVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='<%="ViewVacancy.aspx?id=Request.Params["id"]" %>'>    
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="mainBody">
            <div>
                <span class="surfaceText headerContainer">Job Information</span>
                <div class="contentContainer">
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" AssociatedControlID="txtSearch" CssClass="surfaceText inputName"><b>Job Title</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtSearch" placeholder="Job Title" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter the job title" ControlToValidate="txtSearch" Display="Dynamic" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                        <div class="genericInputField">
                            <div class="jobTypeSection">
                                <asp:Label runat="server" CssClass="surfaceText inputName"><b>Job Type</b></asp:Label>
                                <asp:DropDownList ID="ddlJobType" runat="server" CssClass="inputField">
                                    <asp:ListItem>Full Time</asp:ListItem>
                                    <asp:ListItem>Part Time</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" CssClass="surfaceText inputName"><b>Minimum Salary (Monthly)</b></asp:Label>
                            <div class="salaryInput">
                                <span class="rm">RM</span>
                                <div class="search">
                                    <asp:TextBox ID="txtMinSalary" type="number" placeholder="1500.00" runat="server" CssClass="input"></asp:TextBox>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMinSalary" Display="Dynamic" ErrorMessage="Please enter a minimum salary" CssClass="validationMessage"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtMinSalary" Display="Dynamic" ValidationExpression="^\d+(,\d{1,2})?$" ErrorMessage="Please enter the correct format for salary" CssClass="validationMessage"></asp:RegularExpressionValidator>
                        </div>
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Maximum Salary (Monthly)</b></asp:Label>
                            <div class="salaryInput">
                                <span class="rm">RM</span>
                                <div class="search">
                                    <asp:TextBox ID="txtMaxSalary" type="number" placeholder="10000.00" runat="server" CssClass="input"></asp:TextBox>
                                </div>                            
                            </div> 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ControlToValidate="txtMaxSalary" ErrorMessage="Please enter a maximum salary" CssClass="validationMessage"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ControlToValidate="txtMaxSalary" ValidationExpression="^\d+(,\d{1,2})?$" ErrorMessage="Please enter the correct format for salary" CssClass="validationMessage"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Role & Department</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtRoleDepartment" placeholder="Role (Department)" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ControlToValidate="txtRoleDepartment" ErrorMessage="Please enter the role for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Job Requirements</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtJobReq" runat="server" placeholder="Job Requirements" Columns="40" Rows="5" TextMode="MultiLine" CssClass="txtAreaInput"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ControlToValidate="txtJobReq" ErrorMessage="Please enter the job requirements for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Job Description</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtJobDescr" runat="server" placeholder="Job Description" Columns="40" Rows="5" TextMode="MultiLine" CssClass="txtAreaInput"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ControlToValidate="txtJobDescr" ErrorMessage="Please enter the job description for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <span class="surfaceText headerContainer">Company Information</span>
                <div class="contentContainer">
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Company Name</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtCompanyName" placeholder="Company Name" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ControlToValidate="txtCompanyName" ErrorMessage="Please enter the company name for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>HR Email</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtHRemail" placeholder="HR Email" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ControlToValidate="txtHRemail" ErrorMessage="Please enter the HR email for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ControlToValidate="txtHRemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Please enter the correct format for email" CssClass="validationMessage"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Company Address</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtCompanyAddress" placeholder="Company Address" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="Dynamic" ControlToValidate="txtCompanyAddress" ErrorMessage="Please enter the company address for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Company Postcode</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtCompanyPostcode" placeholder="Company Postcode" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" MaximumValue="5" MinimumValue="5" ControlToValidate="txtCompanyPostcode" ErrorMessage="Please only enter the correct postcode format" CssClass="validationMessage"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" Display="Dynamic" ControlToValidate="txtCompanyPostcode" ErrorMessage="Please enter the company postcode for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="searchSection">
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Company Area</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtCompanyArea" placeholder="Company Area" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic" ControlToValidate="txtCompanyArea" ErrorMessage="Please enter the company area for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                        <div class="genericInputField">
                            <asp:Label runat="server" class="surfaceText inputName"><b>Company State</b></asp:Label>
                            <div class="search">
                                <asp:TextBox ID="txtCompanyState" placeholder="Company State" runat="server" CssClass="input"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" Display="Dynamic" ControlToValidate="txtCompanyState" ErrorMessage="Please enter the company state for the job" CssClass="validationMessage"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="btnCreate">
            <asp:Button ID="btnCreate" runat="server" Text="Create" CssClass="btnPrimary Btn" OnClick="btnCreate_Click"/>
        </div>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>
