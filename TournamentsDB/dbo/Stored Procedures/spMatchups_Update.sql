-- =============================================
-- Author:		Alejandro
-- Create date: 4/2/2024
-- Description: Updates the winner id of a matchup.
-- =============================================
CREATE PROCEDURE dbo.spMatchups_Update
	@id int,
	@WinnerId int
AS
BEGIN
	SET NOCOUNT ON;

	update dbo.Matchups
	set WinnerId = @WinnerId
	where id = @Id;

END