CREATE PROCEDURE [spTeams_GetByTournament]
	@TournamentId int

AS
BEGIN

	SET NOCOUNT ON;

	select t.* 
	from Teams as t	
	inner join TournamentEntries as e on t.id = e.TeamId
	where e.TournamentId = @TournamentId;

END