CREATE TABLE [dbo].[data_comp_flag](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_flag_comp] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_data_comp_flag_book] DEFAULT((0)),
  [form_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_flag_code] DEFAULT(''),
  [form_year] smallint          NOT NULL CONSTRAINT [dx_data_comp_flag_year] DEFAULT((0)),
  [form_numb] bigint            NOT NULL CONSTRAINT [dx_data_comp_flag_numb] DEFAULT((0)),
  CONSTRAINT [px_data_comp_flag] PRIMARY KEY CLUSTERED (
    [comp_code],[book_code],[form_code],[form_year] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
