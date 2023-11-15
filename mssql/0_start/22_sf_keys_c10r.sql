CREATE FUNCTION [dbo].[sf_keys_c10r](
  @text AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @alpa varchar(max),
          @date varchar(max),
          @resp varchar(max)
  SELECT  @text = [dbo].[sf_data_code](@text),
          @alpa = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          @date = [dbo].[sf_data_date]()
  SELECT  @resp =
    SUBSTRING(@text, 1, 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date, 12, 1)) +
      CONVERT(int, SUBSTRING(@date, 14, 1)) +
      CONVERT(int, SUBSTRING(@date, 16, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date,  1, 1)) +
      CONVERT(int, SUBSTRING(@date,  8, 1)) +
      CONVERT(int, SUBSTRING(@date,  4, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date,  2, 1)) +
      CONVERT(int, SUBSTRING(@date,  7, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date,  3, 1)) +
      CONVERT(int, SUBSTRING(@date,  6, 1)) +
      CONVERT(int, SUBSTRING(@date,  5, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date,  9, 1)) +
      CONVERT(int, SUBSTRING(@date, 10, 1)) +
      CONVERT(int, SUBSTRING(@date, 11, 1)), 1) +
    SUBSTRING(@alpa, 1 +
      CONVERT(int, SUBSTRING(@date, 13, 1)) +
      CONVERT(int, SUBSTRING(@date, 15, 1)) +
      CONVERT(int, SUBSTRING(@date, 17, 1)), 1) +
    SUBSTRING(@text, LEN(@text), 1)
  RETURN @resp
END;
