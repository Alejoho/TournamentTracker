CREATE PROCEDURE [spTeamMembers_GetByTeam]
	@TeamId int

AS
BEGIN

	SET NOCOUNT ON;

		select p.*
	from People as p
	inner join TeamMembers as tm on p.id = tm.PersonId
	inner join Teams as t on tm.TeamId = t.id
	where t.id = @TeamId


END