<%@ Page Title="" Language="C#" MasterPageFile="~/Client.Master" AutoEventWireup="true" CodeBehind="resetPassword.aspx.cs" Inherits="CursusVia.Customer.resetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <form id="form1" runat="server">
    <div>
        <asp:Panel ID="Pane_image" runat="server" Visible="false">
        <%--here you can set image according to your requirement--%>
        <img src="images.jpg" alt="" />
        </asp:Panel>
        <asp:Panel ID="Panel_reset_pwd" runat="server" Visible="false">
            <table class="style1">
                <tr>
                    <td class="style2">
                        Enter Your New Password:</td>
                    <td>
                        <asp:TextBox ID="txt_pwd" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                            ControlToValidate="txt_pwd" ErrorMessage="Reqiired"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        Retype Password</td>
                    <td>
                        <asp:TextBox ID="txt_retype_pwd" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                            ControlToValidate="txt_retype_pwd" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server"
                            ControlToCompare="txt_pwd" ControlToValidate="txt_retype_pwd"
                            ErrorMessage="Enter Same Password"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        &nbsp;</td>
                    <td>
                        <asp:Button ID="btn_change_pwd" runat="server" onclick="btn_change_pwd_Click"
                            Text="Change Password" />
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                       </td>
                    <td>
                        <asp:Label ID="lbl_msg" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
              </asp:Panel>
    </div>
    </form>
</asp:Content>
