using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//Load the text file
//Convert the text to List<PrizeModel>
//Find the max ID
//Add the new record with the new ID (max + 1)
//Convert the prizes to list<string>
//Save the list<string> to the text file

namespace TrackerLibrary.DataAccess.TextConnectorTools
{
    public static class TextConnectorProcessor
    {
        public static string FullFilePath(string fileName)
        {
            return $"{ConfigurationManager.AppSettings["filePath"]}\\{fileName}";
        {

    }
}
