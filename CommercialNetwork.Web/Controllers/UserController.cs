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
    public class UserController : ApiController
    {
        [HttpPost]
        public ResponseModel Registration(UserModel newUser)
        {
            try
            {
                var manager = new UserManager();

                manager.Registration(newUser);

                return new ResponseModel { Success = true };
            }
            catch(Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Update(UserModel newUser)
        {
            try
            {
                var manager = new UserManager();

                manager.Update(newUser);

                return new ResponseModel { Success = true };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Delete(int[] ids)
        {
            try
            {
                var manager = new UserManager();

                manager.Delete(ids);

                return new ResponseModel { Success = true };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Login(UserModel userData)
        {
            try
            {
                var manager = new UserManager();

                var user = manager.Login(userData);

                return new ResponseModel { Success = true, Data = user };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }

        [HttpPost]
        public ResponseModel Customer(UserModel userData)
        {
            try
            {
                var manager = new UserManager();

                var customer = manager.GetCustomerById(userData);

                return new ResponseModel { Success = true, Data = customer };
            }
            catch (Exception ex)
            {
                return new ResponseModel { Success = false, Message = ex.Message };
            }
        }
    }
}
