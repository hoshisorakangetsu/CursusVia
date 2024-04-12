<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="UpdateStudentDetails.aspx.cs" Inherits="CursusVia.Customer.UpdateStudentDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="UpdateStudentDetails.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
      <div class="backbtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='ReadStudentInfo.aspx'>   
<span class="material-symbols-outlined backIcon">arrow_back</span>
Back
    </asp:HyperLink>
          </div>
        <div class="layer-1">
            
    <table style="border: solid 2px black;" id="t1">
        <tr>
            <td>
               <span class="material-symbols-outlined accicon ">manage_accounts</span>

                Update Personal Details</td>
        </tr>
     
        <tr>
            <td>
                <div style="margin-left:30px;" class="input-grp">
                <asp:TextBox ID="TextBox3" runat="server" cssClass="input-grp" Placeholder=" Name" Height="30px" Width="70%"></asp:TextBox>
                   </div>
                     </td>
        </tr>
        <tr>
            <td>
               <div style="margin-left:30px;" class="input-grp2">
                <asp:TextBox ID="TextBox1" runat="server" cssClass="inputBox" Placeholder=" Email" Height="30px" Width="70%" ></asp:TextBox>
                  </div>
                     
                     </td>
        </tr>
        <tr>
     <td>
         <div class="input-grp3" >
             <asp:CheckBox ID="CheckBox1" runat="server" /> 
        
             <p>I agree to the terms and conditions</p>
        </div>
              </td>
 </tr>
        <tr>
            <td>
                
               &nbsp; &nbsp;<asp:Button ID="Button1" runat="server" Text="Update" cssClass="btnPrimary btn"/>
                  
            </td>
        </tr>
    
        </table>
</div>
    
</asp:Content>
