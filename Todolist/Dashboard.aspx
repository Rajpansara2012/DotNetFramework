<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Todolist.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .task-gridview {
            width: 100%;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
        }

        .task-gridview th, .task-gridview td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .task-gridview th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .task-gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .edit-textbox {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
        }

        .edit-dropdown {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
        }

        .command-field {
            text-align: center;
        }

        .command-field a {
            text-decoration: none;
            margin-right: 5px;
            padding: 3px 8px;
            background-color: #007bff;
            color: #fff;
            border-radius: 3px;
        }

        .command-field a:hover {
            background-color: #0056b3;
        }

        nav {
            background-color: darkgray;
            color: white;
            padding: 10px 0;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        li {
            display: inline;
            margin-right: 20px;
        }

        a {
            text-decoration: none;
            color: white;
            font-weight: bold;
            transition: color 0.3s;
        }

        a:hover {
            color: gray;
        }

        #lblUsername {
            font-weight: bold;
        }

        .center-text {
            text-align: center;
        }
    </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav>
                <ul>
                    <li>Welcome, <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label></li>
                    <li><asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/Login.aspx" OnClick="lnkLogout_Click" Text="Logout"></asp:HyperLink></li>
                </ul>
            </nav>
            <br />
            <asp:Label ID="lblTask" runat="server" Text="Task:" />
            <asp:TextBox ID="txtTask" runat="server" />
            <asp:Button ID="btnAddTask" runat="server" OnClick="btnAddTask_Click" Text="Add Task" />
            <br />
            <asp:GridView ID="gvTasks" runat="server" AutoGenerateColumns="False" OnRowEditing="gvTasks_RowEditing" OnRowCancelingEdit="gvTasks_RowCancelingEdit" OnRowUpdating="gvTasks_RowUpdating" OnRowDeleting="gvTasks_RowDeleting" DataKeyNames="TaskID" CssClass="task-gridview">
                <Columns>
                    <asp:BoundField DataField="TaskID" HeaderText="Task ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Task Name">
                        <ItemTemplate>
                            <asp:Label ID="lblTaskName" runat="server" Text='<%# Eval("TaskName") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTaskName" runat="server" Text='<%# Bind("TaskName") %>' CssClass="edit-textbox"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblTaskStatus" runat="server" Text='<%# Eval("TaskStatus") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlTaskStatus" runat="server" CssClass="edit-dropdown">
                                <asp:ListItem Text="True" Value="True" />
                                <asp:ListItem Text="False" Value="False" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Task Date">
                        <ItemTemplate>
                            <asp:Label ID="lblTaskDate" runat="server" Text='<%# Eval("TaskDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ItemStyle-CssClass="command-field" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
