CREATE FUNCTION [dbo].[sf_tabs_ce30](
  @text AS varchar(max) = ''
) RETURNS @tabs TABLE (
  [IDX] int NOT NULL PRIMARY KEY CLUSTERED,
  [F01] varchar(max), [F02] varchar(max), [F03] varchar(max), [F04] varchar(max), [F05] varchar(max),
  [F06] varchar(max), [F07] varchar(max), [F08] varchar(max), [F09] varchar(max), [F10] varchar(max),
  [F11] varchar(max), [F12] varchar(max), [F13] varchar(max), [F14] varchar(max), [F15] varchar(max),
  [F16] varchar(max), [F17] varchar(max), [F18] varchar(max), [F19] varchar(max), [F20] varchar(max),
  [F21] varchar(max), [F22] varchar(max), [F23] varchar(max), [F24] varchar(max), [F25] varchar(max),
  [F26] varchar(max), [F27] varchar(max), [F28] varchar(max), [F29] varchar(max), [F30] varchar(max)
) AS BEGIN 
  DECLARE @read varchar(max),
          @line varchar(max),
          @rows int,
          @cols int
  SET     @rows = 0
  DECLARE CRR CURSOR FOR
  SELECT  [VALS] FROM [dbo].[sf_tabs_raws](@text, '|^|')
  OPEN CRR
  FETCH NEXT FROM CRR INTO @read
  WHILE @@FETCH_STATUS = 0 BEGIN
    SET     @rows = @rows + 1
    INSERT  INTO @tabs ([IDX])
    SELECT  @rows
    SET     @cols = 0
    DECLARE CRR_INLINE CURSOR FOR
    SELECT  [VALS] FROM [dbo].[sf_tabs_raws](@read, '->')
    OPEN CRR_INLINE
    FETCH NEXT FROM CRR_INLINE INTO @line
    WHILE @@FETCH_STATUS = 0
    BEGIN
      SET @cols = @cols + 1
       IF @cols =  1 UPDATE @tabs SET [F01] = @line WHERE [IDX] = @rows
       IF @cols =  2 UPDATE @tabs SET [F02] = @line WHERE [IDX] = @rows
       IF @cols =  3 UPDATE @tabs SET [F03] = @line WHERE [IDX] = @rows
       IF @cols =  4 UPDATE @tabs SET [F04] = @line WHERE [IDX] = @rows
       IF @cols =  5 UPDATE @tabs SET [F05] = @line WHERE [IDX] = @rows
       IF @cols =  6 UPDATE @tabs SET [F06] = @line WHERE [IDX] = @rows
       IF @cols =  7 UPDATE @tabs SET [F07] = @line WHERE [IDX] = @rows
       IF @cols =  8 UPDATE @tabs SET [F08] = @line WHERE [IDX] = @rows
       IF @cols =  9 UPDATE @tabs SET [F09] = @line WHERE [IDX] = @rows
       IF @cols = 10 UPDATE @tabs SET [F10] = @line WHERE [IDX] = @rows
       IF @cols = 11 UPDATE @tabs SET [F11] = @line WHERE [IDX] = @rows
       IF @cols = 12 UPDATE @tabs SET [F12] = @line WHERE [IDX] = @rows
       IF @cols = 13 UPDATE @tabs SET [F13] = @line WHERE [IDX] = @rows
       IF @cols = 14 UPDATE @tabs SET [F14] = @line WHERE [IDX] = @rows
       IF @cols = 15 UPDATE @tabs SET [F15] = @line WHERE [IDX] = @rows
       IF @cols = 16 UPDATE @tabs SET [F16] = @line WHERE [IDX] = @rows
       IF @cols = 17 UPDATE @tabs SET [F17] = @line WHERE [IDX] = @rows
       IF @cols = 18 UPDATE @tabs SET [F18] = @line WHERE [IDX] = @rows
       IF @cols = 19 UPDATE @tabs SET [F19] = @line WHERE [IDX] = @rows
       IF @cols = 20 UPDATE @tabs SET [F20] = @line WHERE [IDX] = @rows
       IF @cols = 21 UPDATE @tabs SET [F21] = @line WHERE [IDX] = @rows
       IF @cols = 22 UPDATE @tabs SET [F22] = @line WHERE [IDX] = @rows
       IF @cols = 23 UPDATE @tabs SET [F23] = @line WHERE [IDX] = @rows
       IF @cols = 24 UPDATE @tabs SET [F24] = @line WHERE [IDX] = @rows
       IF @cols = 25 UPDATE @tabs SET [F25] = @line WHERE [IDX] = @rows
       IF @cols = 26 UPDATE @tabs SET [F26] = @line WHERE [IDX] = @rows
       IF @cols = 27 UPDATE @tabs SET [F27] = @line WHERE [IDX] = @rows
       IF @cols = 28 UPDATE @tabs SET [F28] = @line WHERE [IDX] = @rows
       IF @cols = 29 UPDATE @tabs SET [F29] = @line WHERE [IDX] = @rows
       IF @cols = 30 UPDATE @tabs SET [F30] = @line WHERE [IDX] = @rows
      FETCH NEXT FROM CRR_INLINE INTO @line
    END
    CLOSE CRR_INLINE
    DEALLOCATE CRR_INLINE
    FETCH NEXT FROM CRR INTO @read
  END
  CLOSE CRR
  DEALLOCATE CRR
  RETURN
END;
