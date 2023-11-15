CREATE TABLE [dbo].[data_cash_taxs](
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_cash_taxs_cash] DEFAULT(''),
  [taxs_date] datetime          NOT NULL CONSTRAINT [dx_data_cash_taxs_date] DEFAULT('1900-01-01'),
  [taxs_rate] float             NOT NULL CONSTRAINT [dx_data_cash_taxs_rate] DEFAULT((0)),
  CONSTRAINT [px_data_cash_taxs] PRIMARY KEY CLUSTERED (
    [cash_code],[taxs_date] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
