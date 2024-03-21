﻿using System;
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
        /// <summary>
        /// The name of the Team text file with its extension.
        /// </summary>
        private const string TeamFile = "TeamModels.csv";
        /// <summary>
        /// The name of the Tournament text file with its extension.
        /// </summary>
        private const string TournamentFile = "TournamentModels.csv";
        /// <summary>
        /// The name of the Matchup text file with its extension.
        /// </summary>
        private const string MatchupFile = "MatchupModels.csv";
        /// <summary>
        /// The name of the Matchup Entries text file with its extension.
        /// </summary>
        private const string MatchupEntryFile = "MatchupEntryModels.csv";

        /// <summary>
        /// Gives and ID to the new prize and save it to the text file.
        /// </summary>
        /// <param name="model">The prize model.</param>
        /// <returns>The prize model, including the unique identifier.</returns>
        public PrizeModel CreatePrize(PrizeModel model)
        {
            //Load the text file and convert the text to List<PrizeModel>
            List<PrizeModel> prizes = PrizesFile.FullFilePath().LoadFile().ConvertToPrizeModels();

            //Find the max ID
            int currentId = 1;

            if( prizes.Count > 0 ) 
                currentId = prizes.OrderByDescending(x => x.Id).First().Id + 1;

            //TODO - This is an alternative to the code of the line 34 through 37
            //int currentId = prizes.OrderByDescending(x => x.ID).Select(x => x.ID).FirstOrDefault() + 1;

            model.Id = currentId;

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
            List<PersonModel> people = PeopleFile.FullFilePath().LoadFile().ConvertToPersonModels();

            int currentId = 1;

            if (people.Count > 0)
                currentId = people.OrderByDescending(x => x.Id).First().Id + 1;

            model.Id = currentId;

            people.Add(model);

            people.SaveToPeopleFile(PeopleFile);

            return model;
        }

        /// <summary>
        /// Gets all the people
        /// </summary>
        /// <returns>Returns a <c>List<PersonModel></c></returns>
        public List<PersonModel> GetPerson_All()
        {
            return PeopleFile.FullFilePath().LoadFile().ConvertToPersonModels();
        }

        /// <summary>
        /// Gives and ID to the new team and save it to the text file.
        /// </summary>
        /// <param name="model">The team model with all its members.</param>
        /// <returns>The <c>TeamModel</c>, including the unique identifier.</returns>
        public TeamModel CreateTeam(TeamModel model)
        {
            List<TeamModel> teams = TeamFile.FullFilePath().LoadFile().ConvertToTeamModels(PeopleFile);

            int currentId = 1;

            if (teams.Count > 0)
                currentId = teams.OrderByDescending(x => x.Id).First().Id + 1;

            model.Id = currentId;

            teams.Add(model);

            teams.SaveToTeamFile(TeamFile);

            return model;
        }

        public List<TeamModel> GetTeam_All()
        {
            return TeamFile.FullFilePath().LoadFile().ConvertToTeamModels(PeopleFile);
        }

        public void CreateTournament(TournamentModel model)
        {
            List<TournamentModel> tournaments = TournamentFile.
                FullFilePath().
                LoadFile().
                ConvertToTournamentModels(TeamFile, PeopleFile,PrizesFile);

            int currentId = 1;

            if (tournaments.Count > 0)
            {
                currentId = tournaments.OrderByDescending(x => x.Id).First().Id + 1;
            }

            model.Id = currentId;

            model.SaveRoundsToFile(MatchupFile, MatchupEntryFile);

            tournaments.Add(model);

            tournaments.SaveToTournamentFile(TournamentFile);
        }
    }
}
