CREATE TABLE [dbo].[data_enum_list](
  [enum_init] varchar(25)       NOT NULL CONSTRAINT [dx_data_enum_list_init] DEFAULT(''),
  [enum_code] tinyint           NOT NULL CONSTRAINT [dx_data_enum_list_code] DEFAULT((0)),
  [enum_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_enum_list_name] DEFAULT(''),
  CONSTRAINT [px_data_enum_list] PRIMARY KEY CLUSTERED (
    [enum_init],[enum_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
