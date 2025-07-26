using System.Configuration;
using TrackerLibrary.DataAccess;

namespace TrackerLibrary
{
    public static class GlobalConfig
    {
        /// <summary>
        /// The name of the Prize text file with its extension.
        /// </summary>
        public const string PrizesFile = "PrizeModels.csv";
        /// <summary>
        /// The name of the People text file with its extension.
        /// </summary>
        public const string PeopleFile = "PersonModels.csv";
        /// <summary>
        /// The name of the Team text file with its extension.
        /// </summary>
        public const string TeamFile = "TeamModels.csv";
        /// <summary>
        /// The name of the Tournament text file with its extension.
        /// </summary>
        public const string TournamentFile = "TournamentModels.csv";
        /// <summary>
        /// The name of the Matchup text file with its extension.
        /// </summary>
        public const string MatchupFile = "MatchupModels.csv";
        /// <summary>
        /// The name of the Matchup Entries text file with its extension.
        /// </summary>
        public const string MatchupEntryFile = "MatchupEntryModels.csv";


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
            if (db == DatabaseType.Sql)
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
