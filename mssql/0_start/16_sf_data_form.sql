CREATE FUNCTION [dbo].[sf_data_form](
  @text AS varchar(max) = '',
  @leng AS bigint       = 0,
  @last AS bigint       = 0
) RETURNS varchar(max) AS BEGIN
  DECLARE @numb varchar(max),
          @open int,
          @stop int
  SELECT  @numb = '0',
          @open = 1,
          @stop = @leng - LEN(@text)
  WHILE @open < @stop BEGIN
    SELECT @numb = @numb +'0',
           @open = @open + 1
  END
  SELECT @numb = RIGHT(@numb + CONVERT(varchar(max), @last), @stop)
  RETURN @text + @numb
END;
