CREATE TABLE [dbo].[data_cash_list](
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_cash_list_code] DEFAULT(''),
  [cash_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_cash_list_name] DEFAULT(''),
  [cash_stat] tinyint           NOT NULL CONSTRAINT [dx_data_cash_list_stat] DEFAULT((0)),
  CONSTRAINT [px_data_cash_list] PRIMARY KEY CLUSTERED (
    [cash_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
