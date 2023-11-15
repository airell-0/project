CREATE TABLE [dbo].[data_comp_pool](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_pool_comp] DEFAULT(''),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_pool_regs] DEFAULT(''),
  [cost_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_pool_cost] DEFAULT(''),
  [dept_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_comp_pool_dept] DEFAULT(''),
  [pool_sign] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_pool_sign] DEFAULT(''),
  [pool_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_pool_stat] DEFAULT((0)),
  CONSTRAINT [px_data_comp_pool] PRIMARY KEY CLUSTERED (
    [comp_code],[regs_code],[cost_code],[dept_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
