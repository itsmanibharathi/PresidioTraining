namespace TodoApp.DTOs
{
    public class AddTodoReturnDto
    {
        public int TodoId { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public bool Status { get; set; }

        public int UserId { get; set; }
    }
}
