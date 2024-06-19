
namespace API_Alugai.Controllers.Models
{
	public class Cliente
	{
        public int nif_cliente { get; set; }
        public string nome_cliente { get; set; }
        public string morada_cliente { get; set; }
        public int codPostal_cliente { get; set; }
        public int telefone_cliente { get; set; }
        public string email_cliente { get; set; }
        //public DateTime nascimento_cliente { get; set; }
        public string carta_cliente { get; set; }
        public string senha_cliente { get; set; }
    }
}

