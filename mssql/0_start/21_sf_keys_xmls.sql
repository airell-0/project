CREATE FUNCTION [dbo].[sf_keys_xmls](
  @text AS varchar(max) = '',
  @attr AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @open int,
          @stop int
  SELECT  @open = CHARINDEX('<'+  @attr +'>', @text),
          @stop = CHARINDEX('</'+ @attr +'>', @text)
  SELECT  @text = SUBSTRING(@text, @open, @stop - @open + LEN('</'+ @attr +'>'))
  SELECT  @text = REPLACE(REPLACE(@text, '<'+ @attr +'>',''),'</'+ @attr +'>','')
  RETURN  @text
END;
