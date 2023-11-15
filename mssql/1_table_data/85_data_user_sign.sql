CREATE TABLE [dbo].[data_user_sign](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_user_sign_comp] DEFAULT(''),
  [sign_apps] varchar(15)       NOT NULL CONSTRAINT [dx_data_user_sign_apps] DEFAULT(''),
  [sign_code] varchar(25)       NOT NULL CONSTRAINT [dx_data_user_sign_code] DEFAULT(''),
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_user_sign_indx] DEFAULT((0)),
  CONSTRAINT [px_data_user_sign] PRIMARY KEY CLUSTERED (
    [comp_code],[sign_apps],[sign_code],[user_indx] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
