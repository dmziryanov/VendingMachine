using NUnit.Framework;
using VendingMachine.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Assert = NUnit.Framework.Assert;

namespace UnitTests.Model
{
    [TestFixture]
    class WalletManagerTest
    {
        IWalletManager _walletManager;

        [SetUp]
        public void SetUp()
        {
            _walletManager = new WManager();
            var m = new PrivateObject(typeof(WManager));
        }

        [Test]
        public void CustomerPayment()
        {
            _walletManager.CustomerPayment(CoinType.TenCoins, 1);
            Assert.AreEqual(10, _walletManager.GetCustomerBalance());

            _walletManager.CustomerPayment(CoinType.FiveCoins, 1);
            Assert.AreEqual(15, _walletManager.GetCustomerBalance());

            _walletManager.CustomerPayment(CoinType.TwoCoins, 1);
            Assert.AreEqual(17, _walletManager.GetCustomerBalance());

            _walletManager.CustomerPayment(CoinType.OneCoin, 1);
            Assert.AreEqual(18, _walletManager.GetCustomerBalance());
        }

        [Test]
        public void CustomerPayback()
        {
            _walletManager.CustomerPayment(CoinType.TenCoins, 1);
            _walletManager.CustomerPayment(CoinType.TenCoins, 1);
            Wallet w = _walletManager.GetVmWallet();
            Assert.AreEqual(102, w.Coins[CoinType.TenCoins]);
            Assert.AreEqual(20, _walletManager.GetCustomerBalance());

            _walletManager.CustomerPayBack();
            Assert.AreEqual(0, _walletManager.GetCustomerBalance());
            w = _walletManager.GetCustomerWallet();
            Assert.AreEqual(15,w.Coins[CoinType.TenCoins]);
            w = _walletManager.GetVmWallet();
            Assert.AreEqual(100, w.Coins[CoinType.TenCoins]);
        }

        [Test]
        public void CustomerBuy()
        {
            Assert.AreEqual(0, _walletManager.CustomerBuy(GoodType.Coffee, 1));
            _walletManager.CustomerPayment(CoinType.TenCoins, 1);
            _walletManager.CustomerPayment(CoinType.TenCoins, 1);
            Assert.AreEqual(1, _walletManager.CustomerBuy(GoodType.Coffee, 1));
        }
    }
}
