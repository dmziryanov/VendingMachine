using System;
using System.Collections.Generic;
using System.Linq;


namespace VendingMachine.Models
{
	public interface IWalletManager
	{
		void CustomerPayment(CoinType c, int quantity);
		byte CustomerBuy(GoodType c, int quantity);
		void CustomerPayBack();
		int GetCustomerBalance();
		void SetInitialValues();

		Wallet GetCustomerWallet();
		Wallet GetVmWallet();

		Assortment GetVmAssortment();
	}

	public class WManager : IWalletManager
	{
		private Wallet _customerWallet;
		private Wallet _vmWallet;
		private Assortment _vmAssortment;
		private int _customerBalance;
		private readonly object _syncRoot = new Object();

		public WManager()
		{
			SetInitialValues();
		}

		public void SetInitialValues()
		{
			_customerWallet = GetInitialCustomerWallet();
			_vmWallet = GetInitialVmWallet();
			_vmAssortment = GetInitialAssortment();
		}

		public Wallet GetCustomerWallet()
		{
			return _customerWallet;
		}

		public Wallet GetVmWallet()
		{
			return _vmWallet;
		}

		public Assortment GetVmAssortment()
		{
			return _vmAssortment;
		}

		private Wallet GetInitialCustomerWallet()
		{
			var CustomerWallet = new Wallet();
			CustomerWallet.Coins = new Dictionary<CoinType, int>();
			CustomerWallet.Coins.Add(CoinType.OneCoin, 10);
			CustomerWallet.Coins.Add(CoinType.TwoCoins, 30);
			CustomerWallet.Coins.Add(CoinType.FiveCoins, 20);
			CustomerWallet.Coins.Add(CoinType.TenCoins, 15);
			return CustomerWallet;
		}

		private Wallet GetInitialVmWallet()
		{
			var VmWallet = new Wallet();
			VmWallet.Coins = new Dictionary<CoinType, int>();
			VmWallet.Coins.Add(CoinType.OneCoin, 100);
			VmWallet.Coins.Add(CoinType.TwoCoins, 100);
			VmWallet.Coins.Add(CoinType.FiveCoins, 100);
			VmWallet.Coins.Add(CoinType.TenCoins, 100);
			VmWallet.CustomerBalance = 0;
			return VmWallet;
		}

		private Assortment GetInitialAssortment()
		{
			_vmAssortment = new Assortment();
			_vmAssortment.Goods = new List<Good>();
			_vmAssortment.Goods.Add(new Good { Price = 13, Type = GoodType.Tea, Quantity = 10, Name = "Tea" });
			_vmAssortment.Goods.Add(new Good { Price = 18, Type = GoodType.Coffee, Quantity = 20, Name = "Coffee" });
			_vmAssortment.Goods.Add(new Good
			{
				Price = 21,
				Type = GoodType.CoffeeWithMilk,
				Quantity = 20,
				Name = "Coffee with milk"
			});
			_vmAssortment.Goods.Add(new Good { Price = 35, Type = GoodType.Juice, Quantity = 15, Name = "Juice" });
			return _vmAssortment;
		}

		public void CustomerPayment(CoinType c, int quantity)
		{
			if (_customerWallet.Coins[c] <= 0) return;
			lock (_syncRoot)
			{
				_vmWallet.Coins[c] += quantity;
				_customerWallet.Coins[c] -= quantity;
				_customerBalance = _customerBalance + quantity * (int)c;
			}
		}

		public byte CustomerBuy(GoodType c, int quantity)
		{
			Good good = _vmAssortment.Goods.FirstOrDefault(x => x.Type == c);
			var Sum = good.Price * quantity;
			if (Sum > _customerBalance) return 0;

			lock (_syncRoot)
			{
				_customerBalance = _customerBalance - Sum;
				_vmAssortment.Goods.FirstOrDefault(x => x.Type == c).Quantity -= quantity;
			}

			return 1;
		}

		public void CustomerPayBack()
		{
			lock (_syncRoot)
			{
				while (_customerBalance > 0)
				{
					CoinType curDenominator = 0;

					if ((int)CoinType.TenCoins <= _customerBalance)
					{
						curDenominator = CoinType.TenCoins;
					}
					else if ((int)CoinType.FiveCoins <= _customerBalance)
					{
						curDenominator = CoinType.FiveCoins;
					}
					else if ((int)CoinType.TwoCoins <= _customerBalance)
					{
						curDenominator = CoinType.TwoCoins;
					}
					else if ((int)CoinType.OneCoin <= _customerBalance)
					{
						curDenominator = CoinType.OneCoin;
					}

					if (_vmWallet.Coins[curDenominator] == 0) break;

					_customerBalance -= (int)curDenominator;
					_vmWallet.Coins[curDenominator] -= 1;
					_customerWallet.Coins[curDenominator] += 1;
				}
			}
		}

		public int GetCustomerBalance()
		{
			return _customerBalance;
		}
	}
}

