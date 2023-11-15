CREATE TABLE [dbo].[data_user_list](
  [user_indx] int               IDENTITY(1,1) NOT NULL,
  [user_comp] varchar(3)        NOT NULL CONSTRAINT [dx_data_user_list_comp] DEFAULT(''),
  [user_code] varchar(25)       NOT NULL CONSTRAINT [dx_data_user_list_code] DEFAULT(''),
  [user_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_user_list_name] DEFAULT(''),
  [user_pass] varchar(250)      NOT NULL CONSTRAINT [dx_data_user_list_pass] DEFAULT(''),
  [user_mail] varchar(250)      NOT NULL CONSTRAINT [dx_data_user_list_mail] DEFAULT(''),
  [user_call] varchar(50)       NOT NULL CONSTRAINT [dx_data_user_list_call] DEFAULT(''),
  [user_regs] varchar(10)       NOT NULL CONSTRAINT [dx_data_user_list_regs] DEFAULT(''),
  [user_cost] varchar(10)       NOT NULL CONSTRAINT [dx_data_user_list_cost] DEFAULT(''),
  [user_dept] varchar(5)        NOT NULL CONSTRAINT [dx_data_user_list_dept] DEFAULT(''),
  [user_unit] varchar(10)       NOT NULL CONSTRAINT [dx_data_user_list_unit] DEFAULT(''),
  [user_empl] varchar(50)       NOT NULL CONSTRAINT [dx_data_user_list_empl] DEFAULT(''),
  [user_jobs] int               NOT NULL CONSTRAINT [dx_data_user_list_jobs] DEFAULT((0)),
  [user_hris] tinyint           NOT NULL CONSTRAINT [dx_data_user_list_hris] DEFAULT((0)),
  [user_stat] tinyint           NOT NULL CONSTRAINT [dx_data_user_list_stat] DEFAULT((0)),
  CONSTRAINT [px_data_user_list] PRIMARY KEY CLUSTERED (
    [user_indx] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
