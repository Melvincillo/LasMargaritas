/****
This SQL script was generated by the Configure Data Synchronization
dialog box. This script contains statements that create the
change-tracking columns, deleted-items table, and triggers on the
server database. These database objects are required by Synchronization
Services to successfully synchronize data between client and server
databases. For more information, see the
‘How to: Configure a Database Server for Synchronization’ topic in Help.
****/


IF @@TRANCOUNT > 0
set ANSI_NULLS ON 
set QUOTED_IDENTIFIER ON 

GO
BEGIN TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[Boletas] 
ADD [LastEditDate] DateTime NULL CONSTRAINT [DF_Boletas_LastEditDate] DEFAULT (GETUTCDATE()) WITH VALUES
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[Boletas] 
ADD [CreationDate] DateTime NULL CONSTRAINT [DF_Boletas_CreationDate] DEFAULT (GETUTCDATE()) WITH VALUES
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Boletas_Tombstone]')) 
BEGIN 
CREATE TABLE [dbo].[Boletas_Tombstone]( 
    [boletaID] Int NOT NULL,
    [DeletionDate] DateTime NULL
) ON [PRIMARY] 
END 

GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[Boletas_Tombstone] ADD CONSTRAINT [PKDEL_Boletas_Tombstone_boletaID]
   PRIMARY KEY CLUSTERED
    ([boletaID])
    ON [PRIMARY]
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Boletas_DeletionTrigger]') AND type = 'TR') 
   DROP TRIGGER [dbo].[Boletas_DeletionTrigger] 

GO
CREATE TRIGGER [dbo].[Boletas_DeletionTrigger] 
    ON [dbo].[Boletas] 
    AFTER DELETE 
AS 
SET NOCOUNT ON 
UPDATE [dbo].[Boletas_Tombstone] 
    SET [DeletionDate] = GETUTCDATE() 
    FROM deleted 
    WHERE deleted.[boletaID] = [dbo].[Boletas_Tombstone].[boletaID] 
IF @@ROWCOUNT = 0 
BEGIN 
    INSERT INTO [dbo].[Boletas_Tombstone] 
    ([boletaID], DeletionDate)
    SELECT [boletaID], GETUTCDATE()
    FROM deleted 
END 

GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Boletas_UpdateTrigger]') AND type = 'TR') 
   DROP TRIGGER [dbo].[Boletas_UpdateTrigger] 

GO
CREATE TRIGGER [dbo].[Boletas_UpdateTrigger] 
    ON [dbo].[Boletas] 
    AFTER UPDATE 
AS 
BEGIN 
    SET NOCOUNT ON 
    UPDATE [dbo].[Boletas] 
    SET [LastEditDate] = GETUTCDATE() 
    FROM inserted 
    WHERE inserted.[boletaID] = [dbo].[Boletas].[boletaID] 
END;
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[Boletas_InsertTrigger]') AND type = 'TR') 
   DROP TRIGGER [dbo].[Boletas_InsertTrigger] 

GO
CREATE TRIGGER [dbo].[Boletas_InsertTrigger] 
    ON [dbo].[Boletas] 
    AFTER INSERT 
AS 
BEGIN 
    SET NOCOUNT ON 
    UPDATE [dbo].[Boletas] 
    SET [CreationDate] = GETUTCDATE() 
    FROM inserted 
    WHERE inserted.[boletaID] = [dbo].[Boletas].[boletaID] 
END;
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;
COMMIT TRANSACTION;