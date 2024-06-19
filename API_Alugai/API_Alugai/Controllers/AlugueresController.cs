using API_Alugai.Controllers.Data;
using API_Alugai.Controllers.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API_Alugai.Controllers;

[ApiController]
[Route("[controller]")]
public class AlugueresController : ControllerBase
{
    private readonly AppDbContext _context;

    public AlugueresController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Aluguer>>> GetAlugueres()
    {
        return await _context.ALUGUER.ToListAsync();
    }

    [HttpGet("minhaQuery")]
    public async Task<ActionResult<IEnumerable<object>>> ExecuteQuery()
    {
        try
        {
            var sql = "SELECT * FROM ALUGUER;"; // Defina sua query aqui

            var result = await _context.ALUGUER.FromSqlRaw(sql).ToListAsync();
            return Ok(result);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro ao executar a query: {ex.Message}");
        }
    }

}

