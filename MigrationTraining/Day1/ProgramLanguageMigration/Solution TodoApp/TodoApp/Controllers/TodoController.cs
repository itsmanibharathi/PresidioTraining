using Microsoft.AspNetCore.Mvc;
using TodoApp.DTOs;
using TodoApp.Exceptions;
using TodoApp.Services;

namespace TodoApp.Controllers
{
    [Route("api")]
    public class TodoController : ControllerBase
    {
        private TodoService todoService;

        public TodoController(TodoService todoService)
        {
            this.todoService = todoService;
        }

        [HttpPost("todo/add")]
        public async Task<ActionResult<AddTodoReturnDto>> Add([FromBody] AddTodoDto addTodoDto)
        {
            try
            {
                var response = await todoService.AddTodo(addTodoDto);
                var result = new SuccessResponseModel<AddTodoReturnDto>(201, "Todo added successfully", response);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ErrorModel(500, ex.Message));
            }
        }

        [HttpGet("todo/get/{userId}")]
        public async Task<ActionResult<ReadAllReturnTodo>> Add(int userId)
        {
            try
            {
                var response = await todoService.ReadTodo(userId);
                var result = new SuccessResponseModel<ReadAllReturnTodo>(200, "Todos fetched successfully", response);
                return Ok(result);
            }
            catch(UserNotFoundException ex)
            {
                return NotFound(new ErrorModel(404, ex.Message));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ErrorModel(500, ex.Message));
            }
        }
    }
}
