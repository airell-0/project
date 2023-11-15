CREATE FUNCTION [dbo].[sf_keys_attr](
  @text AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @open int, @stop int, @last int
  SELECT  @text = REPLACE(REPLACE(@text,'<',' <'),'>','> ')
  SELECT  @open = CHARINDEX('<', @text)
  SELECT  @stop = CHARINDEX('>', @text, @open)
  SELECT  @last = (@stop - @open) + 1
  WHILE   @open > 0 AND @stop > 0 AND @last > 0 BEGIN
    SELECT @text = STUFF(@text, @open, @last, '')
    SELECT @open = CHARINDEX('<', @text)
    SELECT @stop = CHARINDEX('>', @text, @open)
    SELECT @last = (@stop - @open) + 1
  END
  SELECT @open = CHARINDEX('&', @text)
  SELECT @stop = CHARINDEX(';', @text, @open)
  SELECT @last = (@stop - @open) + 1
  WHILE  @open > 0 AND @stop > 0 AND @last > 0 BEGIN
    SELECT @text = STUFF(@text, @open, @last, '')
    SELECT @open = CHARINDEX('&', @text)
    SELECT @stop = CHARINDEX(';', @text, @open)
    SELECT @last = (@stop - @open) + 1
  END
  SELECT @text = REPLACE(LTRIM(RTRIM(@text)),' ','<>')
  SELECT @text = REPLACE(REPLACE(@text,'><',''),'<>',' ')
  SELECT @text = [dbo].[sf_data_text](@text, 0)
  RETURN @text
END;
