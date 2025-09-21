


-- =============================================
-- Author:		Alejandro
-- Create date: 12/2/2023
-- Description: Inserts the relation between a tournament and a prize in the TournamentPrizes table
-- and returns the id of that relation.
-- =============================================
CREATE PROCEDURE dbo.spTournamentPrizes_Insert
	@TournamentId int,
	@PrizeId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into TournamentPrizes(TournamentId,PrizeId)
	values (@TournamentId,@PrizeId);

	select @id = SCOPE_IDENTITY();
END