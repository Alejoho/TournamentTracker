

-- =============================================
-- Author:		Alejandro
-- Create date: 10/9/2023
-- Description: Inserts a team in the Teams tables and returns the id of that record.
-- =============================================
CREATE PROCEDURE dbo.spTeams_Insert
	@TeamName nvarchar(100),
	@Id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into Teams (TeamName)
	values (@TeamName);

	select @Id = SCOPE_IDENTITY();
END