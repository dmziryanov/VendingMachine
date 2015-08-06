using System.ServiceModel;
using System.ServiceModel.Web;

namespace AuthServiceLibrary
{
    // This service exposes operations via REST
    [ServiceContract]
    public interface IAuthService
    {
        [OperationContract]
        [WebGet(UriTemplate = "/Login?login={login}&password={password}")]
        int TryLogin(string login, string password);

        [OperationContract]
        [WebGet(UriTemplate = "/Register?login={login}&password={password}")]
        bool Register(string login, string password);

        [OperationContract]
        bool Update(user a);
        
        [OperationContract]
        user GetData(int id);
    }
}
