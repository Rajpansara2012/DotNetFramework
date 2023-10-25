using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BCrypt.Net;

namespace Todolist
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtLoginEmail.Text;
            string password = txtLoginPassword.Text;

            using (SqlConnection conn = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\User\\Downloads\\Todolist\\Todolist\\App_Data\\todolist.mdf;Integrated Security=True"))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT UserId, PasswordHash, Salt FROM Users WHERE Username = @Username", conn);
                cmd.Parameters.AddWithValue("@Username", username);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    int userId = Convert.ToInt32(reader["UserId"]);
                    string storedHashedPassword = reader["PasswordHash"].ToString();
                    string salt = reader["Salt"].ToString();

                    string hashedPassword = HashPassword(password, salt);

                    if (storedHashedPassword == hashedPassword)
                    {
                        
                        Session["UserId"] = userId;
                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        Response.Write("Incorrect password.");
                    }
                }
                else
                {
                    Response.Write("User not found.");
                }
            }
        }


        private string HashPassword(string password, string salt)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] saltBytes = Convert.FromBase64String(salt);
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                byte[] combinedBytes = new byte[saltBytes.Length + passwordBytes.Length];

                saltBytes.CopyTo(combinedBytes, 0);
                passwordBytes.CopyTo(combinedBytes, saltBytes.Length);

                byte[] hashedBytes = sha256.ComputeHash(combinedBytes);
                return Convert.ToBase64String(hashedBytes);
            }
        }


    }
}