<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="ReadTutorInformation.aspx.cs" Inherits="CursusVia.Tutor.ReadTutorInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="readTutorInformation.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [name], [qualifications], [email], [balance] FROM [Tutors] WHERE id=@id "> 
    
    <SelectParameters>
        <asp:CookieParameter Name="id" CookieName="id" />
      </SelectParameters>

</asp:SqlDataSource>
            <div class="backbtn" style="padding: 2em 2em 0 2em;">
<asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='Tutor.aspx'>   
<span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
Back
</asp:HyperLink>
 </div>
    <div id="container" style="margin-left:200px;" >
    <asp:DetailsView ID="DetailsView1" runat="server" Height="500px" Width="700px" AutoGenerateRows="False" CellPadding="7" DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" CellSpacing="12" >
         <emptydatarowstyle backcolor="#2461BF"
  forecolor="Red"/>
 <emptydatatemplate> No Data Found.  </emptydatatemplate> 
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        
        <Fields>
            <asp:BoundField DataField="id" HeaderText=" &nbsp; &nbsp; Id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="name" HeaderText=" &nbsp; &nbsp; Name" SortExpression="name" />
            <asp:BoundField DataField="qualifications" HeaderText=" &nbsp; &nbsp; Qualifications" SortExpression="qualifications" />
            <asp:BoundField DataField="email" HeaderText="&nbsp; &nbsp; Email" SortExpression="email" />
            <asp:BoundField DataField="balance" HeaderText="&nbsp; &nbsp; Balance" SortExpression="balance" />
        </Fields>
            
        <FooterStyle BackColor="#5E6C82 " Font-Bold="True" ForeColor="White" />
        <FooterTemplate>
          &nbsp; &nbsp; &nbsp;  @CursusVia2024&nbsp; 
        </FooterTemplate>
        <HeaderStyle BackColor="#5E6C82" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
             &nbsp; &nbsp; &nbsp; &nbsp; Tutor&#39;s Information
        </HeaderTemplate>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
 
        <div style="margin-top:100px;">
        </div>
        </div>

    <div style="float:left; margin:50px;  ">
    <asp:Button ID="Button1" runat="server" Text="Update Information" CssClass="btnPrimary btn"  OnClick="Button1_Click"/>
        </div>
        
</asp:Content>
