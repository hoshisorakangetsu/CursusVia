<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ViewVacancy.aspx.cs" Inherits="CursusVia.Customer.ViewVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ViewVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='SearchVacancy.aspx'>   
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
        <div class="jobBtn">
            <asp:HyperLink ID="applyNowLink" runat="server" class="btnPrimary newBtn">Apply Now</asp:HyperLink>
            <asp:HyperLink ID="otherJobLink" runat="server" class="btnPrimary newBtn">Other Job from this Company</asp:HyperLink>
        </div>
        <div class="jobBasicInfo">
            <h2 class="surfaceText">Job Description</h2>
            <asp:Label ID="lblDescr" runat="server" Text="Label" CssClass="surfaceText description"></asp:Label>
        </div>
        <div class="jobBasicInfo">
            <h2 class="surfaceText">Job Requirements</h2>
            <asp:Label ID="lblRequirement" runat="server" Text="Label" CssClass="surfaceText description"></asp:Label>
        </div>
        <div class="jobBasicInfo">
            <h2 class="surfaceText">Company Address</h2>
            <asp:Label ID="lblAddress" runat="server" Text="Label" CssClass="surfaceText description"></asp:Label>
        </div>
    </div>

</asp:Content>
