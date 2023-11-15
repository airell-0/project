CREATE FUNCTION [dbo].[sf_keys_c20p](
  @text AS varchar(max) = '',
  @pass AS varchar(max) = ''
) RETURNS varchar(max) AS BEGIN
  DECLARE @resp varchar(max)
  SELECT  @text = [dbo].[sf_keys_c20r](@text),
          @resp = 'error'
  IF @text = @pass
     SELECT @resp = 'valid'
  RETURN @resp
END;
