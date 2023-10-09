using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.Models;
using TrackerLibrary.DataAccess.TextHelpers;

namespace TrackerLibrary.DataAccess
{
    public class TextConnector : IDataConnection
    {
        /// <summary>
        /// The name of the Prize text file with its extension.
        /// </summary>
        private const string PrizesFile = "PrizeModels.csv";
        /// <summary>
        /// The name of the People text file with its extension.
        /// </summary>
        private const string PeopleFile = "PersonModels.csv";

        //TODO - Wire up the CreatePrize for text files.
        /// <summary>
        /// Gives and ID to the new prize and save it to the text file.
        /// </summary>
        /// <param name="model">The prize model.</param>
        /// <returns>The prize model, including the unique identifier.</returns>
        public PrizeModel CreatePrize(PrizeModel model)
        {
            //Load the text file and convert the text to List<PrizeModel>
            List<PrizeModel> prizes = PrizesFile.FullFilePath().LoadFile().ConvertToPrizeModel();

            //Find the max ID
            int currentId = 1;

            if( prizes.Count > 0 ) 
                currentId = prizes.OrderByDescending(x => x.ID).First().ID + 1;

            //TODO - This is an alternative to the code of the line 34 through 37
            //int currentId = prizes.OrderByDescending(x => x.ID).Select(x => x.ID).FirstOrDefault() + 1;

            model.ID = currentId;

            //Add the new record with the new ID (max + 1)
            prizes.Add(model);

            //Convert the prizes to list<string>
            //Save the list<string> to the text file
            prizes.SaveToPrizeFile(PrizesFile);

            return model;
        }

        /// <summary>
        /// Gives and ID to the new person and save it to the text file.
        /// </summary>
        /// <param name="model">The person model.</param>
        /// <returns>The person model, including the unique identifier.</returns>
        public PersonModel CreatePerson(PersonModel model)
        {
            List<PersonModel> people = PeopleFile.FullFilePath().LoadFile().ConvertToPersonModel();

            int currentId = 1;

            if (people.Count > 0)
                currentId = people.OrderByDescending(x => x.ID).First().ID + 1;

            model.ID = currentId;

            people.Add(model);

            people.SaveToPeopleFile(PeopleFile);

            return model;
        }

        public List<PersonModel> GetPerson_All()
        {
            return PeopleFile.FullFilePath().LoadFile().ConvertToPersonModel();
        }

        public TeamModel CreateTeam(TeamModel model)
        {
            throw new NotImplementedException();
        }
    }
}
