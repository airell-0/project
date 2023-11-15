CREATE TABLE [dbo].[data_cash_bank](
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_cash_bank_cash] DEFAULT(''),
  [bank_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_cash_bank_code] DEFAULT(''),
  [bank_full] varchar(25)       NOT NULL CONSTRAINT [dx_data_cash_bank_full] DEFAULT(''),
  [bank_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_cash_bank_name] DEFAULT(''),
  [bank_tllg] float             NOT NULL CONSTRAINT [dx_data_cash_bank_tllg] DEFAULT((0)),
  [bank_trto] float             NOT NULL CONSTRAINT [dx_data_cash_bank_trto] DEFAULT((0)),
  [bank_rtgs] float             NOT NULL CONSTRAINT [dx_data_cash_bank_rtgs] DEFAULT((0)),
  [bank_stat] tinyint           NOT NULL CONSTRAINT [dx_data_cash_bank_stat] DEFAULT((0)),
  CONSTRAINT [px_data_cash_bank] PRIMARY KEY CLUSTERED (
    [cash_code],[bank_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
