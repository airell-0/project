CREATE FUNCTION [dbo].[sf_core_file](
  @lock AS varchar(max) = '',
  @text AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @resp varchar(max),
          @flag int,
          @objs int,
          @note int
  EXECUTE @flag = sp_OACreate 'Scripting.FileSystemObject', @objs OUT
  IF @resp = '' BEGIN
     EXECUTE @flag = sp_OAMethod @objs, 'OpenTextFile', @note OUT, @lock, 8, 1
     IF @resp = '' BEGIN
        EXECUTE @flag = sp_OAMethod  @note, 'WriteLine', Null, @text
        EXECUTE @flag = sp_OADestroy @note
     END
     EXECUTE @flag = sp_OADestroy @objs
  END
  IF @resp = '' SELECT @resp = 'success'
  RETURN @resp
END;
