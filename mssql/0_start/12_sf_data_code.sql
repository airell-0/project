CREATE FUNCTION [dbo].[sf_data_code](
  @text AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @bins varbinary(max),
          @hash char(16),
          @leng int,
          @flag int,
          @tint int,
          @char int,
          @line int
  SELECT  @bins = HashBytes('MD5', [dbo].[sf_data_form](@text, 0))
  SELECT  @leng = DATALENGTH(@bins),
          @hash = '0123456789ABCDEF',
          @flag = 0
  IF ((DATALENGTH(@bins) - 1 + 1) < @leng)
     SELECT @leng = DATALENGTH(@bins) - 1 + 1
  SELECT @text = ''
  WHILE (@flag < @leng) BEGIN
    SELECT @tint = CAST(SUBSTRING(@bins, @flag + 1, 1) AS int)
    SELECT @char = @tint / 16, @line = @tint % 16
    SELECT @text = @text +
      CAST(SUBSTRING(@hash, (@char + 1), 1) AS nvarchar) +
      CAST(SUBSTRING(@hash, (@line + 1), 1) AS nvarchar)
    SELECT @flag = @flag + 1
  END
  RETURN @text
END;
