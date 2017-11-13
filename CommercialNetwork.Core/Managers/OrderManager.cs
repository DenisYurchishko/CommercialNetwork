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
    public class OrderManager
    {
        public List<OrderModel> GetOrders(OrderModel orderData)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT
                                        o.[Id],
			                            o.[Status],
			                            o.[Date],
			                            o.[Price],
			                            o.[PersonalInWorkingShiftId],
			                            o.[UserId],
                                        o.[Number]
                                      FROM
                                        [dbo].[Order] AS o
                                      WHERE
                                        o.[UserId] = @UserId AND (@Status IS NULL OR o.[Status] = @Status)";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("UserId", orderData.UserId));
                command.Parameters.Add(new SqlParameter("Status", orderData.Status == null ? Convert.DBNull : orderData.Status));

                var reader = command.ExecuteReader();

                var orderList = new List<OrderModel>();

                if (reader.HasRows)
                {
                    while(reader.Read())
                    {
                        var order = new OrderModel();
                        order.Id = (int)reader["Id"];
                        order.Status = (string)reader["Status"];
                        order.Number = (string)reader["Number"];
                        order.Date = (DateTime)reader["Date"];
                        order.Sum = (decimal)reader["Price"];
                        order.PersonalInWorkingShiftId = (int)reader["PersonalInWorkingShiftId"];
                        order.Products = new List<ProductModel>();

                        var sqlExpressionPrd = @"SELECT
                                        pio.[Quantity] AS 'Qty',
                                        p.[Id] AS 'Id',
                                        p.[Name] AS 'PrdName',
                                        pt.[Name] AS 'PrdTypeName'
                                      FROM
                                        [dbo].[ProductInOrder] AS pio
                                            INNER JOIN [dbo].[Product] AS p ON p.[Id] = pio.[ProductId]
                                            INNER JOIN [dbo].[ProductType] AS pt ON pt.[Id] = p.[ProductTypeId]
                                      WHERE
                                        [OrderId] = @OrderId";

                        var commandPrd = new SqlCommand(sqlExpressionPrd, connection);
                        commandPrd.Parameters.Add(new SqlParameter("OrderId", order.Id));

                        var readerPrd = commandPrd.ExecuteReader();

                        if (readerPrd.HasRows)
                        {
                            while (readerPrd.Read())
                            {
                                var product = new ProductModel();
                                product.Id = (int)readerPrd["Id"];
                                product.Name = (string)readerPrd["PrdName"];
                                product.ProductType = (string)readerPrd["PrdTypeName"];
                                product.Quantity = (decimal)readerPrd["Qty"];

                                order.Products.Add(product);
                            }
                        }

                        orderList.Add(order);
                    }
                }

                return orderList;
            }
        }

        public List<ProductShopModel> GetProducts(string[] types)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                for(var i = 0; i < types.Length; i++)
                {
                    types[i] = "\'" + types[i] + "\'";
                }

                var typeSort = string.Empty;

                if(types.Length != 0)
                {
                    typeSort = "WHERE pt.[Name] IN(" +
                                        string.Join(",", types.Select(x => x.ToString()).ToArray()).TrimEnd(',') + ");";
                }

                var products = new List<ProductShopModel>();

                var sqlExpressionPrd = @"SELECT
                                        p.[Id] AS 'Id',
                                        p.[Name] AS 'PrdName',
                                        pt.[Name] AS 'PrdTypeName'
                                      FROM
                                            [dbo].[Product] AS p
                                            INNER JOIN [dbo].[ProductType] AS pt ON pt.[Id] = p.[ProductTypeId] " + typeSort;

                var commandPrd = new SqlCommand(sqlExpressionPrd, connection);

                var readerPrd = commandPrd.ExecuteReader();

                if (readerPrd.HasRows)
                {
                    while (readerPrd.Read())
                    {
                        var product = new ProductShopModel();
                        product.Id = (int)readerPrd["Id"];
                        product.Name = (string)readerPrd["PrdName"];
                        product.ProductType = (string)readerPrd["PrdTypeName"];

                       

                        sqlExpressionPrd = @"SELECT
                                        [Id]
                                      FROM
                                        [dbo].[ProductInShop]
                                      WHERE
                                        [ProductId] = @ProductId";

                        var command = new SqlCommand(sqlExpressionPrd, connection);
                        command.Parameters.Add(new SqlParameter("ProductId", product.Id));
                        product.ShopIds = new List<int>();

                        var reader = command.ExecuteReader();

                        if (readerPrd.HasRows)
                        {
                            while (readerPrd.Read())
                            {
                                product.ShopIds.Add((int)readerPrd["Id"]);
                            }
                        }

                        products.Add(product);
                    }
                }

                return products;
            }
        }

        public IdNameAddressModel GetShop(int id)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT TOP 1
                                        *
                                      FROM
                                        [dbo].[Shop]
                                      WHERE
                                        [Id] = @Id";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Id", id));

                var reader = command.ExecuteReader();

                if (!reader.HasRows)
                {
                    throw new Exception("Магазина с таким id не существует!");
                }

                reader.Read();

                return new IdNameAddressModel
                {
                    Id = (int)reader["Id"],
                    Name = (string)reader["Name"],
                    Address = (string)reader["Address"]
                };
            }
        }

        public List<IdNameAddressModel> GetShops()
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var shops = new List<IdNameAddressModel>();

                var sqlExpression = @"SELECT
                                        *
                                      FROM
                                        [dbo].[Shop]";

                var command = new SqlCommand(sqlExpression, connection);

                var reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while(reader.Read())
                    {
                        shops.Add(new IdNameAddressModel
                        {
                            Id = (int)reader["Id"],
                            Name = (string)reader["Name"],
                            Address = (string)reader["Address"]
                        });
                    }
                }

                return shops;
            }
        }

        public List<WorkingShiftModel> GetShopTurns(int id)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var turns = new List<WorkingShiftModel>();

                var sqlExpression = @"SELECT
                                        *
                                      FROM
                                        [dbo].[WorkingShift]
                                      WHERE [ShopId] = @ShopId";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("ShopId", id));

                var reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        var turn = new WorkingShiftModel
                        {
                            Id = (int)reader["Id"],
                            DateStart = (DateTime)reader["DateStart"],
                            DateEnd = (DateTime)reader["DateEnd"],
                            Number = (string)reader["Number"],
                            Personal = new List<PersonalModel>()
                        };

                        var manager = new PersonalManager();

                        turn.Personal.Add(manager.GetPersonalById(new PersonalModel { Id = turn.Id }));

                        turns.Add(turn);
                    }
                }

                return turns;
            }
        }

        public void OrderCreate(OrderModel model)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"INSERT INTO [dbo].[Order]
                                    ([Status], [Date], [Price], [PersonalInWorkingShiftId], [UserId], [Number]) 
                                    VALUES 
                                    (@Status, @Date, @Price, @PersonalInWorkingShiftId, @UserId, @Number)";

                var command = new SqlCommand(sqlExpression, connection);
                command.Parameters.Add(new SqlParameter("Status", model.Status));
                command.Parameters.Add(new SqlParameter("Number", model.Number));
                command.Parameters.Add(new SqlParameter("Date", model.Date));
                command.Parameters.Add(new SqlParameter("Price", model.Sum));
                command.Parameters.Add(new SqlParameter("PersonalInWorkingShiftId", model.PersonalInWorkingShiftId));
                command.Parameters.Add(new SqlParameter("UserId", model.UserId));

                command.ExecuteNonQuery();

                sqlExpression = @"SELECT MAX(Id) FROM [dbo].[Order]";

                command = new SqlCommand(sqlExpression, connection);
                var newId = (int)command.ExecuteScalar();

                foreach (var item in model.Products)
                {
                    sqlExpression = @"INSERT INTO [dbo].[ProductInOrder]
                                    ([Quantity], [ProductId], [OrderId]) 
                                    VALUES 
                                    (@Quantity, @ProductId, @OrderId)";

                    command = new SqlCommand(sqlExpression, connection);
                    command.Parameters.Add(new SqlParameter("Quantity", item.Quantity));
                    command.Parameters.Add(new SqlParameter("ProductId", item.Id));
                    command.Parameters.Add(new SqlParameter("OrderId", newId));

                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
