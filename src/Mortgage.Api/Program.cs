using Microsoft.AspNetCore.Mvc;
using Mortgage.Api.Models;
using Mortgage.Api.Repositories;

namespace Mortgage.Api.Controllers;

[ApiController]
[Route("api/mortgages")]
public class MortgagesController : ControllerBase
{
    private readonly IMortgageRepository _repository;

    public MortgagesController(IMortgageRepository repository)
    {
        _repository = repository;
    }

    // CREATE
    [HttpPost]
    public IActionResult Create(MortgageApplication mortgage)
    {
        _repository.Add(mortgage);
        return Ok(mortgage);
    }

    // READ ALL
    [HttpGet]
    public IActionResult GetAll()
    {
        var mortgages = new[]
        {
            new { Id = 1, TenantId = "TenantA", Amount = 5000000 },
            new { Id = 2, TenantId = "TenantB", Amount = 7500000 }
        };

        return Ok(mortgages);
    }

    // READ BY ID
    [HttpGet("{id}")]
    public IActionResult GetById(Guid id)
    {
        var mortgage = _repository.GetById(id);
        if (mortgage == null)
            return NotFound();

        return Ok(mortgage);
    }

    // UPDATE
    [HttpPut("{id}")]
    public IActionResult Update(Guid id, MortgageApplication mortgage)
    {
        mortgage.Id = id;
        _repository.Update(mortgage);
        return NoContent();
    }

    // DELETE
    [HttpDelete("{id}")]
    public IActionResult Delete(Guid id)
    {
        _repository.Delete(id);
        return NoContent();
    }
}
