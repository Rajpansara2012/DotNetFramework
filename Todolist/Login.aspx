﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Todolist.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
        }

        span[id$="rfvLoginEmail"],
        span[id$="revLoginEmail"],
        span[id$="rfvLoginPassword"] {
            display: none;
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
        #btnLogin {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 3px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        #btnLogin:hover {
            background-color: #0056b3;
        }

        #HyperLink1 {
            display: block;
            margin-top: 10px;
            text-align: center;
            font-size: 14px;
            color: #007BFF;
            text-decoration: none;
        }

        #HyperLink1:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:TextBox ID="txtLoginEmail" runat="server" placeholder="Email" />
        <asp:RequiredFieldValidator ID="rfvLoginEmail" runat="server"
            ControlToValidate="txtLoginEmail"
            InitialValue=""
            ErrorMessage="Email is required."
            Display="Dynamic"
            ForeColor="Red" />
        <asp:RegularExpressionValidator ID="revLoginEmail" runat="server"
            ControlToValidate="txtLoginEmail"
            ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b"
            ErrorMessage="Invalid email format."
            Display="Dynamic"
            ForeColor="Red" /><br />

        <asp:TextBox ID="txtLoginPassword" runat="server" TextMode="Password" placeholder="Password" />
        <asp:RequiredFieldValidator ID="rfvLoginPassword" runat="server"
            ControlToValidate="txtLoginPassword"
            InitialValue=""
            ErrorMessage="Password is required."
            Display="Dynamic"
            ForeColor="Red" /><br />

        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />

        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Signup.aspx">If you have not registered yet, click here</asp:HyperLink>
    </form>
</body>
</html>
