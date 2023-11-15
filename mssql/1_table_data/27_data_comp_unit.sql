CREATE TABLE [dbo].[data_comp_unit](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_unit_comp] DEFAULT(''),
  [dept_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_comp_unit_dept] DEFAULT(''),
  [unit_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_comp_unit_code] DEFAULT(''),
  [unit_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_unit_name] DEFAULT(''),
  [unit_sign] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_unit_sign] DEFAULT(''),
  [unit_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_unit_stat] DEFAULT((0)),
  CONSTRAINT [px_data_comp_unit] PRIMARY KEY CLUSTERED (
    [comp_code],[dept_code],[unit_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
