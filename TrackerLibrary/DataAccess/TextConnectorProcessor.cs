using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.Models;
using System.Data;

// * Load the text file
// * Convert the text to List<PrizeModel>
//Find the max ID
//Add the new record with the new ID (max + 1)
//Convert the prizes to list<string>
//Save the list<string> to the text file

namespace TrackerLibrary.DataAccess.TextHelpers
{
    public static class TextConnectorProcessor
    {
        /// <summary>
        /// Gets the full path of a text file.
        /// </summary>
        /// <param name="fileName">The name of the file with its extension.</param>
        /// <returns>Returns the full path of the file.</returns>
        public static string FullFilePath(this string fileName)
        {
            return $"{ConfigurationManager.AppSettings["filePath"]}\\{fileName}";
        }

        /// <summary>
        /// Loads a text file and returns a <c>List<string></c> of its content.
        /// </summary>
        /// <param name="file">The full path of the text file.</param>
        /// <returns>Returns a <c>List<string></c>.</returns>
        public static List<string> LoadFile(this string file)
        {
            if(!File.Exists(file))
            {
                return new List<string>();
            }
            return File.ReadAllLines(file).ToList();
        }

        /// <summary>
        /// Converts a <c>List<string></c> to a <c>List<PrizeModel></c>.
        /// </summary>
        /// <param name="lines">The <c>List<string></c> that contains the information.</param>
        /// <returns>Returns a <c>List<PrizeModel></c>.</returns>
        public static List<PrizeModel> ConvertToPrizeModel(this List<string> lines)
        {
            List<PrizeModel> output = new List<PrizeModel>();

            foreach(string line in lines)
            {
                string[] cols = line.Split(',');
                PrizeModel p = new PrizeModel();
                p.ID = int.Parse(cols[0]);
                p.PlaceNumber = int.Parse(cols[1]);
                p.PlaceName = cols[2];
                p.PrizeAmount = decimal.Parse(cols[3]);
                p.PrizePercentage = double.Parse(cols[4]);
                output.Add(p);
            }
            return output;
        }

        /// <summary>
        /// Saves a <c>List<PrizeModel></c> to a text file.
        /// </summary>
        /// <param name="models">The <c>List<PrizeModel></c>.</param>
        /// <param name="fileName">The file name with its extension.</param>
        public static void SaveToPrizeFile(this List<PrizeModel> models,string fileName)
        {
            List<string> lines = new List<string>();

            foreach(PrizeModel p in models)
            {
                lines.Add($"{ p.ID },{ p.PlaceNumber },{ p.PlaceName },{ p.PrizeAmount },{ p.PrizePercentage }");
            }
            string path = fileName.FullFilePath();
            File.WriteAllLines(fileName.FullFilePath(), lines);
        }
    }
}
