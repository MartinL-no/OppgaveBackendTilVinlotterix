namespace OppgaveBackendTilVinlotterix.Model
{
    public class Participant
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        public Participant()
        {
            Id = Guid.NewGuid();
        }

        public Participant(string name) : this() 
        {
            Name = name;
        }
    }
}
