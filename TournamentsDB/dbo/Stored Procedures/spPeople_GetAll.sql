CREATE PROCEDURE [spPeople_GetAll]

AS
BEGIN

	SET NOCOUNT ON;

	select * 
	from People;

END