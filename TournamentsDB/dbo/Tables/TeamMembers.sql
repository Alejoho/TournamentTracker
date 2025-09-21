CREATE TABLE [dbo].[TeamMembers] (
    [id]       INT IDENTITY (1, 1) NOT NULL,
    [TeamId]   INT NOT NULL,
    [PersonId] INT NOT NULL,
    CONSTRAINT [PK_Team_Members] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_TeamMembers_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[People] ([id]),
    CONSTRAINT [FK_TeamMembers_TeamId] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[Teams] ([id])
);

