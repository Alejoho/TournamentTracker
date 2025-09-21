

-- =============================================
-- Author:		Alejandro
-- Create date: 9/18/2023
-- Description: Inserts a person in the People tables and returns the id of that record.
-- =============================================
CREATE PROCEDURE dbo.spPeople_Insert
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@EmailAddress nvarchar(50),
	@CellPhoneNumber nvarchar(50),
	@id int = 0 output

AS
BEGIN
	SET NOCOUNT ON;

	insert into People(FirstName, LastName, EmailAddress, CellPhoneNumber)
	values(@FirstName, @LastName, @EmailAddress, @CellPhoneNumber);

	select @id = SCOPE_IDENTITY();

END