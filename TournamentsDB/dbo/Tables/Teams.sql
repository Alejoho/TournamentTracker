CREATE TABLE [dbo].[Teams] (
    [id]       INT            IDENTITY (1, 1) NOT NULL,
    [TeamName] NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED ([id] ASC)
);

