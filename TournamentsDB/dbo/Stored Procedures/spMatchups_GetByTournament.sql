CREATE PROCEDURE [spMatchups_GetByTournament]
	@TournamentId int

AS
BEGIN

	SET NOCOUNT ON;

	select m.* 
	from Matchups as m 
	where m.TournamentId = @TournamentId
	order by MatchupRound;

END