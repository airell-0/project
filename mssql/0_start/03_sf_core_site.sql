CREATE FUNCTION [dbo].[sf_core_site](
  @lock AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @resp varchar(8000),
          @stat varchar(255),
          @note varchar(255),
          @flag int,
          @meth int
  EXECUTE @flag = sp_OACreate 'WinHttp.WinHttpRequest.5.1', @meth OUT
  IF @flag <> 0
     EXECUTE @flag = sp_OAGetErrorInfo @meth, @stat OUT, @note OUT
  IF @flag =  0
     SELECT @stat = ISNULL(@stat, ''),
            @note = ISNULL(@note, '')
  SELECT @resp = @stat + @note
  IF @resp = '' BEGIN
     EXECUTE @flag = sp_OAMethod @meth, 'Open', NULL, 'GET', @lock, 'false'
     IF @flag <> 0
        EXECUTE @flag = sp_OAGetErrorInfo @meth, @stat OUT, @note OUT
     IF @flag =  0
        SELECT @stat = ISNULL(@stat, ''),
               @note = ISNULL(@note, '')
     SELECT @resp = @stat + @note
     IF @resp = '' BEGIN
        EXECUTE @flag = sp_OAMethod @meth, 'Send'
        IF @flag <> 0
           EXECUTE @flag = sp_OAGetErrorInfo @meth, @stat OUT, @note OUT
        IF @flag =  0
           SELECT @stat = ISNULL(@stat, ''),
                  @note = ISNULL(@note, '')
        SELECT @resp = @stat + @note
        IF @resp = '' BEGIN
           EXECUTE @flag = sp_OAGetProperty @meth, 'ResponseText', @resp OUTPUT
           IF @flag <> 0
              EXECUTE @flag = sp_OAGetErrorInfo @meth, @stat OUT, @note OUT
           IF @flag =  0
              SELECT @stat = ISNULL(@stat, ''),
                     @note = ISNULL(@note, '')
           EXECUTE @flag = sp_OADestroy @meth
           SELECT  @resp = @resp + @stat + @note
        END
     END
  END
  RETURN @RESP
END;
