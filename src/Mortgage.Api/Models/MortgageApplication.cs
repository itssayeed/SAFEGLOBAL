namespace Mortgage.Api.Models;

public class MortgageApplication
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string CustomerName { get; set; } = string.Empty;
    public decimal LoanAmount { get; set; }
    public int TenureInYears { get; set; }
    public decimal InterestRate { get; set; }
    public string Status { get; set; } = "Created";
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
