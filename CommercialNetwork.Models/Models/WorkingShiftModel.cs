using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommercialNetwork.Models.Models
{
    public class WorkingShiftModel : IdModel
    {
        public string Number { get; set; }
        public DateTime DateStart { get; set; }
        public DateTime DateEnd { get; set; }
        public int ShopId { get; set; }
        public List<PersonalModel> Personal { get; set; }
    }
}
