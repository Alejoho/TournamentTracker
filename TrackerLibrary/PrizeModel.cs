using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary
{
    /// <summary>
    /// Represents the characteristic of one place.
    /// </summary>
    public class PrizeModel
    {
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
    }
}
