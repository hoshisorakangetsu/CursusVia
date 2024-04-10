<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="DeleteStudent.aspx.cs" Inherits="CursusVia.Customer.DeleteStudent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="DeleteStudent.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <table class="table1">
            <tr>
                <th>
                    <span class="dot">
                    <span class="material-symbols-outlined deleteicon">
                    delete
                    </span>
                    </span>
                    <p id="deletetxt">Delete Account</p> 
                 </th>
             </tr>
           <tr>
            <td>
            <p>If you delete your account, your personal information will be wiped from CursusVia's servers, all of your course activity 
                will be anonymized and  will be deleted. This action cannot be undone! Think carefully before you delete your account.

            </p>
            </td>
           </tr>
            <tr>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Delete Now" CssClass="btnPrimary btn" />

                </td>
            </tr>
             </table>
        <table class="table1">
            <tr>
                <th>
                    <span class="dot">
                    <span class="material-symbols-outlined logouticon">
                    logout
                    </span>
                    </span>
                    <p id="logouttxt">Logout</p>    
                </th>
            </tr>
            <tr>
                    <td>
                    <p>If your account has been logged into on multiple devices, you can log out from here.</p>
                    </td>
            </tr>
             <tr>
             <td>
                 <asp:Button ID="Button2" runat="server" Text="Delete Now" CssClass="btnPrimary btn" />

             </td>
             </tr>
        </table>
           
        </div>
    
</asp:Content>