


-- =============================================
-- Author:		Alejandro
-- Create date: 12/2/2023
-- Description: Inserts the relation between a tournament and a team in the TournamentEntries table
-- and returns the id of that relation.
-- =============================================
CREATE PROCEDURE dbo.spTournamentEntries_Insert
	@TournamentId int,
	@TeamId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into TournamentEntries(TournamentId,TeamId)
	values (@TournamentId,@TeamId);

	select @id = SCOPE_IDENTITY();
END