CREATE TABLE [dbo].[data_sign_tran](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_sign_tran_comp] DEFAULT(''),
  [sign_apps] varchar(15)       NOT NULL CONSTRAINT [dx_data_sign_tran_apps] DEFAULT(''),
  [sign_code] varchar(25)       NOT NULL CONSTRAINT [dx_data_sign_tran_code] DEFAULT(''),
  [sign_step] int               NOT NULL CONSTRAINT [dx_data_sign_tran_step] DEFAULT((0)),
  [sign_sg_1] int               NOT NULL CONSTRAINT [dx_data_sign_tran_sg_1] DEFAULT((0)),
  [sign_sg_2] int               NOT NULL CONSTRAINT [dx_data_sign_tran_sg_2] DEFAULT((0)),
  [sign_desc] varchar(250)      NOT NULL CONSTRAINT [dx_data_sign_tran_desc] DEFAULT(''),
  [sign_invl] int               NOT NULL CONSTRAINT [dx_data_sign_tran_invl] DEFAULT((0)),
  [sign_vals] float             NOT NULL CONSTRAINT [dx_data_sign_tran_vals] DEFAULT((0)),
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_sign_tran_user] DEFAULT((0)),
  [sign_docs] varchar(100)      NOT NULL CONSTRAINT [dx_data_sign_tran_docs] DEFAULT(''),
  [sign_date] datetime          NOT NULL CONSTRAINT [dx_data_sign_tran_date] DEFAULT('1900-01-01'),
  [sign_mark] varchar(500)      NOT NULL CONSTRAINT [dx_data_sign_tran_mark] DEFAULT(''),
  [sign_vald] float             NOT NULL CONSTRAINT [dx_data_sign_tran_vald] DEFAULT((0)),
  [sign_logs] int               NOT NULL CONSTRAINT [dx_data_sign_tran_logs] DEFAULT((0)),
  [sign_stat] int               NOT NULL CONSTRAINT [dx_data_sign_tran_stat] DEFAULT((0)),
  [sign_time] datetime          NOT NULL CONSTRAINT [dx_data_sign_tran_time] DEFAULT('1900-01-01'),
  [sign_note] varchar(500)      NOT NULL CONSTRAINT [dx_data_sign_tran_note] DEFAULT(''),
  CONSTRAINT [px_data_sign_tran] PRIMARY KEY CLUSTERED (
    [comp_code],[sign_apps],[sign_code],[sign_step],[sign_sg_1],[sign_sg_2],[sign_docs] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
