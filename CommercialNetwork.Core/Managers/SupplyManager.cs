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
    public class SupplyManager
    {
        public List<SupplyModel> GetSupplies()
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var supplies = new List<SupplyModel>();

                var sqlExpressionPrd = @"SELECT
                                            p.[Id] AS 'pId',
                                            p.[Name] AS 'pName',
                                            p.[Address] AS 'pAddress',
                                            s.[SupplyDate],
                                            s.[ShopId],
                                            s.[Id]
                                         FROM
                                            [dbo].[Supply] AS s
                                            INNER JOIN [dbo].[Provider] AS p ON p.[Id] = s.[ProviderId]";

                var commandPrd = new SqlCommand(sqlExpressionPrd, connection);

                var readerPrd = commandPrd.ExecuteReader();

                if (readerPrd.HasRows)
                {
                    while (readerPrd.Read())
                    {
                        var supply = new SupplyModel();
                        supply.Id = (int)readerPrd["Id"];
                        supply.ShopId = (int)readerPrd["ShopId"];
                        supply.SupplyDate = (DateTime)readerPrd["SupplyDate"];
                        supply.Provider.Id = (int)readerPrd["pId"];
                        supply.Provider.Name = (string)readerPrd["pName"];
                        supply.Provider.Address = (string)readerPrd["pAddress"];



                        sqlExpressionPrd = @"SELECT
                                                p.[Name],
                                                p.[Id],
                                                pis.[Quantity],
                                                pis.[NewPrice]
                                            FROM
                                            [dbo].[ProductInSupply] AS pis
                                                INNER JOIN [dbo].[Product] AS p ON pis.[ProductId] = p.[Id]
                                            WHERE
                                                [SupplyId] = @SupplyId";

                        var command = new SqlCommand(sqlExpressionPrd, connection);
                        command.Parameters.Add(new SqlParameter("SupplyId", supply.Id));

                        var reader = command.ExecuteReader();

                        if (readerPrd.HasRows)
                        {
                            while (readerPrd.Read())
                            {
                                var product = new ProductModel();

                                product.Id = (int)readerPrd["Id"];
                                product.Name = (string)readerPrd["Name"];
                                product.Quantity = (decimal)readerPrd["Quantity"];
                                product.Price = (int)readerPrd["NewPrice"];

                                supply.Products.Add(product);
                            }
                        }

                        supplies.Add(supply);
                    }
                }

                return supplies;
            }
        }

        public SupplyModel GetSupplyById(int id)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();
                
                var supply = new SupplyModel();

                var sqlExpressionPrd = @"SELECT TOP 1
                                            p.[Id] AS 'pId',
                                            p.[Name] AS 'pName',
                                            p.[Address] AS 'pAddress',
                                            s.[SupplyDate],
                                            s.[ShopId],
                                            s.[Id]
                                         FROM
                                            [dbo].[Supply] AS s
                                            INNER JOIN [dbo].[Provider] AS p ON p.[Id] = s.[ProviderId]
                                         WHERE s.[Id] = @Id";

                var commandPrd = new SqlCommand(sqlExpressionPrd, connection);
                commandPrd.Parameters.Add(new SqlParameter("Id", id));

                var readerPrd = commandPrd.ExecuteReader();

                if (!readerPrd.HasRows)
                {
                    throw new Exception("Поставки с таким id не существует!");
                }

                readerPrd.Read();

                supply.Id = (int)readerPrd["Id"];
                supply.ShopId = (int)readerPrd["ShopId"];
                supply.SupplyDate = (DateTime)readerPrd["SupplyDate"];
                supply.Provider.Id = (int)readerPrd["pId"];
                supply.Provider.Name = (string)readerPrd["pName"];
                supply.Provider.Address = (string)readerPrd["pAddress"];

                sqlExpressionPrd = @"SELECT
                                                p.[Name],
                                                p.[Id],
                                                pis.[Quantity],
                                                pis.[NewPrice]
                                            FROM
                                            [dbo].[ProductInSupply] AS pis
                                                INNER JOIN [dbo].[Product] AS p ON pis.[ProductId] = p.[Id]
                                            WHERE
                                                pis.[SupplyId] = @SupplyId";

                var command = new SqlCommand(sqlExpressionPrd, connection);
                command.Parameters.Add(new SqlParameter("SupplyId", supply.Id));

                var reader = command.ExecuteReader();

                if (readerPrd.HasRows)
                {
                    while (readerPrd.Read())
                    {
                        var product = new ProductModel();

                        product.Id = (int)readerPrd["Id"];
                        product.Name = (string)readerPrd["Name"];
                        product.Quantity = (decimal)readerPrd["Quantity"];
                        product.Price = (int)readerPrd["NewPrice"];

                        supply.Products.Add(product);
                    }
                }

                return supply;
            }
        }

        public List<NeedToSupplyModel> GetNeedToSupply(int shopId)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var needToSupplies = new List<NeedToSupplyModel>();

                var sqlExpressionPrd = @"SELECT
                                                p.[Name] AS 'pName',
                                                sh.[Name] AS 'shName'
                                            FROM
                                            [dbo].[NeedToSupply] AS nts
                                                INNER JOIN [dbo].[Product] AS p ON nts.[ProductId] = p.[Id]
                                                INNER JOIN [dbo].[Shop] AS sh ON nts.[ShopId] = sh.[Id]
                                            WHERE
                                                [ShopId] = @ShopId";

                var commandPrd = new SqlCommand(sqlExpressionPrd, connection);
                commandPrd.Parameters.Add(new SqlParameter("ShopId", shopId));

                var readerPrd = commandPrd.ExecuteReader();

                if (readerPrd.HasRows)
                {
                    while (readerPrd.Read())
                    {
                        var nts = new NeedToSupplyModel();
                        nts.ShopName = (string)readerPrd["shName"];
                        nts.ProductName = (string)readerPrd["pName"];

                        needToSupplies.Add(nts);
                    }
                }

                return needToSupplies;
            }
        }
    }
}
