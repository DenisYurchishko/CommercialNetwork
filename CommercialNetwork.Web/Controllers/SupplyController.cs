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
    public class SupplyController : ApiController
    {
        [HttpPost]
        public ResponseModel Supplies()
        {
            try
            {
                var manager = new SupplyManager();

                var supplies = manager.GetSupplies();

                return new ResponseModel { Success = true, Data = supplies };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Supply(IdModel model)
        {
            try
            {
                var manager = new SupplyManager();

                var supplies = manager.GetSupplyById(model.Id);

                return new ResponseModel { Success = true, Data = supplies };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel NeedToSupply(IdModel model)
        {
            try
            {
                var manager = new SupplyManager();

                var supplies = manager.GetNeedToSupply(model.Id);

                return new ResponseModel { Success = true, Data = supplies };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        public ResponseModel SupplyCreate(SupplyModel model)
        {
            try
            {
                var manager = new SupplyManager();

                manager.SupplyCreate(model);

                return new ResponseModel { Success = true };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }
    }
}
