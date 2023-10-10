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
        /// Converts a <c>List<string></c> to a <c>List<PersonModel></c>.
        /// </summary>
        /// <param name="lines">The <c>List<string></c> that contains the information.</param>
        /// <returns>Returns a <c>List<PersonModel></c>.</returns>
        public static List<PersonModel> ConvertToPersonModel(this List<string> lines)
        {
            List<PersonModel> output = new List<PersonModel>();

            foreach (string line in lines)
            {
                string[] cols = line.Split(',');
                PersonModel p = new PersonModel();
                p.ID = int.Parse(cols[0]);
                p.FirstName = cols[1];
                p.LastName = cols[2];
                p.EmailAddress = cols[3];
                p.CellphoneNumber = cols[4];
                output.Add(p);
            }
            return output;
        }

        /// <summary>
        /// Converts a <c>List<string></c> to a <c>List<TeamModel></c>.
        /// </summary>
        /// <param name="lines">The <c>List<string></c> that contains the information.</param>
        /// <param name="peopleFileName">The name of the Team text file with its extension.</param>
        /// <returns>Returns a <c>List<TeamModel></c>.</returns>
        public static List<TeamModel> ConvertToTeamModel(this List<string> lines, string peopleFileName)
        {
            //id,team name,lis of ids separated by the pipe
            //3,Tim's Team,1|3|5
            List<TeamModel> output = new List<TeamModel>();
            List<PersonModel> people = peopleFileName.FullFilePath().LoadFile().ConvertToPersonModel();

            foreach (string line in lines)
            {
                string[] cols = line.Split(',');

                TeamModel t = new TeamModel();
                t.Id = int.Parse(cols[0]);
                t.TeamName = cols[1];

                string[] personIds = cols[2].Split('|');

                foreach (string id in personIds)
                {
                    t.TeamMembers.Add(people.Where(x => x.ID == int.Parse(id)).First());
                }
            }

            return output;
        }

        /// <summary>
        /// Saves a <c>List<PrizeModel></c> to a text file.
        /// </summary>
        /// <param name="models">The <c>List<PrizeModel></c>.</param>
        /// <param name="fileName">The file name in which to save the information with its extension.</param>
        public static void SaveToPrizeFile(this List<PrizeModel> models,string fileName)
        {
            List<string> lines = new List<string>();

            foreach(PrizeModel p in models)
            {
                lines.Add($"{ p.ID },{ p.PlaceNumber },{ p.PlaceName },{ p.PrizeAmount },{ p.PrizePercentage }");
            }

            File.WriteAllLines(fileName.FullFilePath(), lines);
        }

        /// <summary>
        /// Saves a <c>List<PersonModel></c> to a text file.
        /// </summary>
        /// <param name="models">The <c>List<PersonModel></c>.</param>
        /// <param name="fileName">The file name in which to save the information with its extension.</param>
        public static void SaveToPeopleFile(this List<PersonModel> models, string fileName)
        {
            List<string> lines = new List<string>();

            foreach (PersonModel p in models)
            {
                lines.Add($"{ p.ID },{ p.FirstName },{ p.LastName },{ p.EmailAddress },{ p.CellphoneNumber }");
            }

            File.WriteAllLines(fileName.FullFilePath(), lines);
        }

        /// <summary>
        /// Saves a <c>List<TeamModel></c> to a text file.
        /// </summary>
        /// <param name="models">The <c>List<TeamModel></c>.</param>
        /// <param name="fileName">The file name in which to save the information with its extension.</param>
        public static void SaveToTeamFile(this List<TeamModel> models, string fileName)
        {
            List<string> lines = new List<string>();

            foreach(TeamModel t in models)
            {
                lines.Add($"{t.Id},{t.TeamName},{ConvertPeopleListToString(t.TeamMembers)}");
            }

            File.WriteAllLines(fileName.FullFilePath(), lines);
        }

        private static string ConvertPeopleListToString(List<PersonModel> teamMembers)
        {
            string output = "";

            if (teamMembers.Count == 0)
            {
                return "";
            }

            foreach (PersonModel p in teamMembers) 
            {
                output += $"{p.ID}|";
            }

            output = output.Substring(0, output.Length - 1);

            return output;
        }
    }
}
