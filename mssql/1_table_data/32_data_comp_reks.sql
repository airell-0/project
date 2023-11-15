CREATE TABLE [dbo].[data_comp_reks](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_reks_comp] DEFAULT(''),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_reks_regs] DEFAULT(''),
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_reks_cash] DEFAULT(''),
  [bank_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_comp_reks_bank] DEFAULT(''),
  [reks_code] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_reks_code] DEFAULT(''),
  [reks_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_reks_name] DEFAULT(''),
  [reks_lock] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_reks_lock] DEFAULT(''),
  [reks_desc] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_reks_desc] DEFAULT(''),
  [reks_c_ap] varchar(15)       NOT NULL CONSTRAINT [dx_data_comp_reks_c_ap] DEFAULT(''),
  [reks_c_ar] varchar(15)       NOT NULL CONSTRAINT [dx_data_comp_reks_c_ar] DEFAULT(''),
  [reks_flag] tinyint           NOT NULL CONSTRAINT [dx_data_comp_reks_flag] DEFAULT((0)),
  [reks_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_reks_stat] DEFAULT((0)),
  CONSTRAINT [px_data_comp_reks] PRIMARY KEY CLUSTERED (
    [comp_code],[regs_code],[bank_code],[reks_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
