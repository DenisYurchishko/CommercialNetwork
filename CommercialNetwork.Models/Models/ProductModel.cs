using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommercialNetwork.Models.Models
{
    public class ProductModel : IdNameModel
    {
        public string ProductType { get; set; }
        public decimal Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
