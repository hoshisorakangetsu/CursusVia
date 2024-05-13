<%@ Page Title="Home" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CursusVia.WebForm1" %>

<asp:Content ID="headTag" ContentPlaceHolderID="head" runat="server">
    <link href="Home.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="hero">
        <div>
            <h1 class="surfaceText"><span class="primaryText">Free Trial</span> for 30 days
            </h1>
            <p class="surfaceText">
                Get ready for a high-demand career with CursusVia. Gain unlimited
                access to our extensive online courses featuring certified tutors. 
                Earn certificates that can enhance your eligibility for job opportunities 
                with our collaborative partners.
            </p>
        </div>
        <img src="res/women_with_pen.png" class="heroImg" />
        <div class="heroBtnGroup">
            <asp:HyperLink NavigateUrl="~/Customer/LoginStudent.aspx" ID="btnEnrollNow" CssClass="btnPrimary btn" runat="server" Text="Enroll Now" />
            <asp:HyperLink NavigateUrl="~/Customer/LoginStudent.aspx" ID="btnLearnMore" CssClass="btnSecondary btn" runat="server" Text="Learn More" />
        </div>
    </div>
    <div class="courseCategories">
        <h1 class="surfaceText">Course Categories</h1>
        <div class="courseCategoryContainer">
            <p class="selectYourFavorite">Select Your Favorite Category</p>
            <div class="courseCategoryScrollerContainer">
                <span class="material-symbols-outlined" id="scrollLeft">arrow_left
                </span>

                <div class="courseCategoryScroller" id="courseCategoryScroller">
                    <div class="courseCategoryCard" onclick="location.href = '/Courses.aspx?category=web_development'">
                        <p>Web Development</p>
                        <div>
                            <img src="res/web_dev_course.png" />
                        </div>
                    </div>
                    <div class="courseCategoryCard" onclick="location.href = '/Courses.aspx?category=web_development'">
                        <p>Graphic Design</p>
                        <div>
                            <img src="res/graphic_design.png" />
                        </div>
                    </div>
                    <div class="courseCategoryCard" onclick="location.href = '/Courses.aspx?category=mobile_apps'">
                        <p>Mobile Application</p>
                        <div>
                            <img src="res/mobile_apps_course.png" />
                        </div>
                    </div>
                    <div class="courseCategoryCard" onclick="location.href = '/Courses.aspx?category=digital_marketing'">
                        <p>Digital Marketing</p>
                        <div>
                            <img src="res/digital_marketing_course.png" />
                        </div>
                    </div>
                    <div class="courseCategoryCard" onclick="location.href = '/Courses.aspx?category=web_development'">
                        <p>Web Development</p>
                        <div>
                            <img src="res/web_dev_course.png" />
                        </div>
                    </div>
                </div>

                <span class="material-symbols-outlined" id="scrollRight">arrow_right
                </span>
            </div>
        </div>
    </div>
    <div class="partners">
        <h1 class="primaryText successPartnerText">Our Success Partners</h1>
        <div class="successPartnerLogos">
            <div>
                <img src="res/google_bw.png" />
            </div>
            <div>
                <img src="res/microsoft_bw.png" />
            </div>
            <div>
                <img src="res/linkedin_bw.png" />
            </div>
            <div>
                <img src="res/lazada_bw.png" />
            </div>
        </div>
    </div>
    <div class="startTeaching">
        <img src="res/man_with_laptop_cursusvia.png" />
        <div>
            <h1 class="primaryText">Start teaching on CursusVia Today!</h1>
            <p class="surfaceText">
                Join CursusVia as a tutor and share your skills with students 
                from anywhere in the world. Take control of your income and teaching
                schedule without the constraints of a boss looming over you.
            </p>
            <asp:HyperLink NavigateUrl="~/Tutor/LoginTutor.aspx" ID="btnApplyNow" CssClass="btnPrimary btn" runat="server" Text="Apply Now" />
        </div>
    </div>
    <script src="HomeCourseCategoryScroller.js" defer></script>
</asp:Content>
