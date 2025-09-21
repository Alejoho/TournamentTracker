CREATE PROCEDURE [spTournaments_GetAll]

AS
BEGIN

	SET NOCOUNT ON;

	select *
	from Tournaments
	where Active=1;;

END