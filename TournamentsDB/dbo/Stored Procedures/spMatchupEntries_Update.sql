-- =============================================
-- Author:		Alejandro
-- Create date: 4/2/2024
-- Description: Updates the team competing id or the score of a matchup entry.
-- =============================================
CREATE PROCEDURE dbo.spMatchupEntries_Update
	@id int,
	@TeamCompetingId int = null,
	@Score float = null
AS
BEGIN
	SET NOCOUNT ON;

	update dbo.MatchupEntries
	set TeamCompetingId = @TeamCompetingId, Score = @Score
	where id = @Id;

END