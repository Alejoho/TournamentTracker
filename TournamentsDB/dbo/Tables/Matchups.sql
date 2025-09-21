CREATE TABLE [dbo].[Matchups] (
    [id]           INT IDENTITY (1, 1) NOT NULL,
    [TournamentId] INT NOT NULL,
    [WinnerId]     INT NULL,
    [MatchupRound] INT NOT NULL,
    CONSTRAINT [PK_Matchups] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_Matchups_TournamentId] FOREIGN KEY ([TournamentId]) REFERENCES [dbo].[Tournaments] ([id]),
    CONSTRAINT [FK_Matchups_WinnerId] FOREIGN KEY ([WinnerId]) REFERENCES [dbo].[Teams] ([id])
);

