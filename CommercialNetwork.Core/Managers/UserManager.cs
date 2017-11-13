using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommercialNetwork.Models.Models;
using CommercialNetwork.Core.Db;
using System.Data.SqlClient;

namespace CommercialNetwork.Core.Managers
{
    public class UserManager
    {
        public void Registration(UserModel newUser)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT
                                        1
                                      FROM 
                                        [dbo].[User]
                                      WHERE
                                        [Login] = @Login OR [Email] = @Email";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Login", newUser.Login));
                command.Parameters.Add(new SqlParameter("Email", newUser.Email));

                var reader = command.ExecuteReader();

                if(reader.HasRows)
                {
                    throw new Exception("Пользователь с таким логином или E-mail уже существует!");
                }

                sqlExpression = @"INSERT INTO [dbo].[User] 
                                    ([Name], [Login], [Password], [Email], [Role]) 
                                  VALUES 
                                    (@Name, @Login, @Password, @Email, @Role)";

                command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Name", newUser.Name));
                command.Parameters.Add(new SqlParameter("Login", newUser.Login));
                command.Parameters.Add(new SqlParameter("Password", newUser.Password));
                command.Parameters.Add(new SqlParameter("Email", newUser.Email));
                command.Parameters.Add(new SqlParameter("Role", newUser.Role));

                command.ExecuteNonQuery();
            }
        }

        public void Update(UserModel newUser)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT TOP 1
                                        *
                                      FROM
                                        [dbo].[User]
                                      WHERE
                                        [Id] = @Id";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Id", newUser.Id));

                var reader = command.ExecuteReader();

                if (!reader.HasRows)
                {
                    throw new Exception("Пользователь с таким Id не найден!");
                }

                reader.Read();

                newUser.Name = newUser.Name ?? (string)reader["Name"];
                newUser.Login = newUser.Login ?? (string)reader["Login"];
                newUser.Password = newUser.Password ?? (string)reader["Password"];
                newUser.Email = newUser.Email ?? (string)reader["Email"];
                newUser.Role = newUser.Role ?? (string)reader["Role"];

                sqlExpression = @"SELECT
                                    1
                                  FROM 
                                    [dbo].[User]
                                  WHERE
                                    ([Login] = @Login OR [Email] = @Email) AND [Id] <> @Id";

                command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Login", newUser.Login));
                command.Parameters.Add(new SqlParameter("Email", newUser.Email));
                command.Parameters.Add(new SqlParameter("Id", newUser.Id));

                reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    throw new Exception("Пользователь с таким логином или E-mail уже существует!");
                }

                sqlExpression = @"UPDATE [dbo].[User] 
                                  SET 
                                    [Name] = @NewName,
                                    [Login] = @NewLogin,
                                    [Password] = @NewPassword,
                                    [Email] = @NewEmail,
                                    [Role] = @NewRole
                                  WHERE
                                    [Id] = @Id";

                command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("NewName", newUser.Name));
                command.Parameters.Add(new SqlParameter("NewLogin", newUser.Login));
                command.Parameters.Add(new SqlParameter("NewPassword", newUser.Password));
                command.Parameters.Add(new SqlParameter("NewEmail", newUser.Email));
                command.Parameters.Add(new SqlParameter("NewRole", newUser.Role));
                command.Parameters.Add(new SqlParameter("Id", newUser.Id));

                command.ExecuteNonQuery();
            }
        }

        public void Delete(int[] ids)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = "DELETE FROM [dbo].[User] WHERE [Id] IN(" +
                    string.Join(",", ids.Select(x => x.ToString()).ToArray()).TrimEnd(',') + ");";

                var command = new SqlCommand(sqlExpression, connection);

                command.ExecuteNonQuery();
            }
        }

        public UserModel Login(UserModel userData)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT TOP 1
                                        *
                                      FROM
                                        [dbo].[User]
                                      WHERE
                                        ([Login] = @Login OR [Email] = @Email) AND [Password] = @Password";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Login", userData.Login == null ? Convert.DBNull : userData.Login));
                command.Parameters.Add(new SqlParameter("Email", userData.Email == null ? Convert.DBNull : userData.Email));
                command.Parameters.Add(new SqlParameter("Password", userData.Password));

                var reader = command.ExecuteReader();

                if (!reader.HasRows)
                {
                    throw new Exception("Пользователя с таким логином и паролем не существует!");
                }

                reader.Read();

                return new UserModel
                {
                    Id = (int)reader["Id"],
                    Name = (string)reader["Name"],
                    Login = (string)reader["Login"],
                    Password = (string)reader["Password"],
                    Email = (string)reader["Email"],
                    Role = (string)reader["Role"]
                };
            }
        }

        public CustomerModel GetCustomerById(UserModel userData)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT TOP 1
                                        *
                                      FROM
                                        [dbo].[User]
                                      WHERE
                                        [Id] = @Id";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Id", userData.Id));

                var reader = command.ExecuteReader();

                if (!reader.HasRows)
                {
                    throw new Exception("Пользователя с таким Id не существует!");
                }

                reader.Read();

                var customer = new CustomerModel();

                customer.Id = (int)reader["Id"];
                customer.Name = (string)reader["Name"];
                customer.Login = (string)reader["Login"];
                customer.Password = (string)reader["Password"];
                customer.Email = (string)reader["Email"];
                customer.Role = (string)reader["Role"];

                sqlExpression = @"SELECT COUNT(*)
                                      FROM
                                        [dbo].[Order]
                                      WHERE
                                        [UserId] = @Id";

                command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Id", userData.Id));

                customer.CountOrders = (int)command.ExecuteScalar();

                sqlExpression = @"SELECT COUNT(*)
                                      FROM
                                        [dbo].[Order]
                                      WHERE
                                        [UserId] = @Id AND [Status] = 'waiting'";

                command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Id", userData.Id));

                customer.WaitPayment = (int)command.ExecuteScalar();

                return customer;
            }
        }
    }
}