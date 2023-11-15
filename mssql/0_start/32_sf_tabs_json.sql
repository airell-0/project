CREATE FUNCTION [dbo].[sf_tabs_json](
  @json AS nvarchar(max) = ''
) RETURNS @hierarchy TABLE (
  Element_ID  int IDENTITY(1, 1) NOT NULL,
  SequenceNo  int                    NULL,
  Parent_ID   int                    NULL,
  Object_ID   int                    NULL,
  Name        nvarchar(2000)         NULL,
  StringValue nvarchar(MAX)      NOT NULL,
  ValueType   varchar(10)        NOT NULL
) AS BEGIN
  DECLARE @FirstObject            int,
          @OpenDelimiter          int,
          @NextOpenDelimiter      int,
          @NextCloseDelimiter     int,
          @Type                   nvarchar(10),
          @NextCloseDelimiterChar char(1),
          @Contents               nvarchar(MAX),
          @Start                  int,
          @end                    int,
          @param                  int,
          @EndOfName              int,
          @token                  nvarchar(200),
          @value                  nvarchar(MAX),
          @SequenceNo             int,
          @Name                   nvarchar(200),
          @Parent_ID              int,
          @lenJSON                int,
          @characters             nchar(36),
          @result                 bigint,
          @index                  smallint,
          @Escape                 int
  DECLARE @Strings TABLE (
    String_ID   int IDENTITY(1, 1),
    StringValue nvarchar(MAX)
  )
  SELECT @characters = '0123456789abcdefghijklmnopqrstuvwxyz',
         @SequenceNo = 0,
         @Parent_ID  = 0;
  WHILE 1 = 1 BEGIN
    SELECT @start = PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);
    IF @start = 0 BREAK
    IF SUBSTRING(@json, @start + 1, 1) = '"' BEGIN
       SET @start = @Start + 1;
       SET @end   = PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json + '|') - @start) collate SQL_Latin1_General_CP850_Bin);
    END
    IF @end = 0 BEGIN
       SET @end = PATINDEX('%[\][\]["]%', RIGHT(@json, LEN(@json + '|') - @start) collate SQL_Latin1_General_CP850_Bin);
       IF  @end = 0 BEGIN
           BREAK
       END
    END
    SELECT @token = SUBSTRING(@json, @start + 1, @end - 1)
    SELECT @token = REPLACE(@token, FromString, ToString)
    FROM (
      SELECT '\b', CHAR(08) UNION ALL
      SELECT '\f', CHAR(12) UNION ALL
      SELECT '\n', CHAR(10) UNION ALL
      SELECT '\r', CHAR(13) UNION ALL
      SELECT '\t', CHAR(09) UNION ALL
      SELECT '\"', '"'      UNION ALL
      SELECT '\/', '/'
    ) substitutions(FromString, ToString)
    SELECT @token  = Replace(@token, '\\', '\') -- '
    SELECT @result = 0, @escape = 1
    WHILE @escape > 0 BEGIN
      SELECT @index  = 0,
             @escape = PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
      IF @escape > 0 BEGIN
         WHILE @index < 4 BEGIN
            SELECT @result = @result + POWER(16, @index) * (CHARINDEX(SUBSTRING(@token, @escape + 2 + 3 - @index, 1), @characters) - 1),
                   @index  = @index + 1;
         END
         SELECT @token = STUFF(@token, @escape, 6, NCHAR(@result))
      END
    END
    INSERT INTO @Strings (StringValue)
    SELECT @token
    SELECT @json = STUFF(@json, @start, @end + 1, '@string'+ CONVERT(NCHAR(5), @@identity))
  END
  WHILE 1 = 1 BEGIN
    SELECT @Parent_ID   = @Parent_ID + 1
    SELECT @FirstObject = PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)
    IF @FirstObject = 0
       BREAK
    IF (SUBSTRING(@json, @FirstObject, 1) = '{')
       SELECT @NextCloseDelimiterChar = '}', @type='object'
    ELSE
       SELECT @NextCloseDelimiterChar = ']', @type='array'
    SELECT @OpenDelimiter = @firstObject
    WHILE 1 = 1 BEGIN
      SELECT @lenJSON            = LEN(@json + '|') - 1
      SELECT @NextCloseDelimiter = CHARINDEX(@NextCloseDelimiterChar, @json, @OpenDelimiter + 1)
      SELECT @NextOpenDelimiter  = PATINDEX('%[{[[]%', RIGHT(@json, @lenJSON - @OpenDelimiter) collate SQL_Latin1_General_CP850_Bin)
      IF @NextOpenDelimiter = 0
         BREAK
      SELECT @NextOpenDelimiter = @NextOpenDelimiter + @OpenDelimiter
      IF @NextCloseDelimiter < @NextOpenDelimiter
         BREAK
      IF SUBSTRING(@json, @NextOpenDelimiter, 1) = '{'
         SELECT @NextCloseDelimiterChar = '}', @type = 'object'
      ELSE
         SELECT @NextCloseDelimiterChar = ']', @type = 'array'
      SELECT @OpenDelimiter = @NextOpenDelimiter
    END
    SELECT @contents = SUBSTRING(@json, @OpenDelimiter + 1, @NextCloseDelimiter - @OpenDelimiter - 1)
    SELECT @json = STUFF(@json, @OpenDelimiter, @NextCloseDelimiter - @OpenDelimiter + 1, '@'+ @type + CONVERT(NCHAR(5), @Parent_ID))
    WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin)) <> 0 BEGIN
      IF @Type = 'object' BEGIN
         SELECT @SequenceNo = 0,
                @end        = CHARINDEX(':', ' '+ @contents)
         SELECT @start      = PATINDEX('%[^A-Za-z@][@]%', ' '+ @contents collate SQL_Latin1_General_CP850_Bin)
         SELECT @token      = RTRIM(Substring(' '+ @contents, @start + 1, @End - @Start - 1)),
                @endofName  = PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
                @param      = RIGHT(@token, LEN(@token) - @endofName + 1)
         SELECT @token      = LEFT(@token, @endofName - 1),
                @Contents   = RIGHT(' '+ @contents, LEN(' '+ @contents +'|') - @end - 1)
         SELECT @Name       = StringValue FROM @strings
         WHERE  string_id = @param
      END ELSE
         SELECT @Name = null, @SequenceNo = @SequenceNo + 1
      SELECT @end = CHARINDEX(',', @contents)
      IF @end = 0
         IF ISNUMERIC(@contents) = 1
            SELECT @end = LEN(@contents) + 1
         ELSE
            SELECT @end = PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @contents +' ' collate SQL_Latin1_General_CP850_Bin) + 1
         SELECT @start    = PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+ @contents collate SQL_Latin1_General_CP850_Bin)
         SELECT @Value    = RTRIM(SUBSTRING(@contents, @start, @End - @Start)),
                @Contents = RIGHT(@contents +' ', LEN(@contents +'|') - @end)
         IF SUBSTRING(@value, 1, 7) = '@object'
            INSERT INTO @hierarchy(Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
            SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 8, 5), SUBSTRING(@value, 8, 5), 'object'
         ELSE
           IF SUBSTRING(@value, 1, 6) = '@array'
              INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
              SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 7, 5), SUBSTRING(@value, 7, 5), 'array'
           ELSE
              IF SUBSTRING(@value, 1, 7) = '@string'
                 INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, ValueType)
                 SELECT @Name, @SequenceNo, @Parent_ID, StringValue, 'string'
                 FROM   @strings
                 WHERE  string_id = SUBSTRING(@value, 8, 5)
              ELSE
                 IF @value IN ('true', 'false')
                    INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, ValueType)
                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'boolean'
                 ELSE
                    IF @value = 'null'
                       INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, ValueType)
                       SELECT @Name, @SequenceNo, @Parent_ID, @value, 'null'
                    ELSE
                       IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0 
                          INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, ValueType)
                          SELECT @Name, @SequenceNo, @Parent_ID, @value, 'real'
                       ELSE
                          INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, ValueType)
                          SELECT @Name, @SequenceNo, @Parent_ID, @value, 'int'
      IF @Contents = ' ' SELECT @SequenceNo = 0
    END
  END
  INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
  SELECT '-',1, NULL, '', @Parent_ID-1, @type
  RETURN
END;
