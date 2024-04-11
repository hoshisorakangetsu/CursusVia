<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="CursusVia.Customer.Support" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="Support.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <div>
        <div class="topField"> 
            <asp:HyperLink ID="newRequestLink" runat="server" class="btnPrimary newBtn newRequestText" NavigateUrl='NewRequest.aspx'>   
                New Request
            </asp:HyperLink>
            <div class="search">
                <span class="material-symbols-outlined searchIcon">search</span>
                <input id="Text1" type="text" placeholder="Search Request" class="input"/>
                <div class="space"></div>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btnPrimary btn" />
            </div>
        </div>
        <div class="content">
            <div>
                <div class="filterHeader">
                    <span class="surfaceText filterText">FILTER</span>
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btnPrimary btn"/>
                </div>
                <div class="filterStatus">
                    <span class="surfaceText statusText">STATUS</span>
                    <div class="radioBtn">
                        <asp:RadioButton ID="RadioButton1" runat="server" Text="Processing" GroupName="status" />
                    </div> 
                    <div class="radioBtn">
                        <asp:RadioButton ID="RadioButton2" runat="server" Text="Completed" GroupName="status" />
                    </div> 
                </div>
                <div class="filterDate">
                    <span class="surfaceText dateText">DATE</span>
                    <div class="dateInput">
                        <asp:TextBox ID="startDate" runat="server" placeholder="Start Date" type="date" CssClass="dateInputField"></asp:TextBox>
                        <span class="surfaceText"><b>~</b></span>
                        <asp:TextBox ID="endDate" runat="server" placeholder="End Date" type="date" CssClass="dateInputField"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="requestContentArea">
                <div class="request">
                    <div class="requestContent">
                        <h1 class="surfaceText">Title</h1>
                        <p class="surfaceText">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget ex vitae sem tincidunt venenatis posuere eget elit. 
                            Etiam vel sagittis dui. Integer aliquet sapien a tellus tristique, eu tristique eros tincidunt. 
                            Cras bibendum metus eu quam fermentum, ut eleifend nunc elementum. Nulla sodales erat quis massa pulvinar, non volutpat orci finibus. 
                            Mauris ultrices non leo id ornare. Vivamus ipsum lacus, volutpat sit amet est eget, convallis dapibus ligula. 
                            Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer egestas nisi pulvinar, pretium tellus eu, accumsan odio. 
                            Integer ornare ex non ipsum gravida blandit. Nullam vulputate ligula ut tristique facilisis. Sed sed orci velit. 
                            Duis sagittis ante eget ligula mattis auctor. Vivamus vel sem dolor. Cras euismod tortor vitae nisl feugiat vestibulum. 
                            Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
                        </p>
                        <p class="surfaceText"><b>Status: Processing</b></p>
                    </div>
                    <div class="requestBtn">
                        <asp:HyperLink ID="btnViewDetails" runat="server" class="btnPrimary newBtn" NavigateUrl='ViewRequest.aspx'>   
                            View Request
                        </asp:HyperLink>
                        <asp:HyperLink ID="HyperLink1" runat="server" class="btnPrimary newBtn" NavigateUrl='EditSupport.aspx'>   
                            Update Request
                        </asp:HyperLink>
                        <asp:HyperLink ID="HyperLink2" runat="server" class="btnPrimary newBtn" NavigateUrl='DeleteRequest.aspx'>   
                            Delete Request
                        </asp:HyperLink>
                    </div>
                </div>
                <div class="request">
                    <div class="requestContent">
                        <h1 class="surfaceText">Title</h1>
                        <p class="surfaceText">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget ex vitae sem tincidunt venenatis posuere eget elit. 
                            Etiam vel sagittis dui. Integer aliquet sapien a tellus tristique, eu tristique eros tincidunt. 
                            Cras bibendum metus eu quam fermentum, ut eleifend nunc elementum. Nulla sodales erat quis massa pulvinar, non volutpat orci finibus. 
                            Mauris ultrices non leo id ornare. Vivamus ipsum lacus, volutpat sit amet est eget, convallis dapibus ligula. 
                            Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Integer egestas nisi pulvinar, pretium tellus eu, accumsan odio. 
                            Integer ornare ex non ipsum gravida blandit. Nullam vulputate ligula ut tristique facilisis. Sed sed orci velit. 
                            Duis sagittis ante eget ligula mattis auctor. Vivamus vel sem dolor. Cras euismod tortor vitae nisl feugiat vestibulum. 
                            Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
                        </p>
                        <p class="surfaceText"><b>Status: Completed</b></p>
                    </div>
                    <div class="requestBtn">
                        <asp:Button ID="btnViewDetails1" runat="server" Text="View Request" CssClass="btnPrimary Btn"/>
                        <asp:Button ID="btnUpdateRequest2" runat="server" Text="Update Request" CssClass="btnPrimary Btn"/>
                        <asp:Button ID="btnDeleteRequest3" runat="server" Text="Delete Request" CssClass="btnPrimary Btn"/>
                    </div>
                    </div>
            </div>
        </div>   
    </div>
</asp:Content>
