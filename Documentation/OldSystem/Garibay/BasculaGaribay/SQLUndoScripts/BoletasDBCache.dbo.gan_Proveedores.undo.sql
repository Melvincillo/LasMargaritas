/****
CAUTION
  To prevent any potential data loss issues, you should review
  this script in detail before running it.

This SQL script was generated by the Configure Data Synchronization
dialog.  This script complements the script that can be used to create
the required database objects required for tracking changes.  This
script contains statements to remove such changes.

For more information see: How to: Configure a Database Server for Synchronization  in help.
****/


IF @@TRANCOUNT > 0
set ANSI_NULLS ON 
set QUOTED_IDENTIFIER ON 

GO
BEGIN TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[gan_Proveedores] DROP CONSTRAINT [DF_gan_Proveedores_LastEditDate]
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[gan_Proveedores] DROP COLUMN [LastEditDate]
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[gan_Proveedores] DROP CONSTRAINT [DF_gan_Proveedores_CreationDate]
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
ALTER TABLE [dbo].[gan_Proveedores] DROP COLUMN [CreationDate]
GO
IF @@ERROR <> 0 
     ROLLBACK TRANSACTION;


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[gan_Proveedores_Tombstone]') and TYPE = N'U') 
   DROP TABLE [dbo].[gan_Proveedores_Tombstone];


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[gan_Proveedores_DeletionTrigger]') AND type = 'TR') 
   DROP TRIGGER [dbo].[gan_Proveedores_DeletionTrigger] 

GO


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[gan_Proveedores_UpdateTrigger]') AND type = 'TR') 
   DROP TRIGGER [dbo].[gan_Proveedores_UpdateTrigger] 

GO


IF @@TRANCOUNT > 0
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[gan_Proveedores_InsertTrigger]') AND type = 'TR') 
   DROP TRIGGER [dbo].[gan_Proveedores_InsertTrigger] 

GO
COMMIT TRANSACTION;