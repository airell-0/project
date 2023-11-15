CREATE TABLE [dbo].[data_comp_cost](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_cost_comp] DEFAULT(''),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_cost_regs] DEFAULT(''),
  [cost_type] tinyint           NOT NULL CONSTRAINT [dx_data_comp_cost_type] DEFAULT(''),
  [cost_reff] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_cost_reff] DEFAULT(''),
  [cost_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_cost_cost] DEFAULT(''),
  [cost_init] varchar(25)       NOT NULL CONSTRAINT [dx_data_comp_cost_init] DEFAULT(''),
  [cost_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_cost_name] DEFAULT(''),
  [cost_addr] varchar(500)      NOT NULL CONSTRAINT [dx_data_comp_cost_addr] DEFAULT(''),
  [cost_call] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_cost_call] DEFAULT(''),
  [cost_faxs] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_cost_faxs] DEFAULT(''),
  [cost_sign] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_cost_sign] DEFAULT(''),
  [cost_host] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_cost_host] DEFAULT(''),
  [cost_n_tx] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_cost_n_tx] DEFAULT(''),
  [cost_n_fr] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_cost_n_fr] DEFAULT(''),
  [cost_proc] tinyint           NOT NULL CONSTRAINT [dx_data_comp_cost_proc] DEFAULT((0)),
  [cost_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_cost_stat] DEFAULT((0)),
  CONSTRAINT [px_data_comp_cost] PRIMARY KEY CLUSTERED (
    [comp_code],[regs_code],[cost_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
