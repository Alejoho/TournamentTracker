-- =============================================
-- Author:		Alejandro
-- Create date: 2/4/2024
-- Description: Inserts a new matchup.
-- =============================================
CREATE PROCEDURE dbo.spMatchups_Insert
	@TournamentId int,
	@MatchupRound int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into Matchups(TournamentId,MatchupRound)
	values (@TournamentId,@MatchupRound);

	select @id = SCOPE_IDENTITY();
END