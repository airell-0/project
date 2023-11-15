CREATE TABLE [dbo].[data_comp_form](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_form_comp] DEFAULT(''),
  [form_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_form_code] DEFAULT(''),
  [form_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_form_name] DEFAULT(''),
  [form_load] tinyint           NOT NULL CONSTRAINT [dx_data_comp_form_load] DEFAULT((0)),
  [form_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_form_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_comp_form] PRIMARY KEY CLUSTERED (
    [comp_code],[form_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
