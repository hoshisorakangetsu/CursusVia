<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="TutorRatings.aspx.cs" Inherits="CursusVia.Tutor.TutorRatings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="TutorRatings.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
<div class="backbtn" style="padding: 2em 2em 0 2em;">
<asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='Tutor.aspx'>   
<span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
Back
</asp:HyperLink>
 </div>
    <div class="header">
    <h1 >Tutor's Ratings</h1>
    <h2>Dr Ali Bin Hassan</h2>
    </div>
    <div class="ratingcontainer" >
        <h3 style="font-size:80px;">5.0</h3>
        <p>⭐⭐⭐⭐⭐</p>
        <p>Total 3 Ratings.</p>
    </div>
    <div class="ratingdetails">
       
        <div class="bar-5"></div><p style="position:relative;">5.0</p>
        <div class="bar-4"></div><p style="position:relative;">4.0</p>
        <div class="bar-3"></div><p style="position:relative;">3.0</p>


    </div>
    <div class="containerRatings">
        <label>Filter by Ratings:</label>
  
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem>5⭐</asp:ListItem>
            <asp:ListItem>4⭐</asp:ListItem>
            <asp:ListItem>3⭐</asp:ListItem>
            <asp:ListItem>2⭐</asp:ListItem>
            <asp:ListItem>1⭐</asp:ListItem>
        </asp:DropDownList>
        <p style="margin-top:20px;">⭐⭐⭐⭐⭐⭐</p>
        <p>Student Id: 001</p>
        <p style="margin-top:20px;">⭐⭐⭐⭐⭐⭐</p>
        <p>Student Id: 002</p>
        <p style="margin-top:20px;">⭐⭐⭐⭐⭐⭐</p>
        <p>Student Id: 003</p>
    </div>
</asp:Content>
