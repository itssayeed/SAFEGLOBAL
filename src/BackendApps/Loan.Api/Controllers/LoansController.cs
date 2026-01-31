using Microsoft.AspNetCore.Mvc;

namespace Loan.Api.Controllers
{
    [ApiController]
    [Route("api/loans")]
    public class LoansController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new[]
            {
                new { Id = 1, Type = "Home Loan", Amount = 2500000 },
                new { Id = 2, Type = "Car Loan", Amount = 800000 }
            });
        }
    }
}
