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
        private const string PrizesFile = "PrizeModels.csv";
        //TODO - Wire up the CreatePrize for text files.
        public PrizeModel CreatePrize(PrizeModel model)
        {
            //Load the text file and convert the text to List<PrizeModel>
            List<PrizeModel> prizes = PrizesFile.FullFilePath().LoadFile().ConvertToPrizeModel();

            //Find the max ID
            int currentId = 1;

            if( prizes.Count > 0 ) 
            {
                currentId = prizes.OrderByDescending(x => x.ID).First().ID + 1;
            }

            //int currentId = prizes.OrderByDescending(x => x.ID).Select(x => x.ID).FirstOrDefault() + 1;


            model.ID = currentId;

            //Add the new record with the new ID (max + 1)
            prizes.Add(model);

            //Convert the prizes to list<string>
            //Save the list<string> to the text file
            prizes.SaveToPrizeFile(PrizesFile);

            return model;
        }
    }
}
