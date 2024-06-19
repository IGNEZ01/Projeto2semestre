using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using API_Alugai.Controllers.Models;
using API_Alugai.Controllers.Data;

namespace API_Alugai.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CombustiveisController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CombustiveisController(AppDbContext context)
        {
            _context = context;
        }

        // GET: /Combustiveis
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Combustivel>>> GetCombustiveis()
        {
            return await _context.COMBUSTIVEL.ToListAsync();
        }

        // GET: /Combustiveis/1
        [HttpGet("{id}")]
        public async Task<ActionResult<Combustivel>> GetCombustivel(int id)
        {
            var combustivel = await _context.COMBUSTIVEL.FindAsync(id);

            if (combustivel == null)
            {
                return NotFound();
            }

            return combustivel;
        }

        // POST: /Combustiveis
        [HttpPost]
        public async Task<ActionResult<Combustivel>> PostCombustivel(Combustivel combustivel)
        {
            _context.COMBUSTIVEL.Add(combustivel);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCombustivel), new { id = combustivel.id_combustivel }, combustivel);
        }

        // PUT: /Combustiveis/1
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCombustivel(int id, Combustivel combustivel)
        {
            if (id != combustivel.id_combustivel)
            {
                return BadRequest();
            }

            _context.Entry(combustivel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CombustivelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: /Combustiveis/1
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCombustivel(int id)
        {
            var combustivel = await _context.COMBUSTIVEL.FindAsync(id);
            if (combustivel == null)
            {
                return NotFound();
            }

            _context.COMBUSTIVEL.Remove(combustivel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CombustivelExists(int id)
        {
            return _context.COMBUSTIVEL.Any(e => e.id_combustivel == id);
        }
    }
}
