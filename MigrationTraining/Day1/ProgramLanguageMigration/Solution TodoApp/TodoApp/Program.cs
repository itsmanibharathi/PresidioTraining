
using Microsoft.EntityFrameworkCore;
using TodoApp.Context;
using TodoApp.Model;
using TodoApp.Repository;
using TodoApp.Services;

namespace TodoApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddDbContext<ToDoDbContext>(
             options => options.UseSqlServer(builder.Configuration.GetConnectionString("sqlDbConnection"))
          );

            builder.Services.AddScoped<UserRepository, UserRepository>();
            builder.Services.AddScoped<TodoRepository, TodoRepository>();

            builder.Services.AddScoped<AuthService , AuthService>();
            builder.Services.AddScoped<TodoService , TodoService>();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
