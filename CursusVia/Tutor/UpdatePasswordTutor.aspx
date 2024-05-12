<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="UpdatePasswordTutor.aspx.cs" Inherits="CursusVia.Tutor.UpdatePasswordTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href="UpdatePassword.css" rel="stylesheet" />
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
               <span class="material-symbols-outlined pwicon">key</span>

                Update Password</th>
        </tr>
     
        <tr>
            <td>
                <div class="input-grp">
                    
                <asp:TextBox ID="txtOldPassword" runat="server" cssClass="form-control" TextMode="Password" Placeholder="Old Password" Height="30px" Width="70%"></asp:TextBox>
                       </div>
                          <div style="padding-left:25px;">
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Cannot be Empty" ForeColor="red" ControlToValidate="txtNewPassword"></asp:RequiredFieldValidator>

      </div>
                    
                     </td>
        </tr>
        <tr>
            <td>
                 <div class="input-grp">
              
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="New Password" Height="30px" Width="70%"></asp:TextBox>
                     </div>
             
                <div style="padding-left:25px;">
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Cannot be Empty" ForeColor="red" ControlToValidate="txtNewPassword"></asp:RequiredFieldValidator></div>
                                <div style="padding-left:25px;">

                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNewPassword" ErrorMessage="Password format is invalid." ForeColor="red" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d).{4,}$"></asp:RegularExpressionValidator>

                    </div>
                     </td>
        </tr>
         <tr>
    <td>
         <div class="input-grp">
            
        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirmed New Password" Height="30px" Width="70%" ></asp:TextBox>
             </div>
        
                <div style="padding-left:25px;">
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Cannot be Empty" ControlToValidate="txtConfirmPassword" ForeColor="red"></asp:RequiredFieldValidator> </div>
                        <div style="padding-left:25px;">

             <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="The password not matched" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPassword" ForeColor = "red"></asp:CompareValidator>
             </div>

             </td>
</tr>
         <tr>
             <td>
                 <div style="padding-left:25px;">
                 <b>Note:</b>
                  <p>   The password length must contain at least 4 characters</p>
                  <p>  It must contains at least one digit</p>
                    <p> It must contains at least one letter</p>
                 </div>
             </td>
         </tr>
       
        <tr>
           
            <td>
                   <div style="padding-left:25px; padding-bottom:20px;">
   <asp:Label ID="lblMsg3" runat="server" Text=""></asp:Label>
      </div>
              &nbsp;&nbsp;  <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btnPrimary btn" OnClick="Button1_Click"/>
                
            </td>
        </tr>
    
        </table>
</div>
</asp:Content>
