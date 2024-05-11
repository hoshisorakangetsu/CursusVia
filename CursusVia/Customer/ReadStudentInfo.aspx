<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="ReadStudentInfo.aspx.cs" Inherits="CursusVia.Customer.ReadStudentInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="ReadStudentInfo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [email], [name] FROM [Students] WHERE id=@id "> 
        
        <SelectParameters>
            <asp:CookieParameter Name="id" CookieName="id" />
          </SelectParameters>

    </asp:SqlDataSource>
   <div class="backbtn" style="padding: 2em 2em 0 2em;">
  <asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='Student.aspx'>   
  <span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
  Back
  </asp:HyperLink>
   </div>
    <div id="container">
     
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="7" DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Height="500px" Width="700px" cellspacing="12" >
       

         <emptydatarowstyle backcolor="#2461BF"
          forecolor="Red"/>
         <emptydatatemplate> No Data Found.  </emptydatatemplate> 
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="id" HeaderText=" &nbsp; &nbsp;  ID" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="email" HeaderText=" &nbsp; &nbsp; Email" SortExpression="email"  />
            <asp:BoundField DataField="name" HeaderText=" &nbsp; &nbsp;  Name" SortExpression="name" />
        </Fields>
        <FooterStyle BackColor="#5E6C82" Font-Bold="True" ForeColor="White" />
        <FooterTemplate>
           &nbsp; &nbsp; &nbsp; @CursusVia2024&nbsp; 
        </FooterTemplate>
        <HeaderStyle BackColor="#5E6C82" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
             &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Student&#39;s Details
        </HeaderTemplate>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
         </asp:DetailsView>
        </asp:Content>
