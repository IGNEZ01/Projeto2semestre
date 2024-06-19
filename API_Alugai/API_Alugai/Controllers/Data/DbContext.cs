using Microsoft.EntityFrameworkCore;
using API_Alugai.Controllers.Models;

namespace API_Alugai.Controllers.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }
        public DbSet<Localidade> LOCALIDADE { get; set; }
        public DbSet<Cor> COR { get; set; }
        public DbSet<TipoCarro> TIPOCARRO { get; set; }
        public DbSet<Marca> MARCA { get; set; }
        public DbSet<Modelo> MODELO { get; set; }
        public DbSet<Combustivel> COMBUSTIVEL { get; set; }
        public DbSet<Cliente> CLIENTE { get; set; }
        public DbSet<Carro> CARRO { get; set; }
        public DbSet<Aluguer> ALUGUER { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            //configurar a chave primaria
            modelBuilder.Entity<Cliente>()
                .HasKey(u => u.nif_cliente);

            modelBuilder.Entity<Carro>()
                .HasKey(u => u.matricula_carro);

            modelBuilder.Entity<Aluguer>()
                .HasKey(u => u.id_aluguer);

            modelBuilder.Entity<Localidade>()
                .HasKey(u => u.codPostal);

            modelBuilder.Entity<Cor>()
                .HasKey(u => u.id_cor);

            modelBuilder.Entity<TipoCarro>()
                .HasKey(u => u.id_tipoCarro);

            modelBuilder.Entity<Marca>()
                .HasKey(u => u.id_marca);

            modelBuilder.Entity<Modelo>()
                .HasKey(u => u.id_modelo);

            modelBuilder.Entity<Combustivel>()
                .HasKey(u => u.id_combustivel);

            base.OnModelCreating(modelBuilder);
        }
    }
}
