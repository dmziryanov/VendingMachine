using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;
using AuthServiceLibrary;
using VendingMachine.AuthServiceReference;
using IAuthService = VendingMachine.AuthServiceReference.IAuthService;


namespace SimpleLogin.Controllers
{
    public class HomeController : Controller
    {
        private readonly IAuthService _userService;

        public HomeController(IAuthService userService)
        {
            _userService = userService;
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet, ActionName("Exit")]
        public void Exit(FormCollection collection)
        {
            FormsAuthentication.SignOut();
            Session["_user"] = null;
        }

        [HttpGet, ActionName("IsAuthenticated")]
        public bool IsAuthenticated(FormCollection collection)
        {
            return (Session["_user"] != null) && ((int)Session["_user"] != -1);
        }

        [HttpGet, ActionName("Login")]
        public bool Login()
        {
            var login = Request.Params[0];
            var pass = Request.Params[1];

            Session["_user"] = _userService.TryLogin(login, pass);

            if ((int)Session["_user"] != -1)
            {
                FormsAuthentication.SetAuthCookie(login, false);
            }
            return true;
        }

        [HttpGet, ActionName("Register")]
        public bool Register()
        {
            var login = Request.Params[0];
            var pass = Request.Params[1];
            return (_userService.Register(login, pass));
        }

        [HttpGet, ActionName("Update")]
        public bool Update()
        {
            user u = new JavaScriptSerializer().Deserialize<user>(Request.Params[0]);
            u.user_id = (int)Session["_user"];
            return (_userService.Update(u));
        }


        [HttpGet, ActionName("GetData")]
        public JsonResult GetData()
        {
            if (Session["_user"] != null)
            {
                var scClient = new AuthServiceClient();
                user v = scClient.GetData((int)Session["_user"]);
                Json(v);
                return Json(v, JsonRequestBehavior.AllowGet);
            }
            return null;
        }
    }
}
