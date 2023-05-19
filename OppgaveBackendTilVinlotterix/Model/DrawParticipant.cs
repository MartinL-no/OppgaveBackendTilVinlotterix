namespace OppgaveBackendTilVinlotterix.Model
{
    public class DrawParticipant
    {
        public Guid Id { get; set; }
        public Guid DrawId { get; set; }
        public Guid ParticipantId { get; set; }

        public DrawParticipant()
        {
            Id = Guid.NewGuid();
        }
        public DrawParticipant(Guid drawId, Guid participantId) : this() 
        {
            DrawId = drawId;
            ParticipantId = participantId;
        }
    }
}