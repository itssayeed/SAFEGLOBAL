using Mortgage.Api.Models;

namespace Mortgage.Api.Repositories;

public interface IMortgageRepository
{
    IEnumerable<MortgageApplication> GetAll();
    MortgageApplication? GetById(Guid id);
    void Add(MortgageApplication mortgage);
    void Update(MortgageApplication mortgage);
    void Delete(Guid id);
}
