CREATE FUNCTION [dbo].[sf_data_text](
  @form AS varchar(max) = '',
  @type AS int          = 0
) RETURNS varchar(max) AS BEGIN
  IF @form IS NULL SELECT @form = ''
  DECLARE @leng int,
          @resp varchar(max),
          @poin int,
          @char int
  SELECT  @form = REPLACE(@form, CHAR(13),' ')
  SELECT  @form = REPLACE(@form, CHAR(10),' ')
  SELECT  @form = REPLACE(@form, CHAR(9), ' ')
  SELECT  @leng = LEN(@form),
          @resp = '',
          @poin = 1
  WHILE @poin <= @leng BEGIN
    SELECT @char = ASCII(SUBSTRING(@form, @poin, 1))
    IF @char BETWEEN 32 AND 126 BEGIN
            IF @char = 39 SELECT @resp = @resp +'`'
       ELSE IF @char = 92 SELECT @resp = @resp +'^'
       ELSE SELECT @resp = @resp + ISNULL(CHAR(@char),'')
    END
    SELECT @poin = @poin + 1
  END
  SELECT @resp = RTRIM(LTRIM(REPLACE(@resp,'"','^')))
  WHILE CHARINDEX('  ', @resp) > 0 BEGIN
    SELECT @resp = REPLACE(@resp, '  ',' ')
  END
  IF LEN(@resp) = 0 AND @type = 0 SELECT @resp = ''
  IF LEN(@resp) = 0 AND @type = 1 SELECT @resp = '0'
  IF LEN(@resp) = 0 AND @type = 2 SELECT @resp = '1900-01-01'
  IF @type = 1 AND ISNUMERIC(@resp) = 0 SELECT @resp = '0'
  IF @type = 2 AND ISDATE(@resp)    = 0 SELECT @resp = '1900-01-01'
  IF @type = 3 SELECT @resp = REPLACE(REPLACE(@resp,'<?xml versi',''),'/',' ')
  RETURN @resp
END;
