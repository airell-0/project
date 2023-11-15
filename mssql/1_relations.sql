ALTER TABLE [dbo].[data_menu_item] ADD
  CONSTRAINT [fx_data_menu_item_list]
    FOREIGN KEY ([menu_list])
    REFERENCES [dbo].[data_menu_list] ([menu_list])
GO
ALTER TABLE [dbo].[data_cash_taxs] ADD
  CONSTRAINT [fk_data_cash_taxs_list]
    FOREIGN KEY([cash_code])
    REFERENCES [dbo].[data_cash_list] ([cash_code])
GO
ALTER TABLE [dbo].[data_cash_bank] ADD
  CONSTRAINT [fk_data_cash_bank_list]
    FOREIGN KEY([cash_code])
    REFERENCES [dbo].[data_cash_list] ([cash_code])
GO
ALTER TABLE [dbo].[data_cash_curs] ADD
  CONSTRAINT [fk_data_cash_curs_cash]
    FOREIGN KEY([cash_code])
    REFERENCES [dbo].[data_cash_list] ([cash_code])
GO
ALTER TABLE [dbo].[data_comp_book] ADD
  CONSTRAINT [fk_data_comp_book_list]
    FOREIGN KEY ([comp_code])
    REFERENCES [dbo].[data_comp_list]([comp_code])
GO
ALTER TABLE [dbo].[data_comp_form] ADD
  CONSTRAINT [fk_data_comp_form_list]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code])
GO
ALTER TABLE [dbo].[data_comp_coac] ADD
  CONSTRAINT [fk_data_comp_coac_list]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code])
GO
ALTER TABLE [dbo].[data_comp_regs] ADD
  CONSTRAINT [fk_data_comp_regs_book]
    FOREIGN KEY([comp_code],[book_code])
    REFERENCES [dbo].[data_comp_book] ([comp_code],[book_code])
GO
ALTER TABLE [dbo].[data_comp_dept] ADD
  CONSTRAINT [fk_data_comp_dept_list]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code])
GO
ALTER TABLE [dbo].[data_comp_cost] ADD
  CONSTRAINT [fk_data_comp_cost_regs]
    FOREIGN KEY([comp_code],[regs_code])
    REFERENCES [dbo].[data_comp_regs] ([comp_code],[regs_code])
GO
ALTER TABLE [dbo].[data_comp_unit] ADD
  CONSTRAINT [fk_data_comp_unit_dept]
    FOREIGN KEY([comp_code],[dept_code])
    REFERENCES [dbo].[data_comp_dept] ([comp_code],[dept_code])
GO
ALTER TABLE [dbo].[data_comp_pool] ADD
  CONSTRAINT [fk_data_comp_pool_cost]
    FOREIGN KEY([comp_code],[regs_code],[cost_code])
    REFERENCES [dbo].[data_comp_cost] ([comp_code],[regs_code],[cost_code]),
  CONSTRAINT [fk_data_comp_pool_dept]
    FOREIGN KEY([comp_code],[dept_code])
    REFERENCES [dbo].[data_comp_dept] ([comp_code],[dept_code])
GO
ALTER TABLE [dbo].[data_comp_flag] ADD
  CONSTRAINT [fk_data_comp_flag_book]
    FOREIGN KEY([comp_code],[book_code])
    REFERENCES [dbo].[data_comp_book] ([comp_code],[book_code]),
  CONSTRAINT [fk_data_comp_flag_form]
    FOREIGN KEY([comp_code],[form_code])
    REFERENCES [dbo].[data_comp_form] ([comp_code],[form_code])
GO
ALTER TABLE [dbo].[data_comp_reks] ADD
  CONSTRAINT [fk_data_comp_reks_regs]
    FOREIGN KEY([comp_code],[regs_code])
    REFERENCES [dbo].[data_comp_regs] ([comp_code],[regs_code]),
  CONSTRAINT [fk_data_comp_reks_bank]
    FOREIGN KEY([cash_code],[bank_code])
    REFERENCES [dbo].[data_cash_bank] ([cash_code],[bank_code])
GO
ALTER TABLE [dbo].[data_comp_jobs] ADD
  CONSTRAINT [fk_data_comp_jobs_list]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code])
GO
ALTER TABLE [dbo].[data_expo_type] ADD
  CONSTRAINT [fx_data_expo_type_view]
    FOREIGN KEY ([expo_indx])
    REFERENCES [dbo].[data_expo_view] ([expo_indx])
GO
ALTER TABLE [dbo].[data_expo_tran] ADD
  CONSTRAINT [fx_data_expo_tran_view]
    FOREIGN KEY ([expo_indx])
    REFERENCES [dbo].[data_expo_view] ([expo_indx]),
  CONSTRAINT [fx_data_expo_tran_comp]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code]),
  CONSTRAINT [fx_data_expo_tran_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[data_sign_list] ADD
  CONSTRAINT [fk_data_sign_list_comp]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code])
GO
ALTER TABLE [dbo].[data_sign_tran] ADD
  CONSTRAINT [fk_data_sign_tran_list]
    FOREIGN KEY([comp_code],[sign_apps],[sign_code],[sign_step],[sign_sg_1],[sign_sg_2])
    REFERENCES [dbo].[data_sign_list] ([comp_code],[sign_apps],[sign_code],[sign_step],[sign_sg_1],[sign_sg_2]),
  CONSTRAINT [fx_data_sign_tran_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[data_user_devi] ADD
  CONSTRAINT [fx_data_user_devi_list]
    FOREIGN KEY ([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[data_user_auth] ADD
  CONSTRAINT [fk_data_user_auth_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx]),
  CONSTRAINT [fk_data_user_auth_comp]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code]),
  CONSTRAINT [fk_data_user_auth_menu]
    FOREIGN KEY([menu_code])
    REFERENCES [dbo].[data_menu_item] ([menu_code])
GO
ALTER TABLE [dbo].[data_user_rule] ADD
  CONSTRAINT [fk_data_user_rule_regs]
    FOREIGN KEY([comp_code],[regs_code])
    REFERENCES [dbo].[data_comp_regs] ([comp_code],[regs_code]),
  CONSTRAINT [fk_data_user_rule_list]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[data_user_expo] ADD
  CONSTRAINT [fk_data_user_expo_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx]),
  CONSTRAINT [fk_data_user_expo_comp]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code]),
  CONSTRAINT [fk_data_user_expo_view]
    FOREIGN KEY([expo_indx])
    REFERENCES [dbo].[data_expo_view] ([expo_indx])
GO
ALTER TABLE [dbo].[data_user_sign] ADD
  CONSTRAINT [fk_data_user_sign_comp]
    FOREIGN KEY([comp_code])
    REFERENCES [dbo].[data_comp_list] ([comp_code]),
  CONSTRAINT [fk_data_user_sign_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[data_part_list] ADD
  CONSTRAINT [fk_data_part_list_regs]
    FOREIGN KEY([comp_code],[regs_code])
    REFERENCES [dbo].[data_comp_regs] ([comp_code],[regs_code]),
  CONSTRAINT [fk_data_part_list_cash]
    FOREIGN KEY([cash_code],[bank_code])
    REFERENCES [dbo].[data_cash_bank] ([cash_code],[bank_code])
GO
ALTER TABLE [dbo].[tran_post_head] ADD
  CONSTRAINT [fk_tran_post_head_book]
    FOREIGN KEY([comp_code],[book_code])
    REFERENCES [dbo].[data_comp_book] ([comp_code],[book_code]),
  CONSTRAINT [fk_tran_post_head_regs]
    FOREIGN KEY([comp_code],[regs_code])
    REFERENCES [dbo].[data_comp_regs] ([comp_code],[regs_code]),
  CONSTRAINT [fk_tran_post_head_form]
    FOREIGN KEY([comp_code],[form_code])
    REFERENCES [dbo].[data_comp_form] ([comp_code],[form_code]),
  CONSTRAINT [fk_tran_post_head_cash]
    FOREIGN KEY([cash_code])
    REFERENCES [dbo].[data_cash_list] ([cash_code]),
  CONSTRAINT [fk_tran_post_head_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[tran_post_item] ADD
  CONSTRAINT [fk_tran_post_item_menu]
    FOREIGN KEY([menu_code])
    REFERENCES [dbo].[data_menu_item] ([menu_code]),
  CONSTRAINT [fk_tran_post_item_book]
    FOREIGN KEY([comp_code],[book_code])
    REFERENCES [dbo].[data_comp_book] ([comp_code],[book_code]),
  CONSTRAINT [fk_tran_post_item_cost]
    FOREIGN KEY([comp_code],[regs_code],[cost_code])
    REFERENCES [dbo].[data_comp_cost] ([comp_code],[regs_code],[cost_code]),
  CONSTRAINT [fk_tran_post_item_dept]
    FOREIGN KEY([comp_code],[dept_code])
    REFERENCES [dbo].[data_comp_dept] ([comp_code],[dept_code]),
  CONSTRAINT [fk_tran_post_item_form]
    FOREIGN KEY([comp_code],[form_code])
    REFERENCES [dbo].[data_comp_form] ([comp_code],[form_code]),
  CONSTRAINT [fk_tran_post_item_coac]
    FOREIGN KEY([comp_code],[coac_code])
    REFERENCES [dbo].[data_comp_coac] ([comp_code],[coac_code]),
  CONSTRAINT [fk_tran_post_item_cash]
    FOREIGN KEY([cash_code])
    REFERENCES [dbo].[data_cash_list] ([cash_code]),
  CONSTRAINT [fk_tran_post_item_user]
    FOREIGN KEY([user_indx])
    REFERENCES [dbo].[data_user_list] ([user_indx])
GO
ALTER TABLE [dbo].[tran_post_muts] ADD
  CONSTRAINT [fk_tran_post_muts_book]
    FOREIGN KEY([comp_code],[book_code])
    REFERENCES [dbo].[data_comp_book] ([comp_code],[book_code]),
  CONSTRAINT [fk_tran_post_muts_regs]
    FOREIGN KEY([comp_code],[regs_code])
    REFERENCES [dbo].[data_comp_regs] ([comp_code],[regs_code]),
  CONSTRAINT [fk_tran_post_muts_coac]
    FOREIGN KEY([comp_code],[coac_code])
    REFERENCES [dbo].[data_comp_coac] ([comp_code],[coac_code]),
  CONSTRAINT [fk_tran_post_muts_cash]
    FOREIGN KEY([cash_code])
    REFERENCES [dbo].[data_cash_list] ([cash_code])
GO
