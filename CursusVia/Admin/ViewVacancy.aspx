<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeBehind="ViewVacancy.aspx.cs" Inherits="CursusVia.Admin.ViewVacancy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminMasterHead" runat="server">
    <link href="ViewVacancy.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminMasterBody" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Vacancies.job_title, Companies.name, Companies.address, Companies.postcode, Companies.state, Companies.country, Vacancies.min_salary, Vacancies.max_salary, Vacancies.type, Vacancies.role, Vacancies.job_requirement, Vacancies.job_description FROM Companies INNER JOIN Vacancies ON Companies.id = Vacancies.company_id"></asp:SqlDataSource>
    <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='Vacancy.aspx'>   
            <span class="material-symbols-outlined backIcon">arrow_back</span>
            Back
        </asp:HyperLink>
    </div>
    <div class="contentContainer">
        <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataSourceID="SqlDataSource1">
            <Fields>
                <asp:BoundField DataField="job_title" HeaderText="job_title" SortExpression="job_title" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" />
                <asp:BoundField DataField="postcode" HeaderText="postcode" SortExpression="postcode" />
                <asp:BoundField DataField="state" HeaderText="state" SortExpression="state" />
                <asp:BoundField DataField="country" HeaderText="country" SortExpression="country" />
                <asp:BoundField DataField="min_salary" HeaderText="min_salary" SortExpression="min_salary" />
                <asp:BoundField DataField="max_salary" HeaderText="max_salary" SortExpression="max_salary" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                <asp:BoundField DataField="role" HeaderText="role" SortExpression="role" />
                <asp:BoundField DataField="job_requirement" HeaderText="job_requirement" SortExpression="job_requirement" />
                <asp:BoundField DataField="job_description" HeaderText="job_description" SortExpression="job_description" />
            </Fields>
        </asp:DetailsView>
        <div>
            <h1 class="surfaceText">Job Title</h1>
            <span class="surfaceText companyName">Company Name</span>
        </div>
        <div class="jobInfo">
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
        <div class="jobBtn">
            <asp:HyperLink ID="applyNowLink" runat="server" class="btnPrimary newBtn" NavigateUrl='UpdateVacancy.aspx'>Edit</asp:HyperLink>
            <asp:HyperLink ID="otherJobLink" runat="server" class="btnPrimary newBtn" NavigateUrl='DeleteVacancy.aspx'>Delete</asp:HyperLink>
        </div>
    </div>
</asp:Content>
