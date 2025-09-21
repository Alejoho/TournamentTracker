-- =============================================
-- Author:		Alejandro
-- Create date: 2/4/2024
-- Description: Inserts a new matchup entry.
-- =============================================
CREATE PROCEDURE dbo.spMatchupEntries_Insert
	@MatchupId int,
	@ParentMatchupId int,
	@TeamCompetingId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into MatchupEntries(MatchupId,ParentMatchupId,TeamCompetingId)
	values (@MatchupId,@ParentMatchupId,@TeamCompetingId);

	select @id = SCOPE_IDENTITY();
END