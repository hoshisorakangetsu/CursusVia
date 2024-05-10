<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="AdminAccount.aspx.cs" Inherits="CursusVia.Admin.AdminAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="AccountStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <h2 style="margin: 1rem; margin-bottom: .5rem;">Admin Account</h2>

    <asp:Panel ID="pnlLogin" runat="server" Visible="true">
        <h3 style="margin-left: 1rem;">Login</h3>
        <div id="loginContainer" runat="server" class="login-container">
            <asp:Label ID="lblhavAcc" runat="server" Text="Have an account??" CssClass="lblhavAcc"></asp:Label>
            <asp:Label ID="lblLogin" runat="server" Text="Login" CssClass="lblLogin"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="txtUsername"
                PlaceHolder="👤 Username / Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                ControlToValidate="txtUsername" ErrorMessage="Username is required"
                CssClass="errorVal" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revUsername" runat="server"
                ControlToValidate="txtUsername" ValidationExpression="^\S+@\S+\.\S+$" ErrorMessage="Enter a valid email"
                CssClass="errorVal" Display="Dynamic" />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtPassword" Placeholder="🔒 Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" CssClass="errorVal" Display="Dynamic" />
            <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" Text="Login" OnClick="btnLogin_Click" />
            <asp:LinkButton runat="server" ID="lbtnForgetPass" CssClass="lbtnForgetPass"
                PostBackUrl="AdminForgetPassword.aspx">Forget password?</asp:LinkButton>
            <asp:CheckBox runat="server" ID="cbRememberMe" Text="Remember me"
                CssClass="cbRememberMe"></asp:CheckBox>
            <asp:LinkButton runat="server" ID="lbtnShowRegister" Text="Register"
                OnClick="lbtnShowRegister_Click" CssClass="lbtnRegister" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlRegister" runat="server" Visible="false">
        <h3>Register</h3>
        <div class="backBtn">
            <asp:HyperLink ID="backLink" runat="server" class="backText" NavigateUrl='AdminAccount.aspx'>   
        <span class="material-symbols-outlined backIcon">arrow_back</span>
        Back
            </asp:HyperLink>
        </div>
        <div id="RegisterContainer" runat="server" class="Register-container">
            <asp:Label ID="lblRegister" runat="server" Text="Register Admin" CssClass="lblRegister"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="txtEmail" PlaceHolder="📧 Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmailReg" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="errorVal" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmailReg" runat="server" ControlToValidate="txtEmail" ValidationExpression="^\S+@\S+\.\S+$" ErrorMessage="Enter a valid email" CssClass="errorVal" Display="Dynamic" />
            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="txtPass" Placeholder="🔒 Confirm password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPass" ErrorMessage="Confirm password is required" CssClass="errorVal" Display="Dynamic" />
            <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPass" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" CssClass="errorVal" Display="Dynamic" />
            <asp:TextBox ID="txtVerify" runat="server" CssClass="txtVerify" Placeholder="🔐 Verification key word"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvVerification" runat="server" ControlToValidate="txtVerify" ErrorMessage="Verification keyword is required" CssClass="errorVal" Display="Dynamic" />

            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btnSubmit" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="btnCancel" />
            <asp:LinkButton runat="server" ID="lbtnLogin" Text="Login" OnClick="lbtnShowLogin_Click" CssClass="lbtnLogin" />

        </div>

    </asp:Panel>






</asp:Content>
