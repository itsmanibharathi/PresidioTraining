using TodoApp.DTOs;
using TodoApp.Model;
using TodoApp.Repository;

namespace TodoApp.Services
{
    public class TodoService
    {
        private TodoRepository repository;

        public TodoService(TodoRepository repository)
        {
            this.repository = repository;
        }   

        public async Task<AddTodoReturnDto> AddTodo(AddTodoDto dto)
        {
            try
            {
                Todo todo = new Todo()
                {
                    UserId = dto.UserId,
                    Title = dto.Title,
                    Description = dto.Description,
                    Status = false
                };
                var addedTodo = await repository.Add(todo);
                return new AddTodoReturnDto
                {
                    TodoId = todo.Id,
                    UserId = todo.UserId,
                    Title = todo.Title,
                    Description = todo.Description,
                    Status = todo.Status
                };

            }
            catch(Exception ex)
            {
                throw new Exception("Error in adding the todo");
            }
        }

        public async Task<ReadAllReturnTodo> ReadTodo(int userId)
        {
            try
            {
                var todoList = await repository.GetAll();
                var ansList = new List<AddTodoReturnDto>();
                foreach(var todo in todoList)
                {
                    if(todo.UserId == userId)
                    {
                        ansList.Add(new AddTodoReturnDto
                        {
                            TodoId = todo.Id,
                            UserId = todo.UserId,
                            Title = todo.Title,
                            Description = todo.Description,
                            Status = todo.Status,
                        }) ;
                    }
                }
                return new ReadAllReturnTodo
                {
                    TodoList = ansList
                };
            }
            catch(Exception ex)
            {
                throw new Exception("Error in getting todo list");
            }
        }
    }
}
