CREATE FUNCTION [dbo].[sf_idr_text](
  @value AS float = 0
) RETURNS nvarchar(4000) AS BEGIN
  DECLARE @_P int,
          @_L int,
          @_W nvarchar(MAX),
          @_E nvarchar(MAX),
          @SN nvarchar(MAX),
          @SF nvarchar(MAX),
          @SB nvarchar(MAX),
          @_C nvarchar(1),
          @CA nvarchar(1),
          @C1 nvarchar(1),
          @C2 nvarchar(1)
  SELECT  @SN = STR(CONVERT(decimal(32, 4), @value), 32, 2)
  SELECT  @SN = LTRIM(RTRIM(@SN))
  SELECT  @SF = SUBSTRING(@SN, 0, (SELECT CHARINDEX('.', @SN, 1)))
  SELECT  @SB = SUBSTRING(@SN, (SELECT CHARINDEX('.', @SN, 1) + 1), LEN(@SN))
  SELECT  @_L = LEN(@SF)
  SELECT  @_P = @_L
  SELECT  @_W = ''
  WHILE  (@_P > 0) BEGIN
    SELECT @_C = SUBSTRING(@SN, @_L + 1- @_P, 1)
    SELECT @CA = SUBSTRING(@SN, @_L + 2- @_P, 1)
    SELECT @C1 = SUBSTRING(@SN, @_L - @_P, 1)
    SELECT @C2 = SUBSTRING(@SN, @_L - @_P - 1, 1)
    IF ((@_C = '1') AND ((SELECT (@_P - 1) / 3.0) = 1) AND (@CA != '') AND ((SELECT CAST(@C1 AS int)) = 0))
       SELECT @_W = @_W +'Se'
    ELSE BEGIN
       IF ((@_C = '1') AND ((SELECT @_P % 3) = 1))
          SELECT @_W = @_W + 'Satu '
       ELSE BEGIN
          IF ((@_C = '1') AND ((SELECT CAST(@CA AS int)) > 1) AND ((SELECT @_P % 3) = 2)) BEGIN
                  IF (@CA = '1') SELECT @_W = @_W +'Se'
             ELSE IF (@CA = '2') SELECT @_W = @_W +'Dua '
             ELSE IF (@CA = '3') SELECT @_W = @_W +'Tiga '
             ELSE IF (@CA = '4') SELECT @_W = @_W +'Empat '
             ELSE IF (@CA = '5') SELECT @_W = @_W +'Lima '
             ELSE IF (@CA = '6') SELECT @_W = @_W +'Enam '
             ELSE IF (@CA = '7') SELECT @_W = @_W +'Tujuh '
             ELSE IF (@CA = '8') SELECT @_W = @_W +'Delapan '
             ELSE IF (@CA = '9') SELECT @_W = @_W +'Sembilan '
          END ELSE BEGIN
                  IF (@_C = '1') SELECT @_W = @_W +'Se'
             ELSE IF (@_C = '2') SELECT @_W = @_W +'Dua '
             ELSE IF (@_C = '3') SELECT @_W = @_W +'Tiga '
             ELSE IF (@_C = '4') SELECT @_W = @_W +'Empat '
             ELSE IF (@_C = '5') SELECT @_W = @_W +'Lima '
             ELSE IF (@_C = '6') SELECT @_W = @_W +'Enam '
             ELSE IF (@_C = '7') SELECT @_W = @_W +'Tujuh '
             ELSE IF (@_C = '8') SELECT @_W = @_W +'Delapan '
             ELSE IF (@_C = '9') SELECT @_W = @_W +'Sembilan '
             ELSE BEGIN
                IF ((@_C = '0') AND ((SELECT CAST(@C1 AS int)) > 1) AND ((SELECT @_P % 3) = 1))
                   SELECT @_W = @_W
                ELSE BEGIN
                   IF ((@_C = '0') AND ((SELECT @C1) = '0') AND ((SELECT CAST(@C2 AS int)) > 0) AND ((SELECT @_P % 3) = 1))
                      SELECT @_W = @_W
                   ELSE BEGIN
                      IF (@_C = '0') SELECT @_P = @_P - 1 CONTINUE
                   END
                END
             END
          END
       END
    END
    IF ((SELECT @_P % 3) = 0)
       SELECT @_W = CASE WHEN RIGHT(@_W, 2) = 'Se' THEN @_W +'ratus ' ELSE @_W +'Ratus ' END
    ELSE BEGIN
       IF (((SELECT @_P % 3) = 2) AND ((SELECT CAST(@_C AS int)) > 1))
          SELECT @_W = CASE WHEN RIGHT(@_W, 2) = 'Se' THEN @_W +'puluh ' ELSE @_W +'Puluh ' END
       ELSE BEGIN
          IF (((SELECT @_P % 3) = 2) AND ((SELECT CAST(@_C AS int)) = 1) AND ((SELECT CAST(@CA AS int)) > 0)) BEGIN
             SELECT @_W = CASE WHEN RIGHT(@_W, 2) = 'Se' THEN @_W +'belas ' ELSE @_W +'Belas ' END
             SELECT @_P = @_P - 1
          END ELSE BEGIN
             IF (((SELECT @_P % 3) = 2) AND ((SELECT CAST(@_C AS int)) = 1) AND ((SELECT CAST(@CA AS int)) = 0)) BEGIN
                SELECT @_W = CASE WHEN RIGHT(@_W, 2) = 'Se' THEN @_W +'puluh ' ELSE @_W +'Puluh ' END
                SELECT @_P = @_P - 1
             END
          END
       END
    END
    IF ((SELECT (@_P - 1) / 3.0) = 1)
       SELECT @_W = @_W +'Ribu '
    ELSE BEGIN
       IF ((SELECT (@_P - 1) / 3.0) = 2)
          SELECT @_W = @_W +'Juta '
       ELSE BEGIN
          IF ((SELECT (@_P - 1) / 3.0) = 3)
             SELECT @_W = @_W +'Milyar '
          ELSE BEGIN
             IF ((SELECT (@_P - 1) / 3.0) = 4)
                SELECT @_W = @_W +'Triliun '
          END
       END
    END
    SELECT @_P = @_P - 1
  END
  IF ((SELECT CAST(REPLACE(@SB, '.','') AS int)) > 0) BEGIN
     SELECT @_W = @_W +'Koma '
     SELECT @_L = LEN(@SB)
     SELECT @_P = @_L
     WHILE (@_P > 0) BEGIN
       SELECT @_C  = SUBSTRING(@SB, @_L + 1 - @_P, 1)
       SELECT @_W = @_W + (CASE @_C
         WHEN '0' THEN 'Nol '
         WHEN '1' THEN 'Satu '
         WHEN '2' THEN 'Dua '
         WHEN '3' THEN 'Tiga '
         WHEN '4' THEN 'Empat '
         WHEN '5' THEN 'Lima '
         WHEN '6' THEN 'Enam '
         WHEN '7' THEN 'Tujuh '
         WHEN '8' THEN 'Delapan '
         WHEN '9' THEN 'Sembilan '
         ELSE '' END)
       SELECT @_P = @_P - 1
     END
  END
  SELECT @_W = LTRIM(RTRIM(@_W))
  IF LEN(@_W) > 0 SET @_W = UPPER(LEFT(@_W, 1)) + RIGHT(@_W, LEN(@_W) - 1)
  RETURN @_W
END;
