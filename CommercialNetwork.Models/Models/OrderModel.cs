using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommercialNetwork.Models.Models
{
    public class OrderModel : IdModel
    {
        public string Number { get; set; }
        public DateTime Date { get; set; }
        public List<ProductModel> Products { get; set; }
        public decimal Sum { get; set; }
        public string Status { get; set; }
        public int UserId { get; set; }
        public int PersonalInWorkingShiftId { get; set; }
    }
}
