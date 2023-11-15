CREATE TABLE [dbo].[data_comp_book](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_book_comp] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_data_comp_book_code] DEFAULT((0)),
  [book_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_book_name] DEFAULT(''),
  [book_sign] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_book_sign] DEFAULT(''),
  [book_year] smallint          NOT NULL CONSTRAINT [dx_data_comp_book_year] DEFAULT((0)),
  [book_lock] tinyint           NOT NULL CONSTRAINT [dx_data_comp_book_lock] DEFAULT((0)),
  [book_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_book_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_comp_book] PRIMARY KEY CLUSTERED (
    [comp_code],[book_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
