CREATE TABLE [dbo].[TournamentPrizes] (
    [id]           INT IDENTITY (1, 1) NOT NULL,
    [TournamentId] INT NOT NULL,
    [PrizeId]      INT NOT NULL,
    CONSTRAINT [PK_Tournament_Prizes] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_TournamentPrizes_PrizeId] FOREIGN KEY ([PrizeId]) REFERENCES [dbo].[Prizes] ([id]),
    CONSTRAINT [FK_TournamentPrizes_TournamentId] FOREIGN KEY ([TournamentId]) REFERENCES [dbo].[Tournaments] ([id])
);

