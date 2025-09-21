CREATE PROCEDURE [spMatchupEntries_GetByMatchup]
	@MatchupId int

AS
BEGIN

	SET NOCOUNT ON;

	select me.*
	from MatchupEntries me
	inner join Matchups m on me.MatchupId = m.id
	where m.id = @MatchupId;

END