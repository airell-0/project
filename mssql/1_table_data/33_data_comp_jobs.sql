CREATE TABLE [dbo].[data_comp_jobs](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_jobs_comp] DEFAULT(''),
  [jobs_head] int               NOT NULL CONSTRAINT [dx_data_comp_jobs_head] DEFAULT((0)),
  [jobs_code] int               NOT NULL CONSTRAINT [dx_data_comp_jobs_code] DEFAULT((0)),
  [jobs_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_jobs_name] DEFAULT(''),
  [jobs_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_jobs_stat] DEFAULT((0)),
  CONSTRAINT [px_data_comp_jobs] PRIMARY KEY CLUSTERED (
    [comp_code],[jobs_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
