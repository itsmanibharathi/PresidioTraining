using Microsoft.AspNetCore.Mvc;
using TodoApp.DTOs;
using TodoApp.Exceptions;
using TodoApp.Services;

namespace TodoApp.Controllers
{
    [Route("api")]
    public class AuthController : ControllerBase
    {
        private AuthService authService;

        public AuthController(AuthService authService)
        {
            this.authService = authService;
        }

        [HttpPost("user/register")]
        public async Task<ActionResult<RegisterReturnDto>> Register([FromBody] RegisterDto registerDto)
        {
            try
            {
                var response = await authService.RegisterUser(registerDto);
                var result = new SuccessResponseModel<RegisterReturnDto>(201, "user registered successfully", response);
                return Ok(result);
            }
            catch(Exception ex)
            {
                return StatusCode(500, new ErrorModel(500, ex.Message));
            }
        }

        [HttpPost("user/login")]
        public async Task<ActionResult<LoginReturnDto>> Login([FromBody] LoginDTO loginDTO)
        {
            try
            {
                var response = await authService.LoginUser(loginDTO);
                var result = new SuccessResponseModel<LoginReturnDto>(201, "user logged in  successfully", response);
                return Ok(result);
            }
            catch(UserIdPasswordException ex)
            {
                return Conflict(new ErrorModel(409, ex.Message));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ErrorModel(500, ex.Message));
            }
        }
    }
}
