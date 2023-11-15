CREATE TABLE [dbo].[data_menu_list](
  [menu_head] varchar(2)        NOT NULL CONSTRAINT [dx_data_menu_list_head] DEFAULT(''),
  [menu_list] varchar(2)        NOT NULL CONSTRAINT [dx_data_menu_list_list] DEFAULT(''),
  [menu_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_menu_list_name] DEFAULT(''),
  [menu_stat] tinyint           NOT NULL CONSTRAINT [dx_data_menu_list_stat] DEFAULT((0)),
  CONSTRAINT [px_data_menu_list] PRIMARY KEY CLUSTERED (
    [menu_list] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
