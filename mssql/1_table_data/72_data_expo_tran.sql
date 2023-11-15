CREATE TABLE [dbo].[data_expo_tran](
  [expo_tran] bigint            IDENTITY(1,1) NOT NULL,
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_expo_tran_comp] DEFAULT(''),
  [user_indx] int               NOT NULL CONSTRAINT [dx_data_expo_tran_user] DEFAULT((0)),
  [expo_indx] int               NOT NULL CONSTRAINT [dx_data_expo_tran_indx] DEFAULT((0)),
  [expo_exec] varchar(4000)     NOT NULL CONSTRAINT [dx_data_expo_tran_exec] DEFAULT(''),
  [book_code] tinyint           NOT NULL CONSTRAINT [dx_data_expo_tran_book] DEFAULT((0)),
  [regs_code] varchar(10)       NOT NULL CONSTRAINT [dx_data_expo_tran_regs] DEFAULT((0)),
  [expo_type] int               NOT NULL CONSTRAINT [dx_data_expo_tran_type] DEFAULT((0)),
  [expo_year] smallint          NOT NULL CONSTRAINT [dx_data_expo_tran_year] DEFAULT((0)),
  [expo_lock] tinyint           NOT NULL CONSTRAINT [dx_data_expo_tran_lock] DEFAULT((0)),
  [expo_datn] datetime          NOT NULL CONSTRAINT [dx_data_expo_tran_datn] DEFAULT('1900-01-01'),
  [expo_dats] datetime          NOT NULL CONSTRAINT [dx_data_expo_tran_dats] DEFAULT('1900-01-01'),
  [expo_date] datetime          NOT NULL CONSTRAINT [dx_data_expo_tran_date] DEFAULT('1900-01-01'),
  [expo_coas] varchar(15)       NOT NULL CONSTRAINT [dx_data_expo_tran_coas] DEFAULT(''),
  [expo_coae] varchar(15)       NOT NULL CONSTRAINT [dx_data_expo_tran_coae] DEFAULT(''),
  [expo_stat] varchar(50)       NOT NULL CONSTRAINT [dx_data_expo_tran_stat] DEFAULT(''),
  [expo_note] varchar(250)      NOT NULL CONSTRAINT [dx_data_expo_tran_note] DEFAULT(''),
  [expo_file] varchar(500)      NOT NULL CONSTRAINT [dx_data_expo_tran_file] DEFAULT(''),
  CONSTRAINT [px_data_expo_tran] PRIMARY KEY CLUSTERED (
    [expo_tran] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
