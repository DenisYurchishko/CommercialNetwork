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
    public class PersonalManager
    {
        public List<PersonalModel> GetSortPersonal(PersonalModel model)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sort = string.Empty;
                var sellers = new List<PersonalModel>();

                switch (model.SortEnum)
                {
                    case "salary_max":
                        sort = " ORDER BY p.[Salary] DESC";
                        break;
                    case "salary_min":
                        sort = " ORDER BY p.[Salary]";
                        break;
                    case "working_turn_max":
                        sort = " ORDER BY (SELECT COUNT(piwsh.[Id]) FROM [dbo].[PersonalInWorkingShift] AS piwsh WHERE piwsh.[PersonalId] = p.[Id]) DESC";
                        break;
                    case "working_turn_min":
                        sort = " ORDER BY (SELECT COUNT(piwsh.[Id]) FROM [dbo].[PersonalInWorkingShift] AS piwsh WHERE piwsh.[PersonalId] = p.[Id])";
                        break;
                    case "premium_max":
                        sort = " ORDER BY p.[Premium] DESC";
                        break;
                    case "premium_min":
                        sort = " ORDER BY p.[Premium]";
                        break;

                }

                var sqlExpression = @"SELECT
                                        p.*
                                      FROM
                                        [dbo].[Personal] AS p" + sort;

                var command = new SqlCommand(sqlExpression, connection);

                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    sellers.Add(new PersonalModel
                    {
                        Id = (int)reader["Id"],
                        Name = (string)reader["Name"],
                        Position = (string)reader["Position"],
                        Premium = Convert.ToDecimal(reader["Premium"]),
                        Salary = Convert.ToDecimal(reader["Salary"])
                    });
                }

                return sellers;
            }
        }

        public PersonalModel GetPersonalById(PersonalModel model)
        {
            using (var connection = DbConnection.GetConnection())
            {
                connection.Open();

                var sqlExpression = @"SELECT
                                        *
                                      FROM
                                        [dbo].[Personal]
                                      WHERE
                                        [Id] = @Id";

                var command = new SqlCommand(sqlExpression, connection);

                command.Parameters.Add(new SqlParameter("Id", model.Id));

                var reader = command.ExecuteReader();

                if (!reader.HasRows)
                {
                    throw new Exception("Продавца с таким Id не существует!");
                }

                reader.Read();

                return new PersonalModel
                {
                    Id = (int)reader["Id"],
                    Name = (string)reader["Name"],
                    Position = (string)reader["Position"],
                    Premium = Convert.ToDecimal(reader["Premium"]),
                    Salary = Convert.ToDecimal(reader["Salary"])
                };
            }
        }

        public void ChangeSalary(PersonalModel model)
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

                sqlExpression = @"UPDATE [dbo].[Personal] 
                                  SET 
                                    [Salary] = @NewSalary
                                  WHERE
                                    [Id] = @Id";

                command.Parameters.Add(new SqlParameter("Id", model.Id));
                command.Parameters.Add(new SqlParameter("NewSalary", model.Salary));

                command.ExecuteNonQuery();
            }
        }
    }
}
