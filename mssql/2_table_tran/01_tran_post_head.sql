CREATE TABLE [dbo].[tran_post_head](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_head_comp_code] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_post_head_book_code] DEFAULT((0)),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_post_head_regs_code] DEFAULT(''),
  [tran_docs] varchar(250)      NOT NULL CONSTRAINT [dx_post_head_tran_docs] DEFAULT(''),
  [tran_date] datetime          NOT NULL CONSTRAINT [dx_post_head_tran_date] DEFAULT('1900-01-01'),
  [form_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_head_form_code] DEFAULT(''),
  [tran_code] varchar(25)       NOT NULL CONSTRAINT [dx_post_head_tran_code] DEFAULT(''),
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_head_cash_code] DEFAULT(''),
  [vals_excs] float             NOT NULL CONSTRAINT [dx_post_head_vals_excs] DEFAULT((0)),
  [vals_real] float             NOT NULL CONSTRAINT [dx_post_head_vals_real] DEFAULT((0)),
  [vals_tran] float             NOT NULL CONSTRAINT [dx_post_head_vals_tran] DEFAULT((0)),
  [user_indx] int               NOT NULL CONSTRAINT [dx_post_head_user_indx] DEFAULT((0)),
  CONSTRAINT [pk_tran_post_head] PRIMARY KEY CLUSTERED (
    [comp_code],[tran_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
