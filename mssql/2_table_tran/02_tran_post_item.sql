CREATE TABLE [dbo].[tran_post_item](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_item_comp_code] DEFAULT(''),
  [menu_code] varchar(5)        NOT NULL CONSTRAINT [dx_post_item_menu_code] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_post_item_book_code] DEFAULT((0)),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_post_item_regs_code] DEFAULT(''),
  [cost_code] varchar(10)       NOT NULL CONSTRAINT [dx_post_item_cost_code] DEFAULT(''),
  [dept_code] varchar(5)        NOT NULL CONSTRAINT [dx_post_item_dept_code] DEFAULT(''),
  [tran_time] datetime          NOT NULL CONSTRAINT [dx_post_item_tran_time] DEFAULT('1900-01-01'),
  [tran_docs] varchar(250)      NOT NULL CONSTRAINT [dx_post_item_tran_docs] DEFAULT(''),
  [tran_rows] int               NOT NULL CONSTRAINT [dx_post_item_tran_rows] DEFAULT((0)),
  [tran_date] datetime          NOT NULL CONSTRAINT [dx_post_item_tran_date] DEFAULT('1900-01-01'),
  [form_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_item_form_code] DEFAULT(''),
  [tran_code] varchar(25)       NOT NULL CONSTRAINT [dx_post_item_tran_code] DEFAULT(''),
  [coac_code] varchar(15)       NOT NULL CONSTRAINT [dx_post_item_coac_code] DEFAULT(''),
  [coac_init] varchar(1)        NOT NULL CONSTRAINT [dx_post_item_coac_init] DEFAULT(''),
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_item_cash_code] DEFAULT(''),
  [vals_excs] float             NOT NULL CONSTRAINT [dx_post_item_vals_excs] DEFAULT((0)),
  [vals_real] float             NOT NULL CONSTRAINT [dx_post_item_vals_real] DEFAULT((0)),
  [vals_tran] float             NOT NULL CONSTRAINT [dx_post_item_vals_tran] DEFAULT((0)),
  [user_indx] int               NOT NULL CONSTRAINT [dx_post_item_user_indx] DEFAULT((0)),
  [stat_code] tinyint           NOT NULL CONSTRAINT [dx_post_item_stat_code] DEFAULT((0)),
  [stat_note] varchar(250)      NOT NULL CONSTRAINT [dx_post_item_stat_note] DEFAULT(''),
  [tran_mark] varchar(250)      NOT NULL CONSTRAINT [dx_post_item_tran_mark] DEFAULT(''),
  [tran_note] varchar(250)      NOT NULL CONSTRAINT [dx_post_item_tran_note] DEFAULT(''),
  [tran_desc] varchar(250)      NOT NULL CONSTRAINT [dx_post_item_tran_desc] DEFAULT(''),
  CONSTRAINT [pk_tran_post_item] PRIMARY KEY CLUSTERED (
    [comp_code],[tran_docs],[tran_rows],[tran_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
