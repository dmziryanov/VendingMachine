using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace AuthServiceLibrary
{
    class Program
    {
        static void Main(string[] args)
        {
            ServiceHost sh = new ServiceHost(typeof(AuthService));

            sh.Open();

            Console.WriteLine("up and running");

            Console.ReadLine();

            sh.Close();
        }
    }
}
