CREATE FUNCTION [dbo].[sf_keys_c10p](
  @text AS varchar(max) = '',
  @pass AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @resp varchar(max)
  SELECT  @text = [dbo].[sf_keys_c10r](@text),
          @resp = 'error'
  SELECT  @text = SUBSTRING(@text, 1, 1) + SUBSTRING(@text, 3, 4) + SUBSTRING(@text, 8, 1),
          @pass = SUBSTRING(@pass, 1, 1) + SUBSTRING(@pass, 3, 4) + SUBSTRING(@pass, 8, 1)
  IF @text = @pass
     SELECT @resp = 'valid'
  RETURN @resp
END;
