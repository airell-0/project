DELETE FROM [dbo].[data_enum_list]
INSERT INTO [dbo].[data_enum_list](
       [enum_init],[enum_code],[enum_name])
SELECT 'menu_stat', 0, 'Deactive'          UNION ALL
SELECT 'menu_stat', 1, 'Active'            UNION ALL
SELECT 'menu_sign', 0, 'Without Signature' UNION ALL
SELECT 'menu_sign', 1, 'With Signature'    UNION ALL
SELECT 'cash_stat', 0, 'Deactive'          UNION ALL
SELECT 'cash_stat', 1, 'Active'            UNION ALL
SELECT 'bank_stat', 0, 'Deactive'          UNION ALL
SELECT 'bank_stat', 1, 'Active'            UNION ALL
SELECT 'comp_stat', 0, 'Deactive'          UNION ALL
SELECT 'comp_stat', 1, 'Active'            UNION ALL
SELECT 'book_stat', 0, 'Deactive'          UNION ALL
SELECT 'book_stat', 1, 'Active'            UNION ALL
SELECT 'form_load', 0, 'Not Upload'        UNION ALL
SELECT 'form_load', 1, 'Is Upload'         UNION ALL
SELECT 'form_stat', 0, 'Deactive'          UNION ALL
SELECT 'form_stat', 1, 'Active'            UNION ALL
SELECT 'coac_type', 0, 'Balance Sheet'     UNION ALL
SELECT 'coac_type', 1, 'Expense'           UNION ALL
SELECT 'coac_type', 2, 'Revenue'           UNION ALL
SELECT 'coac_edit', 0, 'Not Edit'          UNION ALL
SELECT 'coac_edit', 1, 'Is Edit'           UNION ALL
SELECT 'coac_load', 0, 'Not Upload'        UNION ALL
SELECT 'coac_load', 1, 'Is Upload'         UNION ALL
SELECT 'coac_lock', 0, 'Not Usable'        UNION ALL
SELECT 'coac_lock', 1, 'Is Usable'         UNION ALL
SELECT 'coac_stat', 0, 'Deactive'          UNION ALL
SELECT 'coac_stat', 1, 'Active'            UNION ALL
SELECT 'regs_land', 0, 'Unknown'           UNION ALL
SELECT 'regs_land', 1, 'Head Office'       UNION ALL
SELECT 'regs_land', 2, 'Jawa'              UNION ALL
SELECT 'regs_land', 3, 'Bali'              UNION ALL
SELECT 'regs_land', 4, 'Sumatera'          UNION ALL
SELECT 'regs_land', 5, 'Sulawesi'          UNION ALL
SELECT 'regs_land', 6, 'Kalimantan'        UNION ALL
SELECT 'regs_land', 7, 'Papua'             UNION ALL
SELECT 'regs_land', 8, 'Overseas'          UNION ALL
SELECT 'regs_stat', 0, 'Deactive'          UNION ALL
SELECT 'regs_stat', 1, 'Active'            UNION ALL
SELECT 'dept_stat', 0, 'Deactive'          UNION ALL
SELECT 'dept_stat', 1, 'Active'            UNION ALL
SELECT 'auth_stat', 0, 'Deactive'          UNION ALL
SELECT 'auth_stat', 1, 'Active'            UNION ALL
SELECT 'rule_stat', 0, 'Deactive'          UNION ALL
SELECT 'rule_stat', 1, 'Active'            UNION ALL
SELECT 'reks_flag', 0, 'Not Usable'        UNION ALL
SELECT 'reks_flag', 1, 'Is Usable'         UNION ALL
SELECT 'reks_stat', 0, 'Deactive'          UNION ALL
SELECT 'reks_stat', 1, 'Active'            UNION ALL
SELECT 'cost_type', 0, 'Office'            UNION ALL
SELECT 'cost_type', 1, 'Warehouse'         UNION ALL
SELECT 'cost_type', 2, 'Store'             UNION ALL
SELECT 'cost_proc', 0, 'Not Delivery'      UNION ALL
SELECT 'cost_proc', 1, 'As Delivery'       UNION ALL
SELECT 'cost_stat', 0, 'Deactive'          UNION ALL
SELECT 'cost_stat', 1, 'Active'            UNION ALL
SELECT 'unit_stat', 0, 'Deactive'          UNION ALL
SELECT 'unit_stat', 1, 'Active'            UNION ALL
SELECT 'pool_stat', 0, 'Deactive'          UNION ALL
SELECT 'pool_stat', 1, 'Active'            UNION ALL
SELECT 'jobs_stat', 0, 'Deactive'          UNION ALL
SELECT 'jobs_stat', 1, 'Active'            UNION ALL
SELECT 'user_hris', 0, 'Not Linked'        UNION ALL
SELECT 'user_hris', 1, 'Linked'            UNION ALL
SELECT 'user_stat', 0, 'Deactive'          UNION ALL
SELECT 'user_stat', 1, 'Active'
