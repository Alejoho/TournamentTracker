CREATE PROCEDURE [dbo].[spTournaments_Delete]
	@TournamentId int
AS
BEGIN
	
    SET NOCOUNT ON;

    DELETE FROM Prizes
    WHERE id IN (
        SELECT PrizeId
        FROM TournamentPrizes
        WHERE TournamentId = @TournamentId
    );

    DELETE FROM TournamentPrizes
    WHERE TournamentId = @TournamentId;

    ------------------------------------------
    
    DELETE FROM TournamentEntries
    WHERE TournamentId = @TournamentId;

    ------------------------------------------

    DELETE FROM MatchupEntries
    WHERE MatchupId IN(
        SELECT id 
        FROM Matchups
        WHERE TournamentId = @TournamentId);


    DELETE FROM Matchups
    WHERE TournamentId = @TournamentId;

    ------------------------------------------

    DELETE FROM Tournaments
    WHERE id = @TournamentId;

END
