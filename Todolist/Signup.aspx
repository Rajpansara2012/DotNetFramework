<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="Todolist.Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        /* Style the form container */
        #form1 {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Style text input fields */
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
        }

        /* Style error messages */
        span[id$="rfvEmail"], span[id$="revEmail"], span[id$="rfvPassword"], span[id$="revPassword"], span[id$="cvPasswordMatch"] {
            display: none;
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }

        /* Style the Sign Up button */
        #btnSignup {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 3px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        #btnSignup:hover {
            background-color: #0056b3;
        }

        /* Style the login link */
        #login_link {
            display: block;
            margin-top: 10px;
            text-align: center;
            font-size: 14px;
            color: #007BFF;
            text-decoration: none;
        }

        #login_link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:TextBox ID="txtUsername" runat="server" placeholder="Email" />
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtUsername"
            InitialValue="" ErrorMessage="Email is required." Display="Dynamic" ForeColor="Red" />
        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtUsername"
            ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="Invalid email format."
            Display="Dynamic" ForeColor="Red" /><br />

        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
            InitialValue="" ErrorMessage="Password is required." Display="Dynamic" ForeColor="Red" />
        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
            ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$"
            ErrorMessage="Password must be at least 6 characters long and include at least one letter and one number."
            Display="Dynamic" ForeColor="Red" /><br />

        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
        <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToValidate="txtConfirmPassword"
            ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." Display="Dynamic" ForeColor="Red" /><br />

        <asp:Button ID="btnSignup" runat="server" Text="Sign Up" OnClick="btnSignup_Click" /><br />

        <asp:HyperLink ID="login_link" runat="server" NavigateUrl="~/Login.aspx">If you already have an account, click here to log in</asp:HyperLink>
    </form>
</body>
</html>
