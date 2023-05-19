using Dapper;
using System;
using System.Data.SqlClient;
using OppgaveBackendTilVinlotterix.Model;
using OppgaveBackendTilVinlotterix.QueryModel;
using static System.Net.Mime.MediaTypeNames;
using static System.Runtime.InteropServices.JavaScript.JSType;

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

app.MapPost("/draws", async (DrawQuery drawQuery) =>
{
    var conn = new SqlConnection(connStr);
    var draw = new Draw();
    var winners = new List<DrawWinner>();
    var participants = new List<DrawParticipant>();

    foreach (var winner in drawQuery.Winners)
    {
        winners.Add(new DrawWinner(winner.Id, draw.Id));
    }

    foreach (var participant in drawQuery.Participants)
    {
        participants.Add(new DrawParticipant(participant.Id, draw.Id));
    }

    var drawSql = @"
        INSERT INTO draw (Id, Time)
        VALUES (@Id, @Time)
    ";

    var drawParticipantSql = @"
        INSERT INTO drawParticipant (Id, DrawId, DrawParticipant)
        VALUES (@Id, @DrawId, @DrawParticipant)
    ";

    var drawWinnerSql = @"
        INSERT INTO drawWinner (Id, DrawId, DrawWinner)
        VALUES (@Id, @DrawId, @DrawWinner)
    ";

    conn.Execute(drawSql, draw);
    await conn.ExecuteAsync(drawWinnerSql, winners);
    await conn.ExecuteAsync(drawParticipantSql, participants);
});

app.Run();

DrawQuery GetDrawObject(Guid Id)
{
    var conn = new SqlConnection(connStr);

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

    var isDrawQueryUninitialized = true;
    var draws = conn.Query<DrawQuery, Participant, Participant, DrawQuery>(
            sql,
            (draw, winner, participant) =>
            {
                DrawQuery? drawQuery = null;
 
                if (isDrawQueryUninitialized)
                {
                    drawQuery = draw;
                    drawQuery.Winners = new List<Participant>();
                    drawQuery.Participants = new List<Participant>();
                    isDrawQueryUninitialized = false;
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

    return draws.Count() == 0 ? null : draws.First();
}