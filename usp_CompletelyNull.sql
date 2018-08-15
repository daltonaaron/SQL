use AdventureWorks2014

declare @col varchar(255),
		@table varchar(255),
		@Schema varchar(255),
 @cmd varchar(max)

DECLARE getinfo cursor for
SELECT  c.name as ColumnName, t.name as tableName, s.name as SchemaName 
FROM sys.tables as t 
JOIN sys.columns as c 
ON t.Object_ID = c.Object_ID
join sys.schemas as s
on t.schema_id = s.schema_id


OPEN getinfo

FETCH NEXT FROM getinfo into @col, @table, @Schema

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @cmd = 
	'IF NOT EXISTS (SELECT top 1 * from ['+ @Schema +'].['+ @table +'] WHERE [' + @col + '] IS NOT NULL) BEGIN print '''+ @table +'.' + @col + ' is completely null'+ ''' end'
    EXEC(@cmd)

    FETCH NEXT FROM getinfo into @col, @table, @Schema
END

CLOSE getinfo
DEALLOCATE getinfo

