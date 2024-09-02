namespace TodoApp.Exceptions
{
    public class UserIdPasswordException : Exception
    {
        public string msg;
        public UserIdPasswordException()
        {
            msg = "Incorrect UserId and Password";
        }

        public override string Message => msg;
    }
}
