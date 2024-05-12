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
                     
                <asp:TextBox ID="txtName" runat="server" cssClass="form-control" Placeholder="Name"  Width="70%" Height="30px"></asp:TextBox>
                       
                    </div>
                <div style="margin-left:25px;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Cannot Leave Empty" ControlToValidate="txtName" ForeColor="red"></asp:RequiredFieldValidator>
                </div>
                     </td>
        </tr>
        <tr>
            <td>
                  <p style="margin-left:30px; margin-bottom:20px;"><b>Tutor's Email</b></p>
                 <div class="input-grp2" style="margin-left:40px;">
                     
                     <asp:Label ID="lblEmail" runat="server" Text="" ></asp:Label>
                  
                     </div>
                     </td>
        </tr>
        <tr>
     <td>
         <div class="input-grp" style="margin-left:30px;">
            <label for="DropDownList1" style="margin-bottom:10px; color:black;" CssClass="form-control">Qualifications:</label>
            <asp:DropDownList ID="ddlQualification" runat="server" CssClass="txtEmail2" style=" width: 70%; padding: 10px; margin-bottom: 15px; border: 1px solid #29354C; border-radius: 5px; box-sizing: border-box;" EnableViewState ="true">
                <asp:ListItem Value="PHD">PHD</asp:ListItem>
                <asp:ListItem Value="Master">Master</asp:ListItem>
                <asp:ListItem Value="Degree">Degree</asp:ListItem>
            </asp:DropDownList>
        </div>
              </td>
 </tr>
        <tr>
            <td>
                <div style="margin-left:25px;">
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="At least one field must be updated" OnServerValidate="CustomValidator1_ServerValidate" ForeColor="red"></asp:CustomValidator>
                <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    </div>
                 <div style="margin-top:20px;">
                     &nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btnPrimary btn" OnClick="Button1_Click" CausesValidation ="true"/>
                  </div>
            </td>
        </tr>
    
        </table>
</div>
    
</asp:Content>

