CREATE TABLE [dbo].[TournamentEntries] (
    [id]           INT IDENTITY (1, 1) NOT NULL,
    [TournamentId] INT NOT NULL,
    [TeamId]       INT NOT NULL,
    CONSTRAINT [PK_Tournament_Entries] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_TournamentEntries_TeamId] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[Teams] ([id]),
    CONSTRAINT [FK_TournamentEntries_TournamentId] FOREIGN KEY ([TournamentId]) REFERENCES [dbo].[Tournaments] ([id])
);

