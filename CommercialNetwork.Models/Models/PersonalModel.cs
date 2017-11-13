using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommercialNetwork.Models.Models
{
    public class PersonalModel : IdNameModel
    {
        public string Position { get; set; }
        public decimal Salary { get; set; }
        public decimal? Premium { get; set; }
        public string SortEnum { get; set; }
    }
}
