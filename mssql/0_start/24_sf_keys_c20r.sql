CREATE FUNCTION [dbo].[sf_keys_c20r](
  @text AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @alpa varchar(max),
          @date varchar(max),
          @resp varchar(max)
  SELECT  @text = [dbo].[sf_data_code](@text),
          @date = [dbo].[sf_data_date](),
          @alpa = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  SELECT  @resp =
    SUBSTRING(@text, 1, 1) + SUBSTRING(@text, 3, 1) + SUBSTRING(@text, 5, 1) +
    SUBSTRING(@text, 7, 1) +'-'+
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date, 1, 1)) +
      CONVERT(int, SUBSTRING(@date, 8, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date, 2, 1)) +
      CONVERT(int, SUBSTRING(@date, 7, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date, 3, 1)) +
      CONVERT(int, SUBSTRING(@date, 6, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date, 4, 1)) +
      CONVERT(int, SUBSTRING(@date, 5, 1)), 1) +'-'+
    SUBSTRING(@text, LEN(@text) - 7, 1) +
    SUBSTRING(@text, LEN(@text) - 5, 1) +
    SUBSTRING(@text, LEN(@text) - 3, 1) +
    SUBSTRING(@text, LEN(@text), 1)
  RETURN @resp
END;
