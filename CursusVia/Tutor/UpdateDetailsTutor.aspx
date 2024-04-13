<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdateDetailsTutor.aspx.cs" Inherits="CursusVia.Tutor.UpdateDetailsTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="UpdateDetailsTutor.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
           <div class="backbtn" style="padding: 2em 2em 0 2em;">
<asp:HyperLink ID="HyperLink1" runat="server" class="backText" NavigateUrl='Tutor.aspx'>   
<span class="material-symbols-outlined backIcon" style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
Back
</asp:HyperLink>
 </div>
        <div class="layer-1">
         
 <table style="border: solid 2px black;" id="t1">
        <tr>
            <th>
               <span class="material-symbols-outlined accicon ">manage_accounts</span>

                Update Personal Details</th>
        </tr>
     
        <tr>
            <td>
                <div class="input-grp">
                     
                <asp:TextBox ID="TextBox3" runat="server" cssClass="form-control" Placeholder="Name"  Width="70%" Height="30px"></asp:TextBox>
                       
                    </div>
                     </td>
        </tr>
        <tr>
            <td>
                 <div class="input-grp2">
                     
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Placeholder="Email" Width="70%" Height="30px"></asp:TextBox>
                  
                     </div>
                     </td>
        </tr>
        <tr>
     <td>
         <div class="input-grp" style="margin-left:30px;">
            <label for="DropDownList1" style="margin-bottom:10px;">Qualifications:</label>
            <asp:DropDownList ID="DropDownList1" runat="server" >
                <asp:ListItem Value="phd">PHD</asp:ListItem>
                <asp:ListItem Value="master">Master</asp:ListItem>
                <asp:ListItem Value="degree">Degree</asp:ListItem>
            </asp:DropDownList>
        </div>
              </td>
 </tr>
        <tr>
            <td>
                  
             &nbsp;&nbsp;&nbsp;   <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btnPrimary btn"/>
                  
            </td>
        </tr>
    
        </table>
</div>
    
</asp:Content>
