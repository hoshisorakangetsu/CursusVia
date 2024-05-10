<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="RegisterTutor.aspx.cs" Inherits="CursusVia.Tutor.RegisterTutor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="LoginTutor.css" rel="stylesheet" />
<link href="LoginTutor2.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:Panel ID="pnlRegister" runat="server" Visible="true">
     <h3 style="margin-left:20px;">Register</h3>
     <div class="backBtn">
        <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='LoginTutor.aspx'>   
    <span class="material-symbols-outlined backIcon"style="font-size: 1.25em; display: flex; justify-content: left; color: var(--text-on-surface) !important; gap: .5em;">arrow_back</span>
    Back
        </asp:HyperLink>
    </div>
    <div id="RegisterContainer" runat="server" class="Register-container">
    <asp:Label ID="lblRegister" runat="server" Text="Register Tutor" CssClass="lblRegister" ></asp:Label>
    <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧Email"></asp:TextBox>
          <asp:CustomValidator ID="CustomValidator1" runat="server" OnServerValidate="CustomValidator1_ServerValidate" ErrorMessage="This email have been registered" ControlToValidate="txtEmail" Display="Dynamic"></asp:CustomValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter your email" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
       <asp:RegularExpressionValidator ID="revEmail" ControlToValidate="txtEmail" CssClass="text-danger" runat="server" ErrorMessage="Enter valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator> 
    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔑 Password" />
               <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter your password" ControlToValidate="txtPass"></asp:RequiredFieldValidator>

    <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password" />
       <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter the password again" ControlToValidate="txtConfirmPass"></asp:RequiredFieldValidator>
 <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password does not match" ControlToCompare="txtPass" ControlToValidate="txtConfirmPass"></asp:CompareValidator>
    <asp:TextBox ID="txtName" runat="server"  CssClass="txtEmail" Placeholder="👤Enter Name :" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please enter your name" ControlToValidate="txtName"></asp:RequiredFieldValidator>
        <asp:DropDownList ID="ddlQualification" runat="server">
            <asp:ListItem>Degree</asp:ListItem>
            <asp:ListItem>PHD</asp:ListItem>
            <asp:ListItem>Master</asp:ListItem>
        </asp:DropDownList>
                <asp:Label ID="lblMessage" runat="server" ></asp:Label>

        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btnSubmit" OnClick="btnSubmit_Click"/>
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btnCancel"/>
        <asp:LinkButton runat="server" ID="lbtnLogin" Text="Login" CssClass="lbtnLogin" />

        </div>
   
      </asp:Panel>

</asp:Content>
