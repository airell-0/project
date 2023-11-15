CREATE FUNCTION [dbo].[sf_core_info](
) RETURNS varchar(max) AS BEGIN
  DECLARE @text varchar(max)
  SELECT  @text = client_net_address
  FROM    sys.dm_exec_connections
  WHERE   session_id = @@SPID
  IF      @text = '<local machine>' SELECT @text = '127.0.0.1'
  SELECT  @text = ' [1] '+ CONVERT(varchar(25), GETDATE(), 121)
                + ' [2] '+ @text
                + ' [3] '+ HOST_NAME()
                + ' [4] '+ SYSTEM_USER
  RETURN  @text
END;
