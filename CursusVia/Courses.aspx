<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="CursusVia.Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Courses.css" rel="stylesheet" />
    <link href="BrowseCourseCard.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="coursesMain">
        <!-- why vs eh auto format for inline expressions so ugly eh -->
        <% if (String.IsNullOrEmpty(Request.QueryString.Get("search")))
            {  %>
        <h1>Browse Courses</h1>
        <% }
            else
            { %>
        <h1>Showing "<%= Request.QueryString.Get("search") %>" Courses</h1>
        <% } %>

        <div class="coursesSearch">
            <div class="searchAlwaysShown">
                <div class="searchBox">
                    <span class="material-symbols-outlined searchIcon">search
                    </span>
                    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="searchTextBox" placeholder="Search Courses"></asp:TextBox>
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btnPrimary searchBtn" OnClick="SearchButton_Click" />
                </div>
                <div class="rightControl">
                    <asp:DropDownList ID="CourseCategoryFilter" runat="server" CssClass="filterCategory">
                        <asp:ListItem Selected="True">All Category</asp:ListItem>
                        <asp:ListItem Value="web_development">Web Development</asp:ListItem>
                        <asp:ListItem Value="digital_marketing">Digital Marketing</asp:ListItem>
                        <asp:ListItem Value="graphic_design">Graphic Design</asp:ListItem>
                        <asp:ListItem Value="mobile_apps">Mobile Apps</asp:ListItem>
                    </asp:DropDownList>
                    <button class="advancedFilter btnOutlinePrimary" id="advancedFilterCourse">
                        <span class="material-symbols-outlined">tune
                        </span>
                    </button>
                </div>
            </div>
            <div class="searchExpandable" id="advancedFilterCourseExpandable">
                <div class="advancedFilterCourseControl">
                    <div class="priceFilter">
                        <label>Price</label>
                        <div class="priceRangeWrapper">
                            <div class="priceRange">
                                <div class="priceField" id="minPriceField">
                                    RM
                                    <asp:TextBox ID="MinPrice" runat="server" CssClass="priceBox" onchange="validatePrice()"></asp:TextBox>
                                </div>
                                ~ 
                                <div class="priceField" id="maxPriceField">
                                    RM
                                    <asp:TextBox ID="MaxPrice" runat="server" CssClass="priceBox" onchange="validatePrice()"></asp:TextBox>
                                </div>
                            </div>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator" CssClass="validationMessage" ClientValidationFunction="validateFormat" Display="Dynamic"></asp:CustomValidator>
                        </div>
                    </div>
                    <div class="sortBy genericInputField">
                        <label for="SortBy">Sort By</label>
                        <asp:DropDownList ID="SortBy" runat="server">
                            <asp:ListItem Value="priceLTH">Price (Low to High)</asp:ListItem>
                            <asp:ListItem Value="priceHTL">Price (High to Low)</asp:ListItem>
                            <asp:ListItem Value="ratingLTH">Rating (Low to High)</asp:ListItem>
                            <asp:ListItem Value="ratingHTL">Rating (High to Low)</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="uploadedBy genericInputField">
                        <label for="UploadedBy">Uploaded By</label>
                        <asp:TextBox ID="UploadedBy" runat="server" placeholder="Tutor Name"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="coursesList">
            <asp:Repeater runat="server" ID="CourseRepeater" DataSourceID="CourseRepeaterSqlDS">
                <ItemTemplate>
                    <div class="courseCard">
                        <% 
// this comment should not be shown to the public as it concerns the internal working, so will be enclosing in server tags
// Substring 1 because the upload file utils include "~", which is not understandable by client browsers 
                        %>
                        <img src='<%# Eval("courseImgPath").ToString().Substring(1) %>' alt="Placeholder" />
                        <p class="courseName"><%# Eval("title") %></p>
                        <p class="tutorName"><%# Eval("tutorName") %></p>
                        <p class="rating">Rating <%# Eval("rating") %>/5.0 (<%# Eval("ratingCount") %>)</p>
                        <p class="coursePrice">RM <%# Eval("price") %></p>
                        <div class="actions">
                            <asp:HyperLink ID="ViewDetails" runat="server" CssClass="btn btnPrimary" NavigateUrl='<%# "~/CourseContent.aspx?id=" + Eval("id") %>'>View Details</asp:HyperLink>
                            <asp:HyperLink ID="AddToCart" runat="server" CssClass="btnOutlinePrimary" NavigateUrl='<%# "~/Customer/AddToCart.aspx?courseId=" + Eval("id") %>'>
                                <span class="material-symbols-outlined">
                                    add_shopping_cart
                                </span>
                            </asp:HyperLink>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource ID="CourseRepeaterSqlDS" runat="server"></asp:SqlDataSource>
        </div>
    </div>
    <script src="Courses.js" defer></script>
    <script src="InputWithValidator.js" defer></script>
    <script>
        function validatePrice() {
            ValidatorValidate(document.querySelector('#<%= CustomValidator1.ClientID %>'));
        }

        function validateFormat(sender, args) {
            const validNumber = (num) => /^(\d+(\.\d{0,2})?)?$/.test(num);
            const minPrice = document.querySelector('#<%= MinPrice.ClientID %>');
            const maxPrice = document.querySelector('#<%= MaxPrice.ClientID %>');

            let isValid = true;
            if (!validNumber(minPrice.value) && !validNumber(maxPrice.value)) {
                console.log(minPrice, maxPrice, minPrice.value, maxPrice.value, !validNumber(minPrice.value), !validNumber(maxPrice.value))
                isValid = false;
                sender.innerHTML = "Please enter valid numbers";
            } else if (!validNumber(minPrice.value)) {
                isValid = false;
                sender.innerHTML = "Please enter valid min price";
            } else if (!validNumber(maxPrice.value)) {
                isValid = false;
                sender.innerHTML = "Please enter valid max price";
            } else if (parseFloat(minPrice.value) > parseFloat(maxPrice.value)) {
                isValid = false;
                sender.innerHTML = "Min price cannot be greater than max price";
            }
            args.IsValid = isValid;
        }
    </script>
</asp:Content>
