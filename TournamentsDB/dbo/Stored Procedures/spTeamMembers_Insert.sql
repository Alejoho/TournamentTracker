

-- =============================================
-- Author:		Alejandro
-- Create date: 10/9/2023
-- Description: Inserts the relation between a team and a team member in the TeamMembers tables 
-- and returns the id of that relation.
-- =============================================
CREATE PROCEDURE dbo.spTeamMembers_Insert
	@TeamId int,
	@PersonId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into TeamMembers (TeamId,PersonId)
	values (@TeamId,@PersonId);

	select @id = SCOPE_IDENTITY();
END