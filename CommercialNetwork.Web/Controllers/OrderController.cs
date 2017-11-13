using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CommercialNetwork.Models.Models;
using CommercialNetwork.Core.Managers;
using System.Web.Http.Cors;

namespace CommercialNetwork.Web.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class OrderController : ApiController
    {
        [HttpPost]
        public ResponseModel Orders(OrderModel orderData)
        {
            try
            {
                var manager = new OrderManager();

                var orders = manager.GetOrders(orderData);

                return new ResponseModel { Success = true, Data = orders };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Products(string[] types)
        {
            try
            {
                var manager = new OrderManager();

                var products = manager.GetProducts(types);

                return new ResponseModel { Success = true, Data = products };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Shop(IdModel model)
        {
            try
            {
                var manager = new OrderManager();

                var shop = manager.GetShop(model.Id);

                return new ResponseModel { Success = true, Data = shop };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Shops()
        {
            try
            {
                var manager = new OrderManager();

                var shops = manager.GetShops();

                return new ResponseModel { Success = true, Data = shops };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Turns(IdModel model)
        {
            try
            {
                var manager = new OrderManager();

                var turns = manager.GetShopTurns(model.Id);

                return new ResponseModel { Success = true, Data = turns };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        public string OrderCreate(OrderModel model)
        {
            try
            {
                var manager = new OrderManager();

                manager.OrderCreate(model);

                return new ResponseModel { Success = true };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }
    }
}
