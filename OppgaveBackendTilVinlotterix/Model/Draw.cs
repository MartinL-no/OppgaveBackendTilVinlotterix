namespace OppgaveBackendTilVinlotterix.Model
{
    public class Draw
    {
        public Guid Id { get; set; }
        public DateTime Time { get; set; }
        public string Winners { get; set; }
        public string Participants { get; set; }

        public Draw()
        {
            Id = Guid.NewGuid();
            Time = DateTime.Now;
        }

        public Draw(string winners, string participants) : this()
        {
            Winners = winners;
            Participants = participants;
        }
    }
}
