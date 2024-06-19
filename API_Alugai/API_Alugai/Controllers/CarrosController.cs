using API_Alugai.Controllers.Data;
using Microsoft.AspNetCore.Mvc;
using API_Alugai.Controllers.Models;
using Microsoft.EntityFrameworkCore;


namespace API_Alugai.Controllers;

[ApiController]
[Route("[controller]")]
public class CarrosController : ControllerBase
{
    private readonly AppDbContext _context;

    public CarrosController(AppDbContext context)
    {
        _context = context;
    }
    
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Carro>>> GetCarros()
    {
        return await _context.CARRO.ToListAsync();
    }

    [HttpGet("minhaQuery")]
    public async Task<ActionResult<IEnumerable<object>>> ExecuteQuery()
    {
        try
        {
            var sql = "SELECT * FROM Carros;"; // Defina sua query aqui

            var result = await _context.CARRO.FromSqlRaw(sql).ToListAsync();
            return Ok(result);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erro ao executar a query: {ex.Message}");
        }
    }

    [HttpPost]
    public async Task<ActionResult<Carro>> PostUtilizador(Carro carro)
    {
        try
        {

            // Adiciona o utilizador ao contexto
            _context.CARRO.Add(carro);

            // Salva as mudanças no banco de dados
            await _context.SaveChangesAsync();

            return Ok("Carro inserido com sucesso");
        }
        catch (Exception ex)
        {
            // Acesse a exceção interna para obter mais detalhes
            var innerExceptionMessage = ex.InnerException != null ? ex.InnerException.Message : string.Empty;

            return StatusCode(500, $"Erro ao inserir o carro: {ex.Message}. Detalhes: {innerExceptionMessage}");
        }
    }
}

