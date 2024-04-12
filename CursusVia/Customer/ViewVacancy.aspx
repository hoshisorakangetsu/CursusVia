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
        <div class="jobBtn">
            <asp:HyperLink ID="applyNowLink" runat="server" class="btnPrimary newBtn" NavigateUrl='ApplyVacancy.aspx'>Apply Now</asp:HyperLink>
            <asp:HyperLink ID="otherJobLink" runat="server" class="btnPrimary newBtn" NavigateUrl='SearchVacancyWithCompany.aspx'>Other Job from this Company</asp:HyperLink>
        </div>
        <div class="jobBasicInfo">
            <h2 class="surfaceText">Job Description</h2>
            <p class="surfaceText description">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget ex vitae sem tincidunt venenatis posuere eget elit. 
                Etiam vel sagittis dui. Integer aliquet sapien a tellus tristique, eu tristique eros tincidunt. 
                Cras bibendum metus eu quam fermentum, ut eleifend nunc elementum. Nulla sodales erat quis massa pulvinar, non volutpat orci finibus. 
                Mauris ultrices non leo id ornare. Vivamus ipsum lacus, volutpat sit amet est eget, convallis dapibus ligula. 
                Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer egestas nisi pulvinar, pretium tellus eu, accumsan odio. 
                Integer ornare ex non ipsum gravida blandit. Nullam vulputate ligula ut tristique facilisis. Sed sed orci velit. 
                Duis sagittis ante eget ligula mattis auctor. Vivamus vel sem dolor. Cras euismod tortor vitae nisl feugiat vestibulum. 
                Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
            </p>
        </div>
        <div class="jobBasicInfo">
            <h2 class="surfaceText">Job Requirements</h2>
            <p class="surfaceText description">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget ex vitae sem tincidunt venenatis posuere eget elit. 
                Etiam vel sagittis dui. Integer aliquet sapien a tellus tristique, eu tristique eros tincidunt. 
                Cras bibendum metus eu quam fermentum, ut eleifend nunc elementum. Nulla sodales erat quis massa pulvinar, non volutpat orci finibus. 
                Mauris ultrices non leo id ornare. Vivamus ipsum lacus, volutpat sit amet est eget, convallis dapibus ligula. 
                Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer egestas nisi pulvinar, pretium tellus eu, accumsan odio. 
                Integer ornare ex non ipsum gravida blandit. Nullam vulputate ligula ut tristique facilisis. Sed sed orci velit. 
                Duis sagittis ante eget ligula mattis auctor. Vivamus vel sem dolor. Cras euismod tortor vitae nisl feugiat vestibulum. 
                Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
            </p>
        </div>
        <div class="jobBasicInfo">
            <h2 class="surfaceText">Company Address</h2>
            <p class="surfaceText description">
                Address
            </p>
        </div>
    </div>

</asp:Content>
