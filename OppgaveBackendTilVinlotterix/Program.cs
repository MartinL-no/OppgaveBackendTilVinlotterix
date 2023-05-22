using Dapper;
using System.Data.SqlClient;
using OppgaveBackendTilVinlotterix.Model;
using OppgaveBackendTilVinlotterix.QueryModel;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var app = builder.Build();
const string connStr = @"Data Source=(localdb)\local;Initial Catalog=Vinlotterix;Integrated Security=True";

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.MapGet("/participants", async () =>
{
    var conn = new SqlConnection(connStr);
    var sql = "SELECT * FROM Participant";
    var contacts = await conn.QueryAsync<Participant>(sql);
    return contacts;
});

app.MapPost("/participants", async (Participant participant) =>
{
    var conn = new SqlConnection(connStr);
    var sql = @"
        INSERT INTO participant (Id, Name)
        VALUES (@Id, @Name)
    ";

    await conn.ExecuteAsync(sql, participant);
    return participant;
});

app.MapDelete("/participants/{Id}", async (Guid id) =>
{
    var conn = new SqlConnection(connStr);
    var sql = @"
        DELETE FROM participant
        WHERE Id = @Id
    ";

    var affectedRows = await conn.ExecuteAsync(sql, new { Id = id });
    return affectedRows == 0 ? Results.NotFound() : Results.Ok();
});

app.MapGet("/draws", async () =>
{
    var conn = new SqlConnection(connStr);
    var participantDictionary = new Dictionary<Guid, DrawQuery>();

    var sql = @"
        SELECT d.Id, d.Time,
            p.Id, p.Name,
            p2.Id, p2.Name
        FROM draw d
        JOIN drawWinner dw ON dw.DrawId = d.Id
        JOIN participant p ON p.Id = dw.ParticipantId
        JOIN drawParticipant dp ON dp.DrawId = d.Id
        JOIN participant p2 ON p2.Id = dp.ParticipantId
        ORDER BY d.Id
    ";

    var draws = conn.Query<DrawQuery, Participant, Participant, DrawQuery>(
            sql,
            (draw, winner, participant) =>
            {
                DrawQuery? drawQuery;
 
                if (!participantDictionary.TryGetValue(draw.Id, out drawQuery))
                {
                    drawQuery = draw;
                    drawQuery.Winners = new List<Participant>();
                    drawQuery.Participants = new List<Participant>();
                    participantDictionary.Add(draw.Id, drawQuery);
                }
                if (winner != null && !drawQuery.Winners.Any(w => w.Id == winner.Id))
                {
                    drawQuery.Winners.Add(winner);
                }
                if (participant != null && !drawQuery.Participants.Any(p => p.Id == participant.Id))
                {
                    drawQuery.Participants.Add(participant);
                }
 
                return drawQuery;
            }, splitOn: "Id")
        .Distinct()
        .ToList();

    return draws;
});

app.MapPost("/draws/{winnersCount}", async (int winnersCount, List<Participant> participants) =>
{
    var conn = new SqlConnection(connStr);
    var draw = new Draw();
    var drawParticipants = new List<DrawParticipant>();
    var drawWinners = new List<DrawWinner>();
    var random = new Random();

    foreach (var participant in participants)
    {
        drawParticipants.Add(new DrawParticipant(draw.Id, participant.Id));
    }

    for (int i = 0; i < Convert.ToInt32(winnersCount); i++)
    {
        var index = random.Next(participants.Count);
        drawWinners.Add(new DrawWinner(draw.Id, participants[index].Id));
    }

    var drawSql = @"
        INSERT INTO draw (Id, Time)
        VALUES (@Id, @Time)
    ";

    var drawParticipantSql = @"
        INSERT INTO drawParticipant (Id, DrawId, ParticipantId)
        VALUES (@Id, @DrawId, @ParticipantId)
    ";

    var drawWinnerSql = @"
        INSERT INTO drawWinner (Id, DrawId, ParticipantId)
        VALUES (@Id, @DrawId, @ParticipantId)
    ";

    conn.Execute(drawSql, draw);
    conn.Execute(drawParticipantSql, drawParticipants);
    conn.Execute(drawWinnerSql, drawWinners);

    return GetDrawObject(draw.Id);
});

app.Run();

DrawQuery GetDrawObject(Guid id)
{
    var conn = new SqlConnection(connStr);
    var participantDictionary = new Dictionary<Guid, DrawQuery>();

    var sql = @"
        SELECT d.Id, d.Time,
            p.Id, p.Name,
            p2.Id, p2.Name
        FROM draw d
        JOIN drawWinner dw ON dw.DrawId = d.Id
        JOIN participant p ON p.Id = dw.ParticipantId
        JOIN drawParticipant dp ON dp.DrawId = d.Id
        JOIN participant p2 ON p2.Id = dp.ParticipantId
        WHERE d.Id = @Id
    ";

    var draws = conn.Query<DrawQuery, Participant, Participant, DrawQuery>(
            sql,
            (draw, winner, participant) =>
            {
                DrawQuery? drawQuery;
 
                if (!participantDictionary.TryGetValue(draw.Id, out drawQuery))
                {
                    drawQuery = draw;
                    drawQuery.Winners = new List<Participant>();
                    drawQuery.Participants = new List<Participant>();
                    participantDictionary.Add(draw.Id, drawQuery);
                }
                if (winner != null && !drawQuery.Winners.Any(w => w.Id == winner.Id))
                {
                    drawQuery.Winners.Add(winner);
                }
                if (participant != null && !drawQuery.Participants.Any(p => p.Id == participant.Id))
                {
                    drawQuery.Participants.Add(participant);
                }
 
                return drawQuery;
            }, param: new { Id = id } , splitOn: "Id")
        .Distinct()
        .ToList();

    return draws.Count() == 0 ? null : draws.First();
}