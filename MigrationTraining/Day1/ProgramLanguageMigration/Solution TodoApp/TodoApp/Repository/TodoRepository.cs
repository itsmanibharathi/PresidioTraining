using Microsoft.EntityFrameworkCore;
using TodoApp.Context;
using TodoApp.Model;

namespace TodoApp.Repository
{
    public class TodoRepository
    {
        private ToDoDbContext dbContext;

        public TodoRepository(ToDoDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

        public async Task<Todo> Add(Todo item)
        {
            dbContext.Todos.Add(item);
            await dbContext.SaveChangesAsync();
            return item;
        }

        public async Task<List<Todo>> GetAll()
        {
            try
            {
                return await dbContext.Todos.ToListAsync();
            }
            catch (Exception ex)
            {
                throw new Exception("error in getting all todo list");
            }
        }
    }
}
