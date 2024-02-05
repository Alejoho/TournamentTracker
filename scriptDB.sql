GO 
USE [master];

GO
DROP DATABASE if exists [Tournaments];

GO
CREATE DATABASE [Tournaments];

GO
USE [Tournaments];


--Tables


GO
CREATE TABLE [Prizes](
[id] [int] IDENTITY(1,1) NOT NULL,
[PlaceNumber] [int] NOT NULL,
[PlaceName] [nvarchar](50) NOT NULL,
[PrizeAmount] [money] NOT NULL,
[PrizePercentage] [float] NOT NULL,
CONSTRAINT [PK_Prizes] PRIMARY KEY CLUSTERED ([id])
--,
--CONSTRAINT [DF_Prizes_PrizeAmount] DEFAULT ((0)) FOR [PrizeAmount],
--CONSTRAINT [DF_Prizes_PrizePercentage] DEFAULT ((0)) FOR [PrizePercentage]
);

GO
ALTER TABLE [Prizes] ADD CONSTRAINT [DF_Prizes_PrizeAmount] DEFAULT ((0)) FOR [PrizeAmount];

GO
ALTER TABLE [Prizes] ADD CONSTRAINT [DF_Prizes_PrizePercentage] DEFAULT ((0)) FOR [PrizePercentage];


GO
CREATE TABLE [TournamentPrizes](
[id] [int] IDENTITY(1,1) NOT NULL,
[TournamentId] [int] NOT NULL,
[PrizeId] [int] NOT NULL,
CONSTRAINT [PK_Tournament_Prizes] PRIMARY KEY CLUSTERED ([id])
);


GO
CREATE TABLE [Tournaments](
[id] [int] IDENTITY(1,1) NOT NULL,
[TournamentName] [nvarchar](50) NOT NULL,
[EntryFee] [money] NOT NULL,
[Active] [bit] NOT NULL,
CONSTRAINT [PK_Tournaments] PRIMARY KEY CLUSTERED ([id])
--,
--CONSTRAINT [DF_Tournaments_EntryFee] DEFAULT ((0)) FOR [EntryFee]
);

GO
ALTER TABLE [Tournaments] ADD CONSTRAINT [DF_Tournaments_EntryFee] DEFAULT ((0)) FOR [EntryFee];


GO
CREATE TABLE [TournamentEntries](
[id] [int] IDENTITY(1,1) NOT NULL,
[TournamentId] [int] NOT NULL,
[TeamId] [int] NOT NULL,
CONSTRAINT [PK_Tournament_Entries] PRIMARY KEY CLUSTERED ([id]),
);


GO
CREATE TABLE [Teams](
[id] [int] IDENTITY(1,1) NOT NULL,
[TeamName] [nvarchar](100) NOT NULL,
CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED ([id]),
);


GO
CREATE TABLE [TeamMembers](
[id] [int] IDENTITY(1,1) NOT NULL,
[TeamId] [int] NOT NULL,
[PersonId] [int] NOT NULL,
CONSTRAINT [PK_Team_Members] PRIMARY KEY CLUSTERED ([id])
);


GO
CREATE TABLE [People](
[id] [int] IDENTITY(1,1) NOT NULL,
[FirstName] [nvarchar](100) NOT NULL,
[LastName] [nvarchar](100) NOT NULL,
[EmailAddress] [nvarchar](100) NOT NULL,
[CellPhoneNumber] [nvarchar](100),
CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED ([id])
);


GO
CREATE TABLE [Matchups](
[id] [int] IDENTITY(1,1) NOT NULL,
[TournamentId] [int] NOT NULL,
[WinnerId] [int],
[MatchupRound] [int] NOT NULL,
CONSTRAINT [PK_Matchups] PRIMARY KEY CLUSTERED ([id])
);


GO
CREATE TABLE [MatchupEntries](
[id] [int] IDENTITY(1,1) NOT NULL,
[MatchupId] [int] NOT NULL,
[ParentMatchupId] [int] NOT NULL,
[TeamCompetingId] [int],
[Score] [int],
CONSTRAINT [PK_Matchup_Entries] PRIMARY KEY CLUSTERED ([id])
);


--Relations


GO
ALTER TABLE [TournamentPrizes] ADD CONSTRAINT [FK_TournamentPrizes_TournamentId] FOREIGN KEY ([TournamentId]) 
REFERENCES [Tournaments] (id); 

GO
ALTER TABLE [TournamentPrizes] ADD CONSTRAINT [FK_TournamentPrizes_PrizeId] FOREIGN KEY ([PrizeId])
REFERENCES [Prizes] ([id]);

GO
ALTER TABLE [TournamentEntries] ADD CONSTRAINT [FK_TournamentEntries_TournamentId] FOREIGN KEY ([TournamentId])
REFERENCES [Tournaments] ([id]);

GO
ALTER TABLE [TournamentEntries] ADD CONSTRAINT [FK_TournamentEntries_TeamId] FOREIGN KEY ([TeamId])
REFERENCES [Teams] ([id]);

GO
ALTER TABLE [TeamMembers] ADD CONSTRAINT [FK_TeamMembers_TeamId] FOREIGN KEY ([TeamId])
REFERENCES [Teams] ([id]);

GO
ALTER TABLE [TeamMembers] ADD CONSTRAINT [FK_TeamMembers_PersonId] FOREIGN KEY ([PersonId])
REFERENCES [People] ([id]);

GO
ALTER TABLE [Matchups] ADD CONSTRAINT [FK_Matchups_WinnerId] FOREIGN KEY ([WinnerId])
REFERENCES [Teams] ([id]);

GO
ALTER TABLE [Matchups] ADD CONSTRAINT [FK_Matchups_TournamentId] FOREIGN KEY (TournamentId)
REFERENCES [Tournaments] ([id]);

GO
ALTER TABLE [MatchupEntries] ADD CONSTRAINT [FK_MatchupEntries_MatchupId] FOREIGN KEY ([MatchupId])
REFERENCES [Matchups] ([id]);


GO 
ALTER TABLE [MatchupEntries] ADD CONSTRAINT [FK_MatchupEntries_ParentMatchupId] FOREIGN KEY ([ParentMatchupId])
REFERENCES [Matchups] ([id]);

GO
ALTER TABLE [MatchupEntries] ADD CONSTRAINT [FK_MatchupEntries_TeamCompetingId] FOREIGN KEY ([TeamCompetingId])
REFERENCES [Teams] ([id]);






--Store procedures


go
CREATE PROCEDURE [spMatchupEntries_GetByMatchup]
	@MatchupId int

AS
BEGIN

	SET NOCOUNT ON;

	select me.*
	from MatchupEntries me
	inner join Matchups m on me.MatchupId = m.id
	where m.id = @MatchupId;

END



go
CREATE PROCEDURE [spMatchups_GetByTournament]
	@TournamentId int

AS
BEGIN

	SET NOCOUNT ON;

	select m.* 
	from Matchups as m 
	inner join Teams as tm on m.WinnerId = tm.id
	inner join TournamentEntries as te on tm.id = te.TeamId
	inner join Tournaments as t on te.TournamentId = t.id
	where t.id = @TournamentId;

END




go
CREATE PROCEDURE [spPeople_GetAll]

AS
BEGIN

	SET NOCOUNT ON;

	select * 
	from People;

END




go
CREATE PROCEDURE [spPrizes_GetByTournament]
	@TournamentId int

AS
BEGIN

	SET NOCOUNT ON;

	select p.*
	from Prizes p
	inner join TournamentPrizes t on p.id = t.PrizeId
	where t.tournamentId = @TournamentId;

END




go
CREATE PROCEDURE [spTeams_GetByTournament]
	@TournamentId int

AS
BEGIN

	SET NOCOUNT ON;

	select tm.* 
	from Teams as tm	
	inner join TournamentEntries as te on tm.id = te.TeamId
	inner join Tournaments as t on te.TournamentId = t.id
	where t.id = @TournamentId;

END




go
CREATE PROCEDURE [spTeamMembers_GetByTeam]
	@TeamId int

AS
BEGIN

	SET NOCOUNT ON;

		select p.*
	from People as p
	inner join TeamMembers as tm on p.id = tm.PersonId
	inner join Teams as t on tm.TeamId = t.id
	where t.id = @TeamId


END





go
CREATE PROCEDURE [spTournaments_GetAll]

AS
BEGIN

	SET NOCOUNT ON;

	select *
	from Tournaments;

END



go
-- =============================================
-- Author:		Alejandro
-- Create date: 9/10/2023
-- Description:	Inserts a prize in the Prizes tables and returns the id of that record.
-- =============================================
CREATE PROCEDURE dbo.spPrizes_Insert
	@PlaceNumber int,
	@PlaceName nvarchar(50),
	@PrizeAmount money,
	@PrizePercentage float,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into dbo.Prizes (PlaceNumber, PlaceName, PrizeAmount, PrizePercentage)
	values (@PlaceNumber, @PlaceName, @PrizeAmount, @PrizePercentage);

	select @id = SCOPE_IDENTITY();

END


GO


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


GO


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


GO


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


GO

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


GO


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


GO



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


GO



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




-- =============================================
-- Author:		Alejandro
-- Create date: 2/4/2024
-- Description: Inserts a new matchup.
-- =============================================
CREATE PROCEDURE dbo.spMatchups_Insert
	@TournamentId int,
	@MatchupRound int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into Matchups(TournamentId,MatchupRound)
	values (@TournamentId,@MatchupRound);

	select @id = SCOPE_IDENTITY();
END




-- =============================================
-- Author:		Alejandro
-- Create date: 2/4/2024
-- Description: Inserts a new matchup entry.
-- =============================================
CREATE PROCEDURE dbo.spMatchupentries_Insert
	@MatchupId int,
	@ParentMatchupId int,
	@TeamCompetingId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

	insert into MatchupEntries(MatchupId,ParentMatchupId,TeamCompetingId)
	values (@MatchupId,@ParentMatchupId,@TeamCompetingId);

	select @id = SCOPE_IDENTITY();
END