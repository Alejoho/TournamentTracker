CREATE PROCEDURE [spPrizes_GetByTournament]
	@TournamentId int

AS
BEGIN

	SET NOCOUNT ON;

	select p.*
	from Prizes p
	inner join TournamentPrizes t on p.id = t.PrizeId
	where t.tournamentId = @TournamentId;

END