GO 
USE [master];
GO

CREATE DATABASE "Tournaments2";

go

USE "Tournaments2";

GO

CREATE TABLE [Prizes](
[id] [int] IDENTITY(1,1) NOT NULL,
[PlaceNumber] [int] NOT NULL,
[PlaceName] [nvarchar](50) NOT NULL,
[PrizeAmount] [money] NOT NULL,
[PrizePercentage] [float] NOT NULL,
CONSTRAINT [PK_Prizes] PRIMARY KEY CLUSTERED ([id]),
CONSTRAINT [DF_Prizes_PrizeAmount] DEFAULT ((0)) FOR [PrizeAmount],
CONSTRAINT [DF_Prizes_PrizePercentage] DEFAULT ((0)) FOR [PrizePercentage]
);


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
CONSTRAINT [PK_Tournaments] PRIMARY KEY CLUSTERED ([id]),
CONSTRAINT [DF_Tournaments_EntryFee] DEFAULT ((0)) FOR [EntryFee]
);


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
[TeamName] [nvarchar](50) NOT NULL,
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
[WinnerId] [int] NOT NULL,
[MatchupRound] [int] NOT NULL,
CONSTRAINT [PK_Matchups] PRIMARY KEY CLUSTERED ([id])
);



GO
CREATE TABLE [MatchupEntries](
[id] [int] IDENTITY(1,1) NOT NULL,
[MatchupId] [int] NOT NULL,
[ParentMatchupId] [int] NOT NULL,
[TeamCompetingId] [int] NOT NULL,
[Score] [int],
CONSTRAINT [PK_Matchup_Entries] PRIMARY KEY CLUSTERED ([id])
);










