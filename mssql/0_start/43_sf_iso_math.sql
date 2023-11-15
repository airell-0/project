CREATE FUNCTION [dbo].[sf_iso_math](
  @text AS varchar(100) = ''
) RETURNS nvarchar(max) AS BEGIN
  DECLARE @flag int
  SELECT  @flag = LEN(@text)
  IF @flag = 16 BEGIN
     SELECT @text =
            [dbo].[sf_iso_byte](LEFT(@text, 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  2), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  3), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  4), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  5), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  6), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  7), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  8), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  9), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 10), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 11), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 12), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 13), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 14), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 15), 1)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 16), 1))
  END ELSE IF @flag = 64 BEGIN
     SELECT @text =
            [dbo].[sf_iso_byte](LEFT(@text, 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  4), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text,  8), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 12), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 16), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 20), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 24), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 28), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 32), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 36), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 40), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 44), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 48), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 52), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 56), 4)) +
            [dbo].[sf_iso_byte](RIGHT(LEFT(@text, 60), 4))
  END ELSE BEGIN
     SELECT @text = ''
  END
  RETURN @text
END;
