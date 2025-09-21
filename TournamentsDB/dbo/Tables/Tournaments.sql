CREATE TABLE [dbo].[Tournaments] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [TournamentName] NVARCHAR (50) NOT NULL,
    [EntryFee]       MONEY         CONSTRAINT [DF_Tournaments_EntryFee] DEFAULT ((0)) NOT NULL,
    [Active]         BIT           NOT NULL,
    CONSTRAINT [PK_Tournaments] PRIMARY KEY CLUSTERED ([id] ASC)
);

