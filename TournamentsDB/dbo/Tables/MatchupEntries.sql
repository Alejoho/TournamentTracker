CREATE TABLE [dbo].[MatchupEntries] (
    [id]              INT IDENTITY (1, 1) NOT NULL,
    [MatchupId]       INT NOT NULL,
    [ParentMatchupId] INT NULL,
    [TeamCompetingId] INT NULL,
    [Score]           INT NULL,
    CONSTRAINT [PK_Matchup_Entries] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_MatchupEntries_MatchupId] FOREIGN KEY ([MatchupId]) REFERENCES [dbo].[Matchups] ([id]),
    CONSTRAINT [FK_MatchupEntries_ParentMatchupId] FOREIGN KEY ([ParentMatchupId]) REFERENCES [dbo].[Matchups] ([id]),
    CONSTRAINT [FK_MatchupEntries_TeamCompetingId] FOREIGN KEY ([TeamCompetingId]) REFERENCES [dbo].[Teams] ([id])
);

