CREATE FUNCTION [dbo].[sf_data_date](
) RETURNS varchar(max) AS BEGIN
  DECLARE @text varchar(max)
  SELECT  @text = REPLACE(CONVERT(varchar(max), GETDATE(), 121),'-','')
  SELECT  @text = REPLACE(REPLACE(REPLACE(@text,' ',''),':',''),'.','')
  RETURN  @text
END;
