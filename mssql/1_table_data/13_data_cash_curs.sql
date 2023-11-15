CREATE TABLE [dbo].[data_cash_curs](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_cash_curs_comp] DEFAULT(''),
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_cash_curs_cash] DEFAULT(''),
  [curs_date] smalldatetime     NOT NULL CONSTRAINT [dx_data_cash_curs_date] DEFAULT('1900-01-01'),
  [curs_time] datetime          NOT NULL CONSTRAINT [dx_data_cash_curs_time] DEFAULT('1900-01-01'),
  [curs_sell] float             NOT NULL CONSTRAINT [dx_data_cash_curs_sell] DEFAULT((0)),
  [curs_buys] float             NOT NULL CONSTRAINT [dx_data_cash_curs_buys] DEFAULT((0)),
  CONSTRAINT [px_data_cash_curs] PRIMARY KEY CLUSTERED (
    [comp_code],[cash_code],[curs_date],[curs_time] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
