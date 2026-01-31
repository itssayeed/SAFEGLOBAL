using Mortgage.Api.Repositories;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddSingleton<IMortgageRepository, InMemoryMortgageRepository>();

var app = builder.Build();

app.MapGet("/", () => "API is running");
app.MapControllers();

app.Run();
