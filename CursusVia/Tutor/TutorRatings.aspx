<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="TutorRatings.aspx.cs" Inherits="CursusVia.Tutor.TutorRatings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="TutorRatings.css" rel="stylesheet" />
     <style>
        tr:hover {
        background-color: lightgray;
      }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
<div class="backbtn" style="padding: 2em 2em 0 2em;">
<asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='Tutor.aspx'>   
<span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
Back
</asp:HyperLink>
 </div>
    <h1 style="margin-top:20px; margin-left:20px;">Tutor Ratings</h1>
   <div  style="position:absolute;margin-left:60px; width:50%; margin-top:20px; margin-bottom:20px;">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" onSelectedIndexChanged="DropDownList1_SelectedIndexChanged" >
    <asp:ListItem Selected="True">All</asp:ListItem>
    <asp:ListItem Value="5">⭐5.0</asp:ListItem>
    <asp:ListItem Value="4">⭐4.0</asp:ListItem>
    <asp:ListItem Value="3">⭐3.0</asp:ListItem>
    <asp:ListItem Value="2">⭐2.0</asp:ListItem>
    <asp:ListItem Value="1">⭐1.0</asp:ListItem>
</asp:DropDownList></div>
    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
               <div style="position:absolute;margin-left:60px; width:100%; margin-top:50px;">
       
   
      <table id="rating" style="width:60%; border:1px solid; text-align:center;"> 

         <tr>
           <td style="padding:20px; border-bottom:1px solid black;"><b>🧑‍🎓Student's id</b></td>
            <td style="padding:20px; border-bottom:1px solid black;"><b>⭐Rating</b></td>
         </tr>
        </HeaderTemplate>
        <ItemTemplate>
             <tr>
              <td style="width:50%; padding:10px;"><%#Eval("Student_id") %></td>
               <td style="width:50%; padding:10px;"><%#Eval("rating") %></td>
            </tr>
              
        </ItemTemplate>
         <FooterTemplate>
     </table>
     </div>
 </FooterTemplate>
    </asp:Repeater>
</asp:Content>
