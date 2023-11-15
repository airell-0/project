CREATE FUNCTION [dbo].[sf_tabs_raws](
  @text AS varchar(max) = '',
  @raws AS varchar(20)  = ''
) RETURNS @tabs TABLE ([VALS] varchar(max)) AS BEGIN
  DECLARE @loop int,
          @flag varchar(max)
  SET     @text = RTRIM(LTRIM(@text))
  SET     @loop = 1
  WHILE   @loop <= LEN(@text) BEGIN
    IF CHARINDEX(@raws, @text, 1) <> 0 BEGIN
       SET @flag = SUBSTRING(@text, 1, CHARINDEX(@raws, @text, 1) -1)
       SET @text = SUBSTRING(@text, LEN(LTRIM(RTRIM(@flag)) + @raws) + 1, 1000000)
       INSERT INTO @tabs
       SELECT @flag
    END ELSE BEGIN
       INSERT INTO @tabs
       SELECT @text
       BREAK
    END
  END RETURN
END;
