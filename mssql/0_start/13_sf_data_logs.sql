CREATE FUNCTION [dbo].[sf_data_logs](
) RETURNS varchar(max) AS BEGIN
  DECLARE @text varchar(max)
  SELECT  @text =
    'E-N.'+ [dbo].[sf_data_text](CONVERT(varchar(max), ISNULL(ERROR_NUMBER(),   0)), 0)
    +'-V.'+ [dbo].[sf_data_text](CONVERT(varchar(max), ISNULL(ERROR_SEVERITY(), 0)), 0)
    +'-S.'+ [dbo].[sf_data_text](CONVERT(varchar(max), ISNULL(ERROR_STATE(),    0)), 0)
    +'-L.'+ [dbo].[sf_data_text](CONVERT(varchar(max), ISNULL(ERROR_LINE(),     0)), 0)
    + ISNULL(NULLIF(' ['+ [dbo].[sf_data_text](ERROR_MESSAGE(), 0)   +']', +' []'),'')
    + ISNULL(NULLIF(' <'+ [dbo].[sf_data_text](ERROR_PROCEDURE(), 0) +'>', +' <>'),'')
    +'-X.'+ [dbo].[sf_data_info]()
  RETURN  @text
END;
