CREATE TABLE [dbo].[data_user_devi](
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_user_devi_user] DEFAULT((0)),
  [devi_code] varchar(250)      NOT NULL CONSTRAINT [dx_data_user_devi_code] DEFAULT(''),
  [devi_keys] varchar(4000)     NOT NULL CONSTRAINT [dx_data_user_devi_keys] DEFAULT(''),
  [devi_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_user_devi_name] DEFAULT(''),
  [devi_d_ap] varchar(50)       NOT NULL CONSTRAINT [dx_data_user_devi_d_ap] DEFAULT(''),
  [devi_d_vr] varchar(50)       NOT NULL CONSTRAINT [dx_data_user_devi_d_vr] DEFAULT(''),
  [devi_d_sy] varchar(250)      NOT NULL CONSTRAINT [dx_data_user_devi_d_sy] DEFAULT(''),
  CONSTRAINT [px_data_user_devi] PRIMARY KEY CLUSTERED (
    [user_indx],[devi_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
