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
    public class PersonalController : ApiController
    {
        [HttpPost]
        public ResponseModel Sellers(PersonalModel model)
        {
            try
            {
                var manager = new PersonalManager();

                var sellers = manager.GetSortPersonal(model);

                return new ResponseModel { Success = true, Data = sellers };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Seller(PersonalModel model)
        {
            try
            {
                var manager = new PersonalManager();

                var seller = manager.GetPersonalById(model);

                return new ResponseModel { Success = true, Data = seller };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel ChangeSalaru(PersonalModel model)
        {
            try
            {
                var manager = new PersonalManager();

                manager.ChangeSalary(model);

                return new ResponseModel { Success = true };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel CreateWorkingShift(WorkingShiftModel model)
        {
            try
            {
                var manager = new PersonalManager();

                manager.CreateWorkingShift(model);

                return new ResponseModel { Success = true };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }
    }
}
