USE [AdventureWorks2014]
GO
/****** Object:  StoredProcedure [dbo].[usp_TempVars]    Script Date: 8/15/2018 9:14:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Aaron Dalton>
-- Create date: <7/10/2018>
-- Description:	
-- This Procedure returns the table name and columns in your temp tables.
-- Set up a keyboard shortcut to execute it.
-- Then you can execute it without cluttering up your code and you can,
-- copy and paste column names back into your code as you are developing
-- You need to have the proper security clearance to execute stored
-- Procedures and to access system tables.
-- =============================================




ALTER procedure [dbo].[usp_TempVars]
as

select  left(st.[name],CHARINDEX('_',st.[name]) -1) as TableName, -- this is the table name with the trailling underscores removed 
		sc.[name] as ColumName, --- theis is the plain coumn name
		',['+ sc.[name]+']' as formatedColumnName  ---this is the column name with a comma in front and brackets around the name
from tempdb.sys.columns as sc
inner join tempdb.sys.tables as st
on sc.object_id = st.object_id
where st.name like '#t%'