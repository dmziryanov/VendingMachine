using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.SessionState;
using Castle.Windsor;

namespace Ioc_Windsor_Example
{

    public class WindsorControllerFactory : DefaultControllerFactory
    {
        //public IController CreateController(RequestContext context, string controllerName)
        //{
        //    var container = GetContainer(context);

        //    var controllerType = Type.GetType (controllerName + "Controller");
        //    return (IController)container.Resolve(controllerType);
        //}

        protected override IController GetControllerInstance(RequestContext requestContext, Type controllerType)
        {
            if (controllerType == null)
            {
                throw new HttpException(404, string.Format("The controller for path '{0}' could not be found.", requestContext.HttpContext.Request.Path));
            }

            var container = GetContainer(requestContext);

            return (IController)container.Resolve(controllerType);
        }

        public SessionStateBehavior GetControllerSessionBehavior(RequestContext requestContext, string controllerName)
        {
            return SessionStateBehavior.Default;
        }

        private IWindsorContainer GetContainer(RequestContext context)
        {
            var accessor = context.HttpContext.ApplicationInstance as IContainerAccessor;
            if (accessor == null)
                throw new InvalidOperationException(
                    "The Global Application class must implement IContainerAccessor");

            return accessor.Container;
        }

        public void DisposeController(IController controller)
        {
            var disposable = controller as IDisposable;
            if (disposable != null)
                disposable.Dispose();
        }


        public void ReleaseController(IController controller)
        {
            throw new NotImplementedException();
        }
    }

}