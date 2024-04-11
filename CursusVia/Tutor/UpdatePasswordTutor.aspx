<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdatePasswordTutor.aspx.cs" Inherits="CursusVia.Tutor.UpdatePasswordTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="UpdatePassword.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="layer-1">
    <div class="background-1">
        <table id="t1">
            <tr>
                <th>
                   <span class="material-symbols-outlined pwicon">key</span>

                    Update Password</th>
            </tr>
         
            <tr>
                <td>
                    <div class="input-grp">
                         <label for="TextBox3">Old Password</label>
                    <asp:TextBox ID="TextBox3" runat="server" cssClass="form-control" TextMode="Password"></></asp:TextBox>
                           
                        </div>
                         </td>
            </tr>
            <tr>
                <td>
                     <div class="input-grp">
                         <label for="TextBox1">New Password</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                      
                         </div>
                         </td>
            </tr>
           
            <tr>
                <td>
                    <div id="button1">
                    <asp:Button ID="Button1" runat="server" Text="Update" cssClass="btnPrimary btn"/>
                        </div>
                </td>
            </tr>
        
            </table>
    </div>
        </div>
</asp:Content>
