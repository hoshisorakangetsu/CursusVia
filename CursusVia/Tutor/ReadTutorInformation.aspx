﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="ReadTutorInformation.aspx.cs" Inherits="CursusVia.Tutor.ReadTutorInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="readTutorInformation.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div id="container" >
    <asp:DetailsView ID="DetailsView1" runat="server" Height="500px" Width="700px" AutoGenerateRows="False" CellPadding="6" DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" >
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
            <asp:BoundField DataField="qualifications" HeaderText="qualifications" SortExpression="qualifications" />
            <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" />
            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            <asp:BoundField DataField="balance" HeaderText="balance" SortExpression="balance" />
        </Fields>
        <FooterStyle BackColor="#5E6C82 " Font-Bold="True" ForeColor="White" />
        <FooterTemplate>
            @CursusVia2024&nbsp; <a style="color:blue; float:right;" href="#">terms & conditions</a>
        </FooterTemplate>
        <HeaderStyle BackColor="#5E6C82" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
            Tutor&#39;s Information
        </HeaderTemplate>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Tutors]"></asp:SqlDataSource>
    <div style="margin-top:100px;">
        </div>
        </div>
</asp:Content>
