using API_Alugai.Controllers.Data;
using Microsoft.AspNetCore.Mvc;
using API_Alugai.Controllers.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace API_Alugai.Controllers;

[ApiController]
[Route("[controller]")]
public class ClientesController : ControllerBase
{
    private readonly AppDbContext _context;

    public ClientesController(AppDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<Cliente>>> GetClientes()
    {
        return await _context.CLIENTE.ToListAsync();
    }

    [HttpPost]
    public async Task<ActionResult<Cliente>> PostUtilizador(Cliente cliente)
    {
        try
        {
            // Adiciona o utilizador ao contexto
            _context.CLIENTE.Add(cliente);

            // Salva as mudanças no banco de dados
            await _context.SaveChangesAsync();

            return Ok("Cliente inserido com sucesso");
        }
        catch (Exception ex)
        {
            // Acesse a exceção interna para obter mais detalhes
            var innerExceptionMessage = ex.InnerException != null ? ex.InnerException.Message : string.Empty;

            return StatusCode(500, $"Erro ao inserir o cliente: {ex.Message}. Detalhes: {innerExceptionMessage}");
        }
    }
}

