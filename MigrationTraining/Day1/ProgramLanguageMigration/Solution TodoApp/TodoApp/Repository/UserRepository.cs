using Microsoft.EntityFrameworkCore;
using TodoApp.Context;
using TodoApp.Model;

namespace TodoApp.Repository
{
    public class UserRepository
    {
        private ToDoDbContext dbContext;

        public UserRepository(ToDoDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        public async Task<User> Add(User user)
        {
            try
            {
                dbContext.Users.Add(user);
                await dbContext.SaveChangesAsync();
                return user;
            }
            catch (Exception ex)
            {
                throw new Exception("Error in registering user");
            }
           
        }

        public async Task<User> GetById(int id)
        {
            try
            {
                var user = await dbContext.Users.SingleOrDefaultAsync(u => u.Id == id);
                return user;
            }
            catch(Exception ex)
            {
                throw new Exception("Error in login the user");
            }
          
        }

       
    }
}
