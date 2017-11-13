using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommercialNetwork.Models.Models
{
    public class SupplyModel : IdModel
    {
        public DateTime SupplyDate { get; set; }
        public int ShopId { get; set; }
        public IdNameAddressModel Provider { get; set; }
        public List<ProductModel> Products { get; set; }
    }
}