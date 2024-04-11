<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.master" AutoEventWireup="true" CodeBehind="UpdateStudentDetails.aspx.cs" Inherits="CursusVia.Customer.UpdateStudentDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CustomerMasterHead" runat="server">
    <link href="UpdateStudentDetails.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CustomerMasterBody" runat="server">
        <div class="layer-1">
<div class="background-1">
    <table id="t1">
        <tr>
            <th>
               <span class="material-symbols-outlined accicon ">manage_accounts</span>

                Update Personal Details</th>
        </tr>
     
        <tr>
            <td>
                <div class="input-grp">
                     <label for="TextBox3">Name</label>
                <asp:TextBox ID="TextBox3" runat="server" cssClass="form-control" ></asp:TextBox>
                       
                    </div>
                     </td>
        </tr>
        <tr>
            <td>
                 <div class="input-grp2">
                     <label for="TextBox1">Email</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ></asp:TextBox>
                  
                     </div>
                     </td>
        </tr>
        <tr>
     <td>
         <div class="input-grp3" >
             <asp:CheckBox ID="CheckBox1" runat="server" /> 
        
             <label for="CheckBox1" >I agree to the terms and conditions</label>
        </div>
              </td>
 </tr>
        <tr>
            <td>
                 
                <asp:Button ID="Button1" runat="server" Text="Update" cssClass="Button1"/>
                  
            </td>
        </tr>
    
        </table>
</div>
    </div>
</asp:Content>
