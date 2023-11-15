CREATE TABLE [dbo].[data_expo_type](
  [expo_type] int               IDENTITY(1,1) NOT NULL,
  [expo_indx] int               NOT NULL CONSTRAINT [dx_data_expo_type_indx] DEFAULT((0)),
  [expo_code] varchar(250)      NOT NULL CONSTRAINT [dx_data_expo_type_code] DEFAULT(''),
  [expo_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_expo_type_name] DEFAULT(''),
  [expo_stat] tinyint           NOT NULL CONSTRAINT [dx_data_expo_type_book] DEFAULT((0)),
  CONSTRAINT [px_data_expo_type] PRIMARY KEY CLUSTERED (
    [expo_type] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
