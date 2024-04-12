<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ApplyVacancy.aspx.cs" Inherits="CursusVia.Customer.ApplyVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ApplyVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='ViewVacancy.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="contentContainer">
        <div>
            <h1 class="surfaceText">Job Title</h1>
            <span class="surfaceText companyName">Company Name</span>
        </div>
        <div class="jobBasicInfo">
            <div class="displayFlex">
                <span class="material-symbols-outlined">location_on</span>
                <p>Bayan Lepas, Pulau Pinang</p>
            </div>
            <div class="displayFlex">
                <span class="material-symbols-outlined">money</span>
                <p>RM3,000 ~ RM5,000 per month</p>
            </div>
            <div class="displayFlex">
                <span class="material-symbols-outlined">apartment</span>
                <p>Solution Provider (Information & Communication Technology)</p>
            </div>
            <div class="displayFlex">
                <span class="material-symbols-outlined">schedule</span>
                <p>Full Time</p>
            </div>
        </div>
        <div class="applyContainer">
            <h2 class="">Applying for "Job Title" at "Company Name"</h2>
            <div class="inputField">
                <span class="surfaceText inputName"><b>Expected Salary (Monthly)</b></span>
                <div class="salaryInput">
                    <span class="rm">RM</span>
                    <div class="search">
                        <input id="txtMinSalary" type="text" class="input"/>
                    </div>
                </div>
            </div>
            <div class="inputField">
                <span class="surfaceText inputName"><b>Your Resume</b></span>
                <div class="salaryInput">
                    <div class="resumeInput">
                        <input id="resumePath" type="text" class="input" placeholder="Upload your resume"/>
                    </div>
                    <asp:Button ID="btnUpload" runat="server" Text="Upload File" CssClass="btnPrimary btn"/>
                </div>
            </div>
            <div class="applyBtn">
                <asp:Button ID="btnApply" runat="server" Text="Apply Now" CssClass="btnPrimary btn" OnClick="btnApply_Click"/>
            </div>
        </div>
     </div>
</asp:Content>
