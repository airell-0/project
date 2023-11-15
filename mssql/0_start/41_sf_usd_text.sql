CREATE FUNCTION [dbo].[sf_usd_text](
  @value numeric(38, 3)
) RETURNS nvarchar(4000) AS BEGIN
  DECLARE @DECIM numeric(38, 0),
          @CENTS int
  SET     @DECIM = @value
  SET     @CENTS = 100 * CONVERT(money, (@value - CONVERT(numeric(38, 3), @DECIM)))
  DECLARE @inputNumber  varchar(38)
  DECLARE @NumbersTable TABLE(number CHAR(2), word varchar(10))
  DECLARE @outputString varchar(8000)
  DECLARE @length       int
  DECLARE @counter      int
  DECLARE @loops        int
  DECLARE @position     int
  DECLARE @chunk        char(3)
  DECLARE @tensones     char(2)
  DECLARE @hundreds     char(1)
  DECLARE @tens         char(1)
  DECLARE @ones         char(1)
  IF @DECIM = 0 RETURN 'Zero'
  SELECT @inputNumber  = CONVERT(varchar(38), @DECIM),
         @outputString = '',
         @counter      = 1
  SELECT @length       = LEN(@inputNumber),
         @position     = LEN(@inputNumber) - 2,
         @loops        = LEN(@inputNumber) / 3
  IF LEN(@inputNumber) % 3 <> 0 SET @loops = @loops + 1
  INSERT INTO @NumbersTable
            SELECT '00', ''         UNION ALL SELECT '01', 'one'
  UNION ALL SELECT '02', 'two'      UNION ALL SELECT '03', 'three'
  UNION ALL SELECT '04', 'four'     UNION ALL SELECT '05', 'five'
  UNION ALL SELECT '06', 'six'      UNION ALL SELECT '07', 'seven'
  UNION ALL SELECT '08', 'eight'    UNION ALL SELECT '09', 'nine'
  UNION ALL SELECT '10', 'ten'      UNION ALL SELECT '11', 'eleven'
  UNION ALL SELECT '12', 'twelve'   UNION ALL SELECT '13', 'thirteen'
  UNION ALL SELECT '14', 'fourteen' UNION ALL SELECT '15', 'fifteen'
  UNION ALL SELECT '16', 'sixteen'  UNION ALL SELECT '17', 'seventeen'
  UNION ALL SELECT '18', 'eighteen' UNION ALL SELECT '19', 'nineteen'
  UNION ALL SELECT '20', 'twenty'   UNION ALL SELECT '30', 'thirty'
  UNION ALL SELECT '40', 'forty'    UNION ALL SELECT '50', 'fifty'
  UNION ALL SELECT '60', 'sixty'    UNION ALL SELECT '70', 'seventy'
  UNION ALL SELECT '80', 'eighty'   UNION ALL SELECT '90', 'ninety'
  WHILE @counter <= @loops BEGIN
    SET @chunk = RIGHT('000' + SUBSTRING(@inputNumber, @position, 3), 3)
    IF @chunk <> '000' BEGIN
       SELECT @tensones = SUBSTRING(@chunk, 2, 2),
              @hundreds = SUBSTRING(@chunk, 1, 1),
              @tens     = SUBSTRING(@chunk, 2, 1),
              @ones     = SUBSTRING(@chunk, 3, 1)
       IF CONVERT(INT, @tensones) <= 20 OR @Ones = '0' BEGIN
          SET @outputString = (SELECT word FROM @NumbersTable WHERE @tensones = number)
            + CASE @counter
              WHEN  1 THEN ''              WHEN  2 THEN ' thousand '
              WHEN  3 THEN ' million '     WHEN  4 THEN ' billion '
              WHEN  5 THEN ' trillion '    WHEN  6 THEN ' quadrillion '
              WHEN  7 THEN ' quintillion ' WHEN  8 THEN ' sextillion '
              WHEN  9 THEN ' septillion '  WHEN 10 THEN ' octillion '
              WHEN 11 THEN ' nonillion '   WHEN 12 THEN ' decillion '
              WHEN 13 THEN ' undecillion ' ELSE '' END
            + @outputString
       END ELSE BEGIN
          SET @outputString = ' '+ (SELECT word FROM @NumbersTable WHERE @tens + '0' = number)
            + '-'+ (SELECT word FROM @NumbersTable WHERE '0'+ @ones = number)
            + CASE @counter
              WHEN  1 THEN ''              WHEN  2 THEN ' thousand '
              WHEN  3 THEN ' million '     WHEN  4 THEN ' billion '
              WHEN  5 THEN ' trillion '    WHEN  6 THEN ' quadrillion '
              WHEN  7 THEN ' quintillion ' WHEN  8 THEN ' sextillion '
              WHEN  9 THEN ' septillion '  WHEN 10 THEN ' octillion '
              WHEN 11 THEN ' nonillion '   WHEN 12 THEN ' decillion '
              WHEN 13 THEN ' undecillion ' ELSE '' END
            + @outputString
       END
       IF @hundreds <> '0' BEGIN
          SET @outputString = (SELECT word FROM @NumbersTable WHERE '0' + @hundreds = number)
            + ' hundred '
            + @outputString
       END
    END
    SELECT @counter  = @counter + 1,
           @position = @position - 3
  END
  SET @outputString = LTRIM(RTRIM(REPLACE(@outputString, '  ', ' ')))
  SET @outputstring = UPPER(LEFT(@outputstring, 1)) + SUBSTRING(@outputstring, 2, 8000)
  RETURN UPPER(@outputString) + ' DOLLARS & ' + CONVERT(varchar(20), @CENTS) +'/100 CENTS'
END;
