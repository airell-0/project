CREATE TABLE [dbo].[data_comp_dept](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_dept_comp] DEFAULT(''),
  [dept_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_comp_dept_code] DEFAULT(''),
  [dept_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_dept_name] DEFAULT(''),
  [dept_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_dept_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_comp_dept] PRIMARY KEY CLUSTERED (
    [comp_code],[dept_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
