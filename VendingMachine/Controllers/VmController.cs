using System.Linq;
using System.Web.Mvc;
using VendingMachine.Models;

namespace VendingMachine.Controllers
{
    public class VMController : Controller
    {
        private readonly IWalletManager _walletManager;

        public VMController(IWalletManager walletManager)
        {
            _walletManager = walletManager;
        }

        public ActionResult MainScreen()
        {
            return View();
        }

        public JsonResult MakePayment()
        {
            int UserInput;
            string Input = Request.Params[0];
            if (int.TryParse(Input, out UserInput))
            {
                _walletManager.CustomerPayment((CoinType)UserInput, 1);
            }
            
			return Json(new  { CustomerBalance = _walletManager.GetCustomerBalance(), res = -1}, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Buy()
        {
            int userInputQuantity = 0;
            string Input = Request.Params[0].Replace("Buy","");
            
            if (!int.TryParse(Input, out userInputQuantity))
            {
                  return Json(new { CustomerBalance = _walletManager.GetCustomerBalance(), res = 0 }, JsonRequestBehavior.AllowGet);    
            }

            return Json(new { CustomerBalance = _walletManager.GetCustomerBalance(), res = _walletManager.CustomerBuy((GoodType)userInputQuantity, 1) }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAssortment()
        {
            return Json(_walletManager.GetVmAssortment(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCustomerWallet()
        {
            return Json(_walletManager.GetCustomerWallet().Coins.ToList(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetMachineWallet()
        {
            return Json(_walletManager.GetVmWallet().Coins.ToList(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult CustomerPayBack()
        {
            _walletManager.CustomerPayBack();
            
            return Json(new { CustomerBalance = _walletManager.GetCustomerBalance(), res = -1}, JsonRequestBehavior.AllowGet);
        }

        public JsonResult StartItAgain()
        {
            _walletManager.SetInitialValues();
            return Json(new { CustomerBalance = _walletManager.GetCustomerBalance(), res = -1 }, JsonRequestBehavior.AllowGet);
        }
    }
}
