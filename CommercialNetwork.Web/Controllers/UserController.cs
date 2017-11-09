using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CommercialNetwork.Models.Models;

namespace CommercialNetwork.Web.Controllers
{
    public class UserController : ApiController
    {
        public UserModel RegistrationUser(UserModel newUser)
        {
            return newUser;
        }
    }
}