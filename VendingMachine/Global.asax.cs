using System;
using System.Reflection;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Castle.Core.Resource;
using Castle.MicroKernel.Registration;
using Castle.Windsor;
using Castle.Windsor.Configuration.Interpreters;
using Ioc_Windsor_Example;

namespace VendingMachine
{
    public class GlobalApplication : HttpApplication, IContainerAccessor
    {
        private static IWindsorContainer _container;
        public IWindsorContainer Container
        {
            get { return _container; }
        }

        public GlobalApplication()
        {

        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{*favicon}", new { favicon = @"(.*/)?favicon.ico(/.*)?" });

            routes.Add(new Route("{controller}/{action}/{id}", new MvcRouteHandler())
            {
                Defaults = new RouteValueDictionary(new { action = "Index", id = "" }),
            });

            routes.Add(new Route("Default.aspx", new MvcRouteHandler())
            {
                Defaults = new RouteValueDictionary(new { controller = "Home", action = "Index", id = "" }),
            });


        }

        protected void Application_Start(object sender, EventArgs e)
        {
            var filename = "assembly://VendingMachine/windsor.config.xml";
            IResource resource = new AssemblyResource(filename);
            _container = new WindsorContainer(new XmlInterpreter(resource));


            //add all of the controllers to the container
            foreach (var type in Assembly.GetExecutingAssembly().GetTypes())
            {
                if (typeof(IController).IsAssignableFrom(type))
                {
                    _container.Register(Component.For(type).LifestylePerWebRequest());
                }
            }


            ControllerBuilder.Current.SetControllerFactory(new WindsorControllerFactory());
            RegisterRoutes(RouteTable.Routes);
        }
    }
 

  
}