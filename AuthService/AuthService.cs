using System.Linq;
using System.Data;

namespace AuthServiceLibrary
{
    public class AuthService : IAuthService  
    {

        public int TryLogin(string login, string password)
        {
            try
            {
                using (var ctx = new AuthContext())
                {
                    var u = ctx.users.FirstOrDefault(el => el.login == login);
                    if (u != null && u.password == password)
                        return (int) u.user_id;
                }

                return -1;
               
            }
            catch
            {
                return -1;
            }
        }



        public user GetData(int id)
        {
            try
            {
				using (var ctx = new AuthContext())
                {
                    var u = ctx.users.FirstOrDefault(el => el.user_id == id);
                    return u;
                }
            }
            catch
            {
                return new user();
            }
        }

        public bool Register(string login , string password)
        {
            try
            {
				using (var ctx = new AuthContext())
                {
                    if (ctx.users.Any(el => el.login == login)) return false;
                    var u = new user() { login = login, password = password };
                    ctx.AddTousers(u);
                    ctx.SaveChanges();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }


        public bool Update(user a)
        {
            try
            {
				using (var ctx = new AuthContext())
                {
                    if (ctx.users.Any(el => el.login == a.login)) { return false; }
                    ctx.AddTousers(a);
                    ctx.ObjectStateManager.ChangeObjectState(a, EntityState.Modified);                  
                    ctx.SaveChanges();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }

   
}
