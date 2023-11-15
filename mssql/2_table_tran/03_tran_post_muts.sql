CREATE TABLE [dbo].[tran_post_muts](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_muts_comp_code] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_post_muts_book_code] DEFAULT((0)),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_post_muts_regs_code] DEFAULT(''),
  [coac_code] varchar(15)       NOT NULL CONSTRAINT [dx_post_muts_coac_code] DEFAULT(''),
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_post_muts_cash_code] DEFAULT(''),
  [muts_year] int               NOT NULL CONSTRAINT [dx_post_muts_muts_year] DEFAULT((0)),
  [muts_adjs] tinyint           NOT NULL CONSTRAINT [dx_post_muts_muts_adjs] DEFAULT((0)),
  [vals_tran] float             NOT NULL CONSTRAINT [dx_post_muts_vals_tran] DEFAULT((0)),
  CONSTRAINT [pk_tran_post_muts] PRIMARY KEY CLUSTERED (
    [comp_code],[book_code],[regs_code],[coac_code],[cash_code],[muts_year],[muts_adjs] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
