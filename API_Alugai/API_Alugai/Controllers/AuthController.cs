using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Data;
using API_Alugai.Controllers.Models;

namespace API_Alugai.Controllers;

    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public AuthController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

    [HttpPost("login")]
    public IActionResult Login([FromBody] Cliente cliente)
    {
        try
        {
            // Log dos parâmetros recebidos
            Console.WriteLine($"Tentativa de login para NIF: {cliente?.nif_cliente}");

            if (cliente == null || cliente.nif_cliente == 0 || string.IsNullOrEmpty(cliente.senha_cliente))
            {
                return BadRequest(new { mensagem = "NIF e senha são obrigatórios" });
            }

            string query = "SELECT * FROM CLIENTE WHERE nif_cliente = @NifCliente AND senha_cliente = @SenhaCliente";
            using (SqlConnection conn = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@NifCliente", cliente.nif_cliente);
                cmd.Parameters.AddWithValue("@SenhaCliente", cliente.senha_cliente);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        // Log de sucesso de login
                        Console.WriteLine($"Login bem-sucedido para NIF: {cliente?.nif_cliente}");
                        return Ok(new { mensagem = "Login bem-sucedido" });
                    }
                    else
                    {
                        // Log de falha de login
                        Console.WriteLine($"Falha de login para NIF: {cliente?.nif_cliente}");
                        return Unauthorized(new { mensagem = "NIF ou senha inválidos" });
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log de exceção
            Console.WriteLine($"Erro durante o login: {ex.Message}");
            return StatusCode(500, new { mensagem = "Erro interno durante o login" });
        }
    }

}


