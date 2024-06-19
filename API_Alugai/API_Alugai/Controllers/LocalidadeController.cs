using API_Alugai.Controllers.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading.Tasks;

namespace API_Alugai.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LocalidadeController : ControllerBase
    {
        private readonly AppDbContext _context;

        public LocalidadeController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("{codPostal}")]
        public async Task<ActionResult<string>> GetLocalidade(int codPostal)
        {
            try
            {
                var localidade = await _context.LOCALIDADE
                    .FirstOrDefaultAsync(l => l.codPostal == codPostal);

                if (localidade != null)
                {
                    return Ok(localidade.nome_localidade); // Retorna o nome da localidade em formato JSON
                }
                else
                {
                    return NotFound(); // Retorna 404 se o código postal não existir na lista
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erro ao buscar localidade: {ex.Message}");
            }
        }
    }
}


