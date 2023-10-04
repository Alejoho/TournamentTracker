using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.Models;

//@PlaceNumber int,
//@PlaceName nvarchar(50),
//@PrizeAmount money,
//@PrizePercentage float,
//@id int = 0 output

namespace TrackerLibrary.DataAccess
{
    public class SqlConnector : IDataConnection
    {
        private const string db = "Tournaments";
        //TODO - Make the CreatePrize method actually save to the database
        /// <summary>
        /// Gives and ID to the new prize and save it to the database.
        /// </summary>
        /// <param name="model">The prize model.</param>
        /// <returns>The prize model, including the unique identifier.</returns>
        public PrizeModel CreatePrize(PrizeModel model)
        {
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.CnnString(db)))
            {
                var p = new DynamicParameters();
                p.Add("@PlaceNumber", model.PlaceNumber);
                p.Add("@PlaceName", model.PlaceName);
                p.Add("@PrizeAmount", model.PrizeAmount);
                p.Add("@PrizePercentage", model.PrizePercentage);
                p.Add("@id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                connection.Execute("dbo.spPrizes_Insert", p, commandType: CommandType.StoredProcedure);

                model.ID = p.Get<int>("@id");

                return model;
            }
        }

        /// <summary>
        /// Gives and ID to the new person and save it to the database.
        /// </summary>
        /// <param name="model">The person model.</param>
        /// <returns>The person model, including the unique identifier.</returns>
        public PersonModel CreatePerson(PersonModel model)
        {
            using(IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.CnnString(db)))
            {
                var p = new DynamicParameters();
                p.Add("@FirstName", model.FirstName);
                p.Add("@LastName", model.LastName);
                p.Add("@EmailAddress", model.EmailAddress);
                p.Add("@CellPhoneNumber", model.CellphoneNumber);
                p.Add("@id", 0, DbType.Int32, ParameterDirection.Output);

                connection.Execute("dbo.spPeople_Insert", p, commandType: CommandType.StoredProcedure);

                model.ID = p.Get<int>("@id");

                return model;
            }
        }

        /// <summary>
        /// Gets all the people.
        /// </summary>
        /// <returns>Returns a <c>List<PersonModel></c>.</returns>
        public List<PersonModel> GetPerson_All()
        {
            List<PersonModel> output = new List<PersonModel>();
            using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.CnnString(db)))
            {
                output = connection.Query<PersonModel>("dbo.spPeople_GetAll",commandType: CommandType.StoredProcedure).ToList();
            }
            return output;
        }
    }
}
