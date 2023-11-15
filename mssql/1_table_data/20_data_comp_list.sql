CREATE TABLE [dbo].[data_comp_list](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_list_code] DEFAULT(''),
  [comp_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_list_name] DEFAULT(''),
  [comp_cash] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_list_cash] DEFAULT(''),
  [comp_ntax] varchar(50)       NOT NULL CONSTRAINT [dx_data_comp_list_ntax] DEFAULT(''),
  [comp_addr] varchar(500)      NOT NULL CONSTRAINT [dx_data_comp_list_addr] DEFAULT(''),
  [comp_sign] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_list_sign] DEFAULT(''),
  [comp_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_list_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_comp_list] PRIMARY KEY CLUSTERED (
    [comp_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
