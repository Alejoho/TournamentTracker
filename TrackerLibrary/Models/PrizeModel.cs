using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary.Models
{
    /// <summary>
    /// Represents the characteristic of one place.
    /// </summary>
    public class PrizeModel
    {
        /// <summary>
        /// The unique identifier for the prize.
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// Place which one team came out.
        /// </summary>
        public int PlaceNumber { get; set; }
        /// <summary>
        /// The name of the place.
        /// </summary>
        public string PlaceName{ get; set; }
        /// <summary>
        /// The flat number that this place earns.
        /// </summary>
        public decimal PrizeAmount { get; set; }
        /// <summary>
        /// The percentage that this place earns.
        /// </summary>
        public double PrizePercentage { get; set; }
        /// <summary>
        /// An empty Constructor
        /// </summary>
        public PrizeModel()
        {
            
        }
        /// <summary>
        /// This Constructor populates the properties of this object
        /// </summary>
        /// <param name="placeName">The place name</param>
        /// <param name="placeNumber">The place number</param>
        /// <param name="prizeAmount">The prize amount. This represents an amount of money</param>
        /// <param name="prizePercentage">The prize percentage. This represents a part of the whole prize pool</param>
        public PrizeModel(string placeName, string placeNumber, string prizeAmount, string prizePercentage)
        {
            PlaceName = placeName;

            int placeNumberValue = 0;
            int.TryParse(placeNumber, out placeNumberValue);
            PlaceNumber = placeNumberValue;

            int prizeAmountValue = 0;
            int.TryParse(prizeAmount, out prizeAmountValue);
            PrizeAmount = prizeAmountValue;

            double prizePercentageValue = 0;
            double.TryParse(prizePercentage, out prizePercentageValue);
            PrizePercentage = prizePercentageValue;
        }
    }
}
