CREATE PROCEDURE [dbo].[sf_core_dbcc]
AS BEGIN
  SET NOCOUNT ON
     DBCC FREEPROCCACHE WITH NO_INFOMSGS;
     DBCC FREEPROCCACHE ('default');
  EXECUTE sp_updatestats
  DECLARE @kill varchar(8000),
          @dbid int
  SELECT  @kill = '',
          @dbid = DB_ID()
  SELECT  @kill = @kill +'kill '+ CONVERT(varchar(5), spid) +';'
  FROM    sys.sysprocesses
  WHERE   last_batch < DATEADD(mi, -30, GETDATE())
    AND   spid <> @@SPID
    AND   dbid = @dbid
  EXECUTE (@kill);
  SELECT  @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
  FROM    sys.dm_exec_sessions
  WHERE   host_name IS NOT NULL
    AND   session_id <> @@SPID
  EXECUTE (@kill);
  SET NOCOUNT OFF
END;
