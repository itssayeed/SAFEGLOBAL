using Mortgage.Api.Models;

namespace Mortgage.Api.Repositories;

public class InMemoryMortgageRepository : IMortgageRepository
{
    private static readonly List<MortgageApplication> _mortgages = [];

    public IEnumerable<MortgageApplication> GetAll() => _mortgages;

    public MortgageApplication? GetById(Guid id) =>
        _mortgages.FirstOrDefault(m => m.Id == id);

    public void Add(MortgageApplication mortgage) =>
        _mortgages.Add(mortgage);

    public void Update(MortgageApplication mortgage)
    {
        var existing = GetById(mortgage.Id);
        if (existing is null) return;

        existing.CustomerName = mortgage.CustomerName;
        existing.LoanAmount = mortgage.LoanAmount;
        existing.TenureInYears = mortgage.TenureInYears;
        existing.InterestRate = mortgage.InterestRate;
        existing.Status = mortgage.Status;
    }

    public void Delete(Guid id)
    {
        var mortgage = GetById(id);
        if (mortgage is not null)
            _mortgages.Remove(mortgage);
    }
}
