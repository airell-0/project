CREATE FUNCTION [dbo].[sf_data_book](
  @date AS datetime = '1900-01-01',
  @book AS int      = 0
) RETURNS varchar(max) AS BEGIN
  SELECT @date = CONVERT(datetime,
    CASE WHEN GETDATE() > CONVERT(datetime, CONVERT(varchar(7),
         DATEADD(MONTH, 1, @date), 120) +'-'+ RIGHT('00'+ CONVERT(varchar(2), @book), 2))
    THEN CONVERT(varchar(10), GETDATE(), 120)
    ELSE CONVERT(varchar(10), @date, 120) END)
  RETURN @date
END;
