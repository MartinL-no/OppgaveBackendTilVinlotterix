using OppgaveBackendTilVinlotterix.Model;

namespace OppgaveBackendTilVinlotterix.QueryModel
{
    public class DrawQuery: Draw
    {
        public ICollection<Participant>? Winners { get; set; }
        public ICollection<Participant>? Participants { get; set; }
    }
}
