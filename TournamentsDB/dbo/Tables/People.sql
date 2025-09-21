CREATE TABLE [dbo].[People] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]       NVARCHAR (100) NOT NULL,
    [LastName]        NVARCHAR (100) NOT NULL,
    [EmailAddress]    NVARCHAR (100) NOT NULL,
    [CellPhoneNumber] NVARCHAR (100) NULL,
    CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED ([id] ASC)
);

