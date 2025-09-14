using System;
using System.Collections.Generic;

namespace TrackerLibrary.Models
{
    /// <summary>
    /// Represents a tournament
    /// </summary>
    public class TournamentModel
    {
        public event EventHandler<DateTime> OnTournamentComplete;
        /// <summary>
        /// The unique identifier for the tournament.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// The tournament name
        /// </summary>
        public string TournamentName { get; set; }
        /// <summary>
        /// The entry fee of the tournament
        /// </summary>
        public decimal EntryFee { get; set; }
        /// <summary>
        /// The teams that have entered to the tournament
        /// </summary>
        public List<TeamModel> EnteredTeams { get; set; } = new List<TeamModel>();
        /// <summary>
        /// The prizes for the winners
        /// </summary>
        public List<PrizeModel> Prizes { get; set; } = new List<PrizeModel>();
        /// <summary>
        /// The matchups that the differents teams have to play
        /// </summary>
        public List<List<MatchupModel>> Rounds { get; set; } = new List<List<MatchupModel>>();

        public void CompleteTournament()
        {
            OnTournamentComplete?.Invoke(this, DateTime.Now);
        }
    }
}
