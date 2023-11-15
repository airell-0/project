CREATE TABLE [dbo].[data_comp_coac](
  [comp_code] varchar(3)        NOT NULL CONSTRAINT [dx_data_comp_coac_comp] DEFAULT(''),
  [coac_step] tinyint           NOT NULL CONSTRAINT [dx_data_comp_coac_step] DEFAULT((0)),
  [coac_reff] varchar(15)       NOT NULL CONSTRAINT [dx_data_comp_coac_reff] DEFAULT(''),
  [coac_code] varchar(15)       NOT NULL CONSTRAINT [dx_data_comp_coac_code] DEFAULT(''),
  [coac_name] varchar(250)      NOT NULL CONSTRAINT [dx_data_comp_coac_name] DEFAULT(''),
  [coac_type] tinyint           NOT NULL CONSTRAINT [dx_data_comp_coac_type] DEFAULT((0)),
  [coac_edit] tinyint           NOT NULL CONSTRAINT [dx_data_comp_coac_edit] DEFAULT((0)),
  [coac_load] tinyint           NOT NULL CONSTRAINT [dx_data_comp_coac_load] DEFAULT((0)),
  [coac_lock] tinyint           NOT NULL CONSTRAINT [dx_data_comp_coac_lock] DEFAULT((0)),
  [coac_stat] tinyint           NOT NULL CONSTRAINT [dx_data_comp_coac_stat] DEFAULT((0)),
  CONSTRAINT [pk_data_comp_coac] PRIMARY KEY CLUSTERED (
    [comp_code],[coac_code] ASC
  ) WITH (
    PAD_INDEX = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
    IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF
  ) ON [PRIMARY]
) ON [PRIMARY];
