# View for Profit Statement for 2020

CREATE VIEW PL_Statement_2020_CB2
AS
(SELECT z.statement_section AS statement_section
			,FORMAT((coalesce(ifnull(z.credit,0), ifnull(z.debit,0))) - (coalesce(ifnull(z.debit,0), ifnull(z.credit,0))),2) AS amount
		FROM 
		(
			SELECT ss.statement_section
				,jeli.debit
				,jeli.credit
			FROM statement_section AS ss
			INNER JOIN account AS a
				ON ss.statement_section_id = a.profit_loss_section_id
			INNER JOIN journal_entry_line_item AS jeli
				ON a.account_id = jeli.account_id
			INNER JOIN journal_entry AS je
				ON jeli.journal_entry_id = je.journal_entry_id
			WHERE ss.company_id = 1
				AND YEAR(je.entry_date) = 2020
				AND je.cancelled = 0
			GROUP BY ss.statement_section
			ORDER BY ss.statement_section_id
		) z
		        
	UNION
		
        SELECT 'NET INCOME' AS statement_section
			, (
				SELECT FORMAT((ifnull(SUM(z.credit),0) - ifnull(SUM(z.debit),0)),2) AS amount
				FROM 
				(
					SELECT ss.statement_section
						,jeli.debit
						,jeli.credit
					FROM statement_section AS ss
					INNER JOIN account AS a
						ON ss.statement_section_id = a.profit_loss_section_id
					INNER JOIN journal_entry_line_item AS jeli
						ON a.account_id = jeli.account_id
					INNER JOIN journal_entry AS je
						ON jeli.journal_entry_id = je.journal_entry_id
					WHERE ss.company_id = 1
						AND YEAR(je.entry_date) = 2020
						AND je.cancelled = 0
					GROUP BY ss.statement_section
					ORDER BY ss.statement_section_id
				) z
			) y
)
;

# View for Profit Statement for 2019

CREATE VIEW PL_Statement_2019_CB2
AS
(SELECT z.statement_section AS statement_section
			, FORMAT((coalesce(ifnull(z.credit,0), ifnull(z.debit,0))) - (coalesce(ifnull(z.debit,0), ifnull(z.credit,0))),2) AS amount
        FROM
        (
			SELECT ss.statement_section
				,jeli.debit
                ,jeli.credit
			FROM statement_section AS ss
            INNER JOIN account AS a
				ON ss.statement_section_id = a.profit_loss_section_id
			INNER JOIN journal_entry_line_item AS jeli
				ON a.account_id = jeli.account_id
			INNER JOIN journal_entry AS je
				ON jeli.journal_entry_id = je.journal_entry_id
			WHERE ss.company_id = 1
				AND YEAR(je.entry_date) = 2019
                AND je.cancelled = 0
			GROUP BY ss.statement_section
            ORDER BY ss.statement_section_id
		) z
    
    UNION
    
		SELECT 'NET INCOME' AS statement_section
			,(
				SELECT FORMAT((ifnull(SUM(z.credit),0) - ifnull(SUM(z.debit),0)),2) AS amount
                FROM
                (
					SELECT ss.statement_section
						,jeli.debit
                        ,jeli.credit
					FROM statement_section AS ss
                    INNER JOIN account AS a
						ON ss.statement_section_id = a.profit_loss_section_id
					INNER JOIN journal_entry_line_item AS jeli
						ON a.account_id = jeli.account_id
					INNER JOIN journal_entry AS je
						ON jeli.journal_entry_id = je.journal_entry_id
					WHERE ss.company_id = 1
						AND YEAR(je.entry_date) = 2019
                        AND je.cancelled = 0 
					GROUP BY ss.statement_section
                    ORDER BY ss.statement_section_id
				) z
			) y
)
