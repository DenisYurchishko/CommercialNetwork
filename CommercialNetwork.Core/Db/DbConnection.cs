using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace CommercialNetwork.Core.Db
{
    public static class DbConnection
    {
        private const string ConnectionString = @"Data Source=DESKTOP-693M804;Initial Catalog=CommercialNetwork;Integrated Security=True; MultipleActiveResultSets=True";

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConnectionString);
        }
    }
}