CREATE TABLE [dbo].[data_part_list](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_part_list_comp] DEFAULT(''),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_part_list_regs] DEFAULT(''),
  [part_type] tinyint           NOT NULL CONSTRAINT [dx_data_part_list_type] DEFAULT((0)),
  [part_mark] tinyint           NOT NULL CONSTRAINT [dx_data_part_list_mark] DEFAULT((0)),
  [part_numb] int               NOT NULL CONSTRAINT [dx_data_part_list_numb] DEFAULT((0)),
  [part_link] varchar(15)       NOT NULL CONSTRAINT [dx_data_part_list_link] DEFAULT(''),
  [part_reff] varchar(15)       NOT NULL CONSTRAINT [dx_data_part_list_reff] DEFAULT(''),
  [part_code] varchar(15)       NOT NULL CONSTRAINT [dx_data_part_list_code] DEFAULT(''),
  [part_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_part_list_name] DEFAULT(''),
  [part_ntax] varchar(50)       NOT NULL CONSTRAINT [dx_data_part_list_ntax] DEFAULT(''),
  [part_mail] varchar(250)      NOT NULL CONSTRAINT [dx_data_part_list_mail] DEFAULT(''),
  [part_addr] varchar(500)      NOT NULL CONSTRAINT [dx_data_part_list_addr] DEFAULT(''),
  [part_high] tinyint           NOT NULL CONSTRAINT [dx_data_part_list_high] DEFAULT((0)),
  [part_ship] tinyint           NOT NULL CONSTRAINT [dx_data_part_list_ship] DEFAULT((0)),
  [part_shop] tinyint           NOT NULL CONSTRAINT [dx_data_part_list_shop] DEFAULT((0)),
  [part_pays] tinyint           NOT NULL CONSTRAINT [dx_data_part_list_pays] DEFAULT((0)),
  [part_term] int               NOT NULL CONSTRAINT [dx_data_part_list_term] DEFAULT((0)),
  [bank_code] varchar(5)        NOT NULL CONSTRAINT [dx_data_part_list_bank] DEFAULT(''),
  [part_reks] varchar(50)       NOT NULL CONSTRAINT [dx_data_part_list_reks] DEFAULT(''),
  [part_rekn] varchar(250)      NOT NULL CONSTRAINT [dx_data_part_list_rekn] DEFAULT(''),
  [cash_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_part_list_cash] DEFAULT(''),
  [part_taxs] varchar(3)        NOT NULL CONSTRAINT [dx_data_part_list_taxs] DEFAULT(''),
  [part_note] varchar(500)      NOT NULL CONSTRAINT [dx_data_part_list_note] DEFAULT(''),
  [part_stat] int               NOT NULL CONSTRAINT [dx_data_part_list_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_part_list] PRIMARY KEY CLUSTERED (
    [comp_code],[regs_code],[part_type],[part_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
