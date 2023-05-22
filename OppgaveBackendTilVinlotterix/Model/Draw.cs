namespace OppgaveBackendTilVinlotterix.Model
{
    public class Draw
    {
        public Guid Id { get; set; }
        public DateTime Time { get; set; }

        public Draw()
        {
            Id = Guid.NewGuid();
            Time = DateTime.Now;
        }
    }
}
