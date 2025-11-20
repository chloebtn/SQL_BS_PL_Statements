# View for B/S Statement for 2019

CREATE VIEW BS_2019_CB
AS
(SELECT 
		BS.statement_section,
		FORMAT((IFNULL(SUM(BS.debit),0) - IFNULL(SUM(BS.credit),0)),2)	AS Total_Balance
FROM					
(
		SELECT ss.statement_section
				, jeli.debit
				, jeli.credit
		FROM journal_entry_line_item 	AS jeli		
		INNER JOIN journal_entry 		AS je
		ON jeli.journal_entry_id = je.journal_entry_id	
		INNER JOIN account 				AS a
		ON jeli.account_id = a.account_id		
		INNER JOIN statement_section 	AS ss
		ON ss.statement_section_id = a.balance_sheet_section_id  
		WHERE (a.company_id = 1 					
			AND (ss.is_balance_sheet_section <> 0  	
            AND (YEAR(je.entry_date) = 2019  		
            AND je.cancelled = 0)))					
		 ORDER BY je.entry_date DESC				
		) AS BS										
	
    GROUP BY BS.statement_section		

UNION			
				
SELECT 'TOTAL PASSIVE' AS statement_setion 		
		, (SELECT FORMAT((IFNULL(SUM(BS.debit),0) - IFNULL(SUM(BS.credit),0)),2)	
         FROM (																			
				SELECT ss.statement_section
					, jeli.debit
                    , jeli.credit
				FROM journal_entry_line_item 		AS jeli
				INNER JOIN journal_entry			AS je
				ON jeli.journal_entry_id = je.journal_entry_id		
				INNER JOIN account 					AS a
				ON jeli.account_id = a.account_id				
				INNER JOIN statement_section 		AS ss			
				ON ss.statement_section_id = a.balance_sheet_section_id	
				WHERE (a.company_id = 1 					
					AND (ss.is_balance_sheet_section <> 0 	
                    AND (YEAR(je.entry_date) = 2019 		
                    AND je.cancelled = 0)))					
				 ORDER BY je.entry_date DESC				
				) AS BS 									
						 WHERE statement_section = "CURRENT LIABILITIES"  
						 OR statement_section = "EQUITY") AS Total_Balance	

UNION			

SELECT 'TOTAL ACTIVE' AS statement_section
	, (SELECT FORMAT((IFNULL(SUM(BS.debit),0) - IFNULL(SUM(BS.credit),0)),2)
         FROM (
				SELECT ss.statement_section
					, jeli.debit
                    , jeli.credit
				FROM journal_entry_line_item 		AS jeli
				INNER JOIN journal_entry 			AS je
				ON jeli.journal_entry_id = je.journal_entry_id
				INNER JOIN account 					AS a
				ON jeli.account_id = a.account_id
				INNER JOIN statement_section 		AS ss
				ON ss.statement_section_id = a.balance_sheet_section_id
				WHERE (a.company_id = 1 
					AND (ss.is_balance_sheet_section <> 0 
                    AND (YEAR(je.entry_date) = 2019 
                    AND je.cancelled = 0)))
				 ORDER BY je.entry_date DESC
				) AS BS 
						 WHERE statement_section = "FIXED ASSETS"
						 OR statement_section = "CURRENT ASSETS") AS Total_Balance);
                         

# View for B/S Statement for 2018

CREATE VIEW BS_2018_CB
AS
(SELECT 
		BS.statement_section,
		FORMAT((IFNULL(SUM(BS.debit),0) - IFNULL(SUM(BS.credit),0)),2)	AS Total_Balance
FROM					
(
		SELECT ss.statement_section
				, jeli.debit
				, jeli.credit
		FROM journal_entry_line_item 	AS jeli		
		INNER JOIN journal_entry 		AS je
		ON jeli.journal_entry_id = je.journal_entry_id	
		INNER JOIN account 				AS a
		ON jeli.account_id = a.account_id		
		INNER JOIN statement_section 	AS ss
		ON ss.statement_section_id = a.balance_sheet_section_id  
		WHERE (a.company_id = 1 					
			AND (ss.is_balance_sheet_section <> 0  	
            AND (YEAR(je.entry_date) = 2018  		
            AND je.cancelled = 0)))					
		 ORDER BY je.entry_date DESC				
		) AS BS										
	
    GROUP BY BS.statement_section		

UNION			
				
SELECT 'TOTAL PASSIVE' AS statement_setion 		
		, (SELECT FORMAT((IFNULL(SUM(BS.debit),0) - IFNULL(SUM(BS.credit),0)),2)	
         FROM (																			
				SELECT ss.statement_section
					, jeli.debit
                    , jeli.credit
				FROM journal_entry_line_item 		AS jeli
				INNER JOIN journal_entry			AS je
				ON jeli.journal_entry_id = je.journal_entry_id		
				INNER JOIN account 					AS a
				ON jeli.account_id = a.account_id				
				INNER JOIN statement_section 		AS ss			
				ON ss.statement_section_id = a.balance_sheet_section_id	
				WHERE (a.company_id = 1 					
					AND (ss.is_balance_sheet_section <> 0 	
                    AND (YEAR(je.entry_date) = 2018 		
                    AND je.cancelled = 0)))					
				 ORDER BY je.entry_date DESC				
				) AS BS 									
						 WHERE statement_section = "CURRENT LIABILITIES"  
						 OR statement_section = "EQUITY") AS Total_Balance	

UNION			

SELECT 'TOTAL ACTIVE' AS statement_section
	, (SELECT FORMAT((IFNULL(SUM(BS.debit),0) - IFNULL(SUM(BS.credit),0)),2)
         FROM (
				SELECT ss.statement_section
					, jeli.debit
                    , jeli.credit
				FROM journal_entry_line_item 		AS jeli
				INNER JOIN journal_entry 			AS je
				ON jeli.journal_entry_id = je.journal_entry_id
				INNER JOIN account 					AS a
				ON jeli.account_id = a.account_id
				INNER JOIN statement_section 		AS ss
				ON ss.statement_section_id = a.balance_sheet_section_id
				WHERE (a.company_id = 1 
					AND (ss.is_balance_sheet_section <> 0 
                    AND (YEAR(je.entry_date) = 2018 
                    AND je.cancelled = 0)))
				 ORDER BY je.entry_date DESC
				) AS BS 
						 WHERE statement_section = "FIXED ASSETS"
						 OR statement_section = "CURRENT ASSETS") AS Total_Balance);
