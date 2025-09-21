
-- =============================================
-- Author:		Alejandro
-- Create date: 11/1/2023
-- Description: Returns all the teams stored in the database.
-- =============================================
CREATE PROCEDURE dbo.spTeam_GetAll

AS
BEGIN
	SET NOCOUNT ON;

	select * 
	from dbo.Teams;
END