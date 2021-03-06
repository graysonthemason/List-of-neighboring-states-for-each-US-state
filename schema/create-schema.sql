
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NeighborStates_NeighborStates_Neighbors]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates] DROP CONSTRAINT [FK_NeighborStates_NeighborStates_Neighbors]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NeighborStates_UsaStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates] DROP CONSTRAINT [FK_NeighborStates_UsaStates]
GO

IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_NeighborStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
BEGIN
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_NeighborStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates] DROP CONSTRAINT [CK_NeighborStates]

END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NeighborStates]') AND type in (N'U'))
DROP TABLE [dbo].[NeighborStates]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsaStates]') AND type in (N'U'))
DROP TABLE [dbo].[UsaStates]
GO

IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_UsaStates_IsRealState]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsaStates]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UsaStates_IsRealState]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UsaStates] DROP CONSTRAINT [DF_UsaStates_IsRealState]
END


End
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsaStates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UsaStates](
	[StateCode] [char](2) COLLATE French_CI_AS NOT NULL,
	[StateName] [varchar](50) COLLATE French_CI_AS NOT NULL,
	[IsRealState] [bit] NOT NULL,
 CONSTRAINT [PK_UsaStates] PRIMARY KEY CLUSTERED 
(
	[StateCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NeighborStates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NeighborStates](
	[StateCode] [char](2) COLLATE French_CI_AS NOT NULL,
	[NeighborStateCode] [char](2) COLLATE French_CI_AS NOT NULL,
 CONSTRAINT [PK_NeighborStates] PRIMARY KEY CLUSTERED 
(
	[StateCode] ASC,
	[NeighborStateCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO

IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_UsaStates_IsRealState]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsaStates]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UsaStates_IsRealState]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UsaStates] ADD  CONSTRAINT [DF_UsaStates_IsRealState]  DEFAULT ((1)) FOR [IsRealState]
END


End
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_NeighborStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates]  WITH NOCHECK ADD  CONSTRAINT [CK_NeighborStates] CHECK  (([StateCode]<[NeighborStateCode]))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_NeighborStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates] CHECK CONSTRAINT [CK_NeighborStates]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'NeighborStates', N'CONSTRAINT',N'CK_NeighborStates'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ensure consistency and avoid redundancy' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'NeighborStates', @level2type=N'CONSTRAINT',@level2name=N'CK_NeighborStates'
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NeighborStates_NeighborStates_Neighbors]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates]  WITH NOCHECK ADD  CONSTRAINT [FK_NeighborStates_NeighborStates_Neighbors] FOREIGN KEY([NeighborStateCode])
REFERENCES [dbo].[UsaStates] ([StateCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NeighborStates_NeighborStates_Neighbors]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates] CHECK CONSTRAINT [FK_NeighborStates_NeighborStates_Neighbors]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NeighborStates_UsaStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates]  WITH NOCHECK ADD  CONSTRAINT [FK_NeighborStates_UsaStates] FOREIGN KEY([StateCode])
REFERENCES [dbo].[UsaStates] ([StateCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_NeighborStates_UsaStates]') AND parent_object_id = OBJECT_ID(N'[dbo].[NeighborStates]'))
ALTER TABLE [dbo].[NeighborStates] CHECK CONSTRAINT [FK_NeighborStates_UsaStates]
GO
