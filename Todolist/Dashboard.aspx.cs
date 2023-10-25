using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Todolist
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\User\\Downloads\\Todolist\\Todolist\\App_Data\\todolist.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTasks();
            }
            if (!IsPostBack)
            {
                int userID;
                if (Session["UserID"] != null && int.TryParse(Session["UserID"].ToString(), out userID))
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        string query = "SELECT Username FROM Users WHERE UserID = @UserID";
                        SqlCommand cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            lblUsername.Text = reader["Username"].ToString();
                        }
                        else
                        {
                            
                            lblUsername.Text = "Guest"; 
                        }
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                    lblUsername.Visible = false; 
                }
            }



        }

        protected void btnAddTask_Click(object sender, EventArgs e)
        {
            string taskName = txtTask.Text.Trim();
            if (!string.IsNullOrEmpty(taskName))
            {
                if (Session["UserID"] != null)
                {
                    int userID = Convert.ToInt32(Session["UserID"]);
                    DateTime currentDate = DateTime.Now;
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        string query = "INSERT INTO Tasks (TaskName, TaskStatus,TaskDate, UserID) VALUES (@TaskName, 0, @TaskDate,@UserID)";
                        SqlCommand cmd = new SqlCommand(query, connection);
                        cmd.Parameters.AddWithValue("@TaskName", taskName);
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        cmd.Parameters.AddWithValue("@TaskDate", currentDate);
                        cmd.ExecuteNonQuery();
                    }
                    txtTask.Text = string.Empty;
                    BindTasks();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void gvTasks_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTasks.EditIndex = e.NewEditIndex;
            BindTasks();
        }

        protected void gvTasks_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTasks.EditIndex = -1;
            BindTasks();
        }

        protected void gvTasks_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvTasks.Rows[e.RowIndex];
            int taskId = Convert.ToInt32(gvTasks.DataKeys[e.RowIndex].Values["TaskID"]);
            string taskName = ((TextBox)row.FindControl("txtTaskName")).Text.Trim();
            DropDownList ddlTaskStatus = (DropDownList)row.FindControl("ddlTaskStatus");

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "UPDATE Tasks SET TaskName = @TaskName, TaskStatus = @TaskStatus WHERE TaskID = @TaskID";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@TaskName", taskName);
                cmd.Parameters.AddWithValue("@TaskStatus", ddlTaskStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@TaskID", taskId);
                cmd.ExecuteNonQuery();
            }

            gvTasks.EditIndex = -1;
            BindTasks();
        }

        protected void gvTasks_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int taskId = Convert.ToInt32(gvTasks.DataKeys[e.RowIndex].Values["TaskID"]);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "DELETE FROM Tasks WHERE TaskID = @TaskID";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@TaskID", taskId);
                cmd.ExecuteNonQuery();
            }

            BindTasks();
        }

        private void BindTasks()
        {
            if (Session["UserID"] != null)
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT TaskID, TaskName, TaskStatus, TaskDate FROM Tasks WHERE UserID = @UserID";
                    SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                    adapter.SelectCommand.Parameters.AddWithValue("@UserID", userID);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    gvTasks.DataSource = dt;
                    gvTasks.DataBind();
                }
            }
        }
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }

    }
}