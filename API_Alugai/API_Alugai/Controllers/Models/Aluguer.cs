

namespace API_Alugai.Controllers.Models
{
	public class Aluguer
	{
        public int id_aluguer { get; set; }
        public int cliente_aluguer { get; set; }
        public string carro_aluguer { get; set; }
        public DateTime dataInicio_aluguer { get; set; }
        public DateTime dataPrevistaEntrega_aluguer { get; set; }
        public DateTime dataRealEntrega_aluguer { get; set; }
        public double totalPagarPrevisto_aluguer { get; set; }
        public double totalRealPagar_aluguer { get; set; }
        public string metodoPagamento_aluguer { get; set; }
        public int estado_aluguer { get; set; }
        public string? comentario_aluguer { get; set; }
        public int? avaliacaoCliente_aluguer { get; set; }
        public int? avaliacaoLocador_aluguer { get; set; }
    }
}

