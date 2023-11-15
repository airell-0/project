CREATE TABLE [dbo].[data_comp_regs](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_regs_comp] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_data_comp_regs_book] DEFAULT((0)),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_regs_code] DEFAULT(''),
  [regs_land] tinyint           NOT NULL CONSTRAINT [dx_data_comp_regs_land] DEFAULT((0)),
  [regs_init] varchar(25)       NOT NULL CONSTRAINT [dx_data_comp_regs_init] DEFAULT(''),
  [regs_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_regs_name] DEFAULT(''),
  [regs_addr] varchar(500)      NOT NULL CONSTRAINT [dx_data_comp_regs_addr] DEFAULT(''),
  [regs_call] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_regs_call] DEFAULT(''),
  [regs_faxs] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_regs_faxs] DEFAULT(''),
  [regs_sign] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_regs_sign] DEFAULT(''),
  [regs_year] smallint          NOT NULL CONSTRAINT [dx_data_comp_regs_year] DEFAULT((0)),
  [regs_lock] tinyint           NOT NULL CONSTRAINT [dx_data_comp_regs_lock] DEFAULT((0)),
  [regs_ctib] varchar(15)       NOT NULL CONSTRAINT [dx_data_comp_regs_ctib] DEFAULT(''),
  [regs_ctio] varchar(15)       NOT NULL CONSTRAINT [dx_data_comp_regs_ctio] DEFAULT(''),
  [regs_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_regs_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_comp_regs] PRIMARY KEY CLUSTERED (
    [comp_code],[regs_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
