CREATE FUNCTION [dbo].[sf_data_uniq](
) RETURNS varchar(max) AS BEGIN
  DECLARE @text varchar(max)
  SELECT  @text = [dbo].[sf_data_date]()
  SELECT  @text = [dbo].[sf_data_code](@text)
  RETURN  @text
END;
