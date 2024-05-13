<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeneralError.aspx.cs" Inherits="CursusVia.GeneralError" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="general.css" rel="stylesheet" />
    <title>Error</title>
    <style>
        .header{
            color: var(--text-on-surface);
            font-size: 2em;
            text-align:center;
        }

        .content{
            display:flex;
            flex-direction:column;
            margin-top:20em;
        }
        p {
            color: var(--text-on-surface);
            font-size: 1.25em;
            text-align:center;
        }

        .button {
            margin: 1em 40em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="content">
            <span class="header"><b>Oops!</b></span>
            <p>You ran into an error. We will try to fix it as soon as possible.</p>
            <asp:Button ID="Button1" runat="server" Text="BACK TO HOMEPAGE" CssClass="btnPrimary btn button" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
