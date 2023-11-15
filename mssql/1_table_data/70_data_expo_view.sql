CREATE TABLE [dbo].[data_expo_view](
  [expo_indx] int               IDENTITY(1,1) NOT NULL,
  [expo_menu] varchar(5)        NOT NULL CONSTRAINT [dx_data_expo_view_menu] DEFAULT(''),
  [expo_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_expo_view_name] DEFAULT(''),
  [expo_exec] varchar(4000)     NOT NULL CONSTRAINT [dx_data_expo_view_exec] DEFAULT(''),
  [expo_stat] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_stat] DEFAULT((0)),
  [expo_book] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_book] DEFAULT((0)),
  [expo_regs] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_regs] DEFAULT((0)),
  [expo_type] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_type] DEFAULT((0)),
  [expo_year] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_year] DEFAULT((0)),
  [expo_lock] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_lock] DEFAULT((0)),
  [expo_datn] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_datn] DEFAULT((0)),
  [expo_dats] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_dats] DEFAULT((0)),
  [expo_date] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_date] DEFAULT((0)),
  [expo_coas] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_coas] DEFAULT((0)),
  [expo_coae] tinyint           NOT NULL CONSTRAINT [dx_data_expo_view_coae] DEFAULT((0)),
  CONSTRAINT [px_data_expo_view] PRIMARY KEY CLUSTERED (
    [expo_indx] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
