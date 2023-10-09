using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.DataAccess;

namespace TrackerLibrary
{
    public static class GlobalConfig
    {
        /// <summary>
        /// The actual connection set to use in the application
        /// </summary>
        public static IDataConnection Connection { get; private set; }

        /// <summary>
        /// Initialize a new connection.
        /// </summary>
        /// <param name="db">The type of connetion you want to initialize.</param>
        public static void InitializeConnections(DatabaseType db)
        {
            if(db==DatabaseType.Sql)
            {
                //TODO - Set up the SQL Connector properly
                SqlConnector sql = new SqlConnector();
                Connection = sql;
            }

            if (db == DatabaseType.TextFile)
            {
                //TODO - Create the Text Connection
                TextConnector text = new TextConnector();
                Connection = text;
            }
        }

        /// <summary>
        /// Returns the connection string of the passed name.
        /// </summary>
        /// <param name="name">The name of the connection.</param>
        /// <returns>Returns the connection string.</returns>
        public static string CnnString(string name)
        {
            return ConfigurationManager.ConnectionStrings[name].ConnectionString;
        }
    }
}
