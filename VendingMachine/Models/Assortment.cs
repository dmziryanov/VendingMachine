using System.Collections.Generic;

namespace VendingMachine.Models
{
    public enum GoodType
    {
        Tea = 1,
        Coffee = 2,
        CoffeeWithMilk =3,
        Juice = 4
    }

    public class Good
    {
        public GoodType Type;
        public int Price;
        public int Quantity;
        public string Name;
    }

    public class Assortment
    {
        public List<Good> Goods;
    }
}