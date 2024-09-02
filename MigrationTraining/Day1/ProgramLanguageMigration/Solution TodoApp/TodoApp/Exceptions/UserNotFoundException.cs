namespace TodoApp.Exceptions
{
    public class UserNotFoundException : Exception
    {
        string msg;

        public UserNotFoundException()
        {
            msg = "User Not Found";
        }

        public override string Message => msg;
    }
}
