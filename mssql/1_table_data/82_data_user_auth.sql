CREATE TABLE [dbo].[data_user_auth](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_user_auth_comp] DEFAULT(''),
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_user_auth_user] DEFAULT((0)),
  [menu_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_user_auth_menu] DEFAULT(''),
  [auth_stat] tinyint           NOT NULL CONSTRAINT [dx_data_user_auth_stat] DEFAULT((0)),
  CONSTRAINT [px_data_user_auth] PRIMARY KEY CLUSTERED (
    [comp_code],[user_indx],[menu_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
