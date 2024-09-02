using TodoApp.DTOs;
using TodoApp.Exceptions;
using TodoApp.Model;
using TodoApp.Repository;

namespace TodoApp.Services
{
    public class AuthService
    {
        private UserRepository userRepository;

        public AuthService(UserRepository userRepository)
        {
            this.userRepository = userRepository;
        }

        public async Task<RegisterReturnDto> RegisterUser(RegisterDto registerDto)
        {
            try
            {
                User user = new User()
                {
                    Name = registerDto.Name,
                    Password = registerDto.Password,
                };
                var newUser = await userRepository.Add(user);
                RegisterReturnDto registerReturnDto = new RegisterReturnDto()
                {
                    UserId = newUser.Id,
                    Name = registerDto.Name,
                };
                return registerReturnDto;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<LoginReturnDto> LoginUser(LoginDTO loginDTO)
        {
            try
            {
                var user = await userRepository.GetById(loginDTO.UserId);
                if(user == null)
                {
                    throw new UserNotFoundException();
                }
                if (user.Password != loginDTO.Password)
                {
                    throw new UserIdPasswordException();
                }
                LoginReturnDto loginReturnDto = new LoginReturnDto()
                {
                    UserId = user.Id,
                    Name = user.Name,
                };
                return loginReturnDto;
            }
            catch(UserNotFoundException)
            {
                throw;
            }
            catch (UserIdPasswordException)
            {
                throw;
            }
            catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
