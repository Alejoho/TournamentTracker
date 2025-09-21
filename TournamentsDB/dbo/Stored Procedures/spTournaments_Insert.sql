

-- =============================================
-- Author:		Alejandro
-- Create date: 12/2/2023
-- Description: Inserts a tournament in the Tournaments table and returns the id of that record.
-- =============================================
CREATE PROCEDURE dbo.spTournaments_Insert
	@TournamentName nvarchar(50),
	@EntryFee money,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into Tournaments(TournamentName,EntryFee,Active)
	values (@TournamentName,@EntryFee,1);

	select @id = SCOPE_IDENTITY();
END