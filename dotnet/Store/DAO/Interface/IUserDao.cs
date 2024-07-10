using System.Collections.Generic;
using webstore.Models;

namespace webstore.DAO.Interface
{
    public interface IUserDao
    {
        IList<User> GetUsers();
        User GetUserById(int id);
        User GetUserByUsername(string username);
        User CreateUser(string username, string password, string role);
    }
}
