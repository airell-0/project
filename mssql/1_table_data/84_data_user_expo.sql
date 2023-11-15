CREATE TABLE [dbo].[data_user_expo](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_user_expo_comp] DEFAULT(''),
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_user_expo_user] DEFAULT((0)),
  [expo_indx] int               NOT NULL CONSTRAINT [dx_data_user_expo_indx] DEFAULT((0)),
  [expo_stat] tinyint           NOT NULL CONSTRAINT [dx_data_user_expo_stat] DEFAULT((0)),
  CONSTRAINT [px_data_user_expo] PRIMARY KEY CLUSTERED (
    [comp_code],[user_indx],[expo_indx] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
