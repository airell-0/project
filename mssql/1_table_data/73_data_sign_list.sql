CREATE TABLE [dbo].[data_sign_list](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_sign_list_comp] DEFAULT(''),
  [sign_apps] varchar(15)       NOT NULL CONSTRAINT [dx_data_sign_list_apps] DEFAULT(''),
  [sign_type] int               NOT NULL CONSTRAINT [dx_data_sign_list_sign] DEFAULT((0)),
  [sign_code] varchar(25)       NOT NULL CONSTRAINT [dx_data_sign_list_code] DEFAULT(''),
  [sign_step] int               NOT NULL CONSTRAINT [dx_data_sign_list_step] DEFAULT((0)),
  [sign_sg_1] int               NOT NULL CONSTRAINT [dx_data_sign_list_sg_1] DEFAULT((0)),
  [sign_sg_2] int               NOT NULL CONSTRAINT [dx_data_sign_list_sg_2] DEFAULT((0)),
  [sign_desc] varchar(250)      NOT NULL CONSTRAINT [dx_data_sign_list_desc] DEFAULT(''),
  [sign_invl] int               NOT NULL CONSTRAINT [dx_data_sign_list_invl] DEFAULT((0)),
  [sign_vals] float             NOT NULL CONSTRAINT [dx_data_sign_list_vals] DEFAULT((0)),
  CONSTRAINT [px_data_sign_list] PRIMARY KEY CLUSTERED (
    [comp_code],[sign_apps],[sign_code],[sign_step],[sign_sg_1],[sign_sg_2] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
