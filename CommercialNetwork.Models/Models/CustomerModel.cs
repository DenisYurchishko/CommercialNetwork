using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommercialNetwork.Models.Models
{
    public class CustomerModel : UserModel
    {
        public int CountOrders { get; set; }
        public decimal NextDiscount { get; set; }
        public int WaitPayment { get; set; }
    }
}
