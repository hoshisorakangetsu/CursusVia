<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ReadStudentInfo.aspx.cs" Inherits="CursusVia.Customer.ReadStudentInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ReadStudentInfo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [email], [name] FROM [Students]"></asp:SqlDataSource>
        <div id="container">
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="6" DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Height="500px" Width="700px">
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
        </Fields>
        <FooterStyle BackColor="#5E6C82" Font-Bold="True" ForeColor="White" />
        <FooterTemplate>
            @CursusVia2024&nbsp; <a style="color:blue; float:right;" href="#">terms & conditions</a>
        </FooterTemplate>
        <HeaderStyle BackColor="#5E6C82" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
            Student&#39;s Details
        </HeaderTemplate>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
        </div>
</asp:Content>
