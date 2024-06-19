using API_Alugai.Controllers.Data;
using Microsoft.AspNetCore.Mvc;
using API_Alugai.Controllers.Models;
using Microsoft.EntityFrameworkCore;

namespace API_Alugai.Controllers;

[ApiController]
[Route("[controller]")]
public class PaisesController : ControllerBase
{
    private readonly AppDbContext _context;

    public PaisesController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Pais>>> GetPaises()
    {
        return await _context.PAIS.ToListAsync();
    }
}