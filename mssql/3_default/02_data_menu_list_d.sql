DELETE FROM [dbo].[data_menu_list]
INSERT INTO [dbo].[data_menu_list](
       [menu_head],[menu_list],[menu_name],[menu_stat])
SELECT   '', 'AP', '01. Account Payable',    1 UNION ALL
SELECT   '', 'AR', '02. Account Receivable', 1 UNION ALL
SELECT   '', 'CB', '03. Bank Record',        1 UNION ALL
SELECT   '', 'TR', '04. Taxes Record',       1 UNION ALL
SELECT   '', 'PC', '10. Procurement',        1 UNION ALL
SELECT   '', 'FA', '11. Fixed Asset',        1 UNION ALL
SELECT   '', 'GL', '20. General Ledger',     1 UNION ALL
SELECT   '', 'MC', '98. Master Company',     1 UNION ALL
SELECT   '', 'SM', '99. System Manager',     1
