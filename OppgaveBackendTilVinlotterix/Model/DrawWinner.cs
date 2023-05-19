namespace OppgaveBackendTilVinlotterix.Model
{
    public class DrawWinner
    {
        public Guid Id { get; set; }
        public Guid DrawId { get; set; }
        public Guid ParticipantId { get; set; }

        public DrawWinner()
        {
            Id = Guid.NewGuid();
        }
        public DrawWinner(Guid drawId, Guid participantId) : this() 
        {
            DrawId = drawId;
            ParticipantId = participantId;
        }
    }
}