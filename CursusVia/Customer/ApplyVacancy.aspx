<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeFile="ApplyVacancy.aspx.cs" Inherits="CursusVia.Customer.ApplyVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ApplyVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText">   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="contentContainer">
        <div>
            <asp:Label ID="lblJobTitle" runat="server" Text="Label" CssClass="surfaceText h1"></asp:Label><br>
            <asp:Label ID="lblCompanyName" runat="server" Text="Label" CssClass="surfaceText companyName"></asp:Label>
        </div>
        <div class="jobBasicInfo">
            <div class="displayFlex">
                <span class="material-symbols-outlined">location_on</span>
                <asp:Label ID="lblArea" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="displayFlex">
                <span class="material-symbols-outlined">money</span>
                <asp:Label ID="lblMinSalary" runat="server" Text="Label"></asp:Label><span>~</span>
                <asp:Label ID="lblMaxSalary" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="displayFlex">
                <span class="material-symbols-outlined">apartment</span>
                <asp:Label ID="lblDepartment" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="displayFlex">
                <span class="material-symbols-outlined">schedule</span>
                <asp:Label ID="lblType" runat="server" Text="Label"></asp:Label>
            </div>
        </div>
        <div class="applyContainer">
            <h2 class="">Applying for "<asp:Label ID="jobtitle" runat="server" Text="Label" CssClass="surfaceText"></asp:Label>" at "<asp:Label ID="companyName" runat="server" Text="Label" CssClass="surfaceText"></asp:Label>"</h2>
            <div class="inputField genericInputField">
                <span class="surfaceText inputName"><b>Expected Salary (Monthly)</b></span>
                <div class="salaryInput">
                    <span class="rm">RM</span>
                    <div class="search">
                        <asp:TextBox ID="txtMinSalary" runat="server" placeholder="7000.00" CssClass="input"></asp:TextBox>
                    </div>                    
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ControlToValidate="txtMinSalary" ErrorMessage="Please enter your expected salary" CssClass="validationMessage"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ControlToValidate="txtMinSalary" ValidationExpression="^\d+(,\d{1,2})?$" ErrorMessage="Please enter the correct format for salary" CssClass="validationMessage"></asp:RegularExpressionValidator>
            </div>
            <div class="inputField">
                <span class="surfaceText inputName"><b>Your Resume</b></span>
                <div class="salaryInput">
                    <div class="resumeInput">
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="input"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="FileUpload1" ErrorMessage="Please upload your resume" CssClass="validationMessage"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
            <div class="applyBtn">
                <asp:Button ID="btnApply" runat="server" Text="Apply Now" CssClass="btnPrimary btn" OnClick="btnApply_Click"/>
            </div>
        </div>
     </div>
    <script src='<%= ResolveUrl("~/InputWithValidator.js") %>' defer></script>
</asp:Content>
