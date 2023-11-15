CREATE TABLE [dbo].[data_menu_item](
  [menu_list] varchar(2)        NOT NULL CONSTRAINT [dx_data_menu_item_list] DEFAULT(''),
  [menu_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_menu_item_code] DEFAULT(''),
  [menu_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_menu_item_name] DEFAULT(''),
  [menu_link] varchar(250)      NOT NULL CONSTRAINT [dx_data_menu_item_link] DEFAULT(''),
  [menu_sign] tinyint           NOT NULL CONSTRAINT [dx_data_menu_item_sign] DEFAULT((0)),
  [menu_stat] tinyint           NOT NULL CONSTRAINT [dx_data_menu_item_stat] DEFAULT((0)),
  CONSTRAINT [px_data_menu_item] PRIMARY KEY CLUSTERED (
    [menu_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
