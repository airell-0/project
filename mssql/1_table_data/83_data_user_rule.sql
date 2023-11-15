CREATE TABLE [dbo].[data_user_rule](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_user_rule_comp] DEFAULT(''),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_user_rule_regs] DEFAULT(''),
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_user_rule_user] DEFAULT((0)),
  [rule_stat] tinyint           NOT NULL CONSTRAINT [dx_data_user_rule_stat] DEFAULT((0)),
  CONSTRAINT [px_data_user_rule] PRIMARY KEY CLUSTERED (
    [comp_code],[regs_code],[user_indx] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
