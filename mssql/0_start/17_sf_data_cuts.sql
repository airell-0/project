CREATE FUNCTION [dbo].[sf_data_cuts](
  @text AS varchar(max) = '',
  @cuts AS varchar(max) = '',
  @lock AS int          = 0
) RETURNS varchar(max) AS BEGIN
  DECLARE @flag int
  IF @lock = 0
     RETURN (LEFT(@text, CHARINDEX(@cuts, @text) - 1))
  SELECT @flag = 0
  WHILE  @flag < @lock BEGIN
    IF (CHARINDEX(@cuts, @text) <> 0)
         SELECT @text = SUBSTRING(@text, CHARINDEX(@cuts, @text) + 1, LEN(@text))
    ELSE SELECT @text = ''
    SELECT @flag = @flag + 1
  END
  IF CHARINDEX(@cuts, @text) != 0
     SELECT @text = LEFT(@text, CHARINDEX(@cuts, @text) - 1)
  RETURN (@text)
END;
