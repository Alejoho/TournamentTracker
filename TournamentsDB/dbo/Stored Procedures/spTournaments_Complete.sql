CREATE PROCEDURE dbo.spTournaments_Complete
	@id int
AS
BEGIN
	SET NOCOUNT ON;

	update dbo.Tournaments
	set Active = 0
	where id = @Id;

END