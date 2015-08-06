using System.Collections.Generic;

namespace VendingMachine.Models
{
    public enum CoinType
    {
        OneCoin =1,
        TwoCoins =2,
        FiveCoins = 5,
        TenCoins = 10
    }

    public class Wallet
    {
        public int CustomerBalance;
        public Dictionary<CoinType, int> Coins;
    }
}