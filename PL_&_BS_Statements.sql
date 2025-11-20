# PL STATEMENT

# Created 2 views, PL_Statement_2020_CB2 and PL_Statement_2019_CB2 to make it easier 
# PL_Statement_2020_CB2 is profit and loss statement for 2020
# PL_Statement_2019_CB2 is profit and loss statement for 2019

SELECT p.statement_section
	, p.amount
    , ifnull(concat(percentage_change, '%'), '100%') AS Difference_with_2019	# Adding % to the results and removing nulls
FROM
(
	SELECT coalesce(PL20.statement_section, PL19.statement_section) AS statement_section # Joining statement sections into one field
		,PL20.amount AS amount
		,FORMAT((((PL20.amount - PL19.amount) / PL19.amount)*100),2) AS percentage_change # Calculating the % difference btwn 2020 and 2019
	FROM PL_Statement_2020_CB2 AS PL20
	LEFT JOIN PL_Statement_2019_CB2 AS PL19		# Left join to have all the datas
		ON PL20.statement_section = PL19.statement_section
)p;

# B/S STATEMENT 

# Created 2 views, BS_2019_CB and BS_2018_CB to make it easier 
# BS_2018_CB is B/S statement for 2018
# BS_2019_CB is B/S statement for 2019

SELECT b.statement_section
	, b.Total_Balance
    , ifnull(concat(percentage_change, '%'), '100%') AS Difference_with_2018	# Adding % to the results and removing nulls
FROM
(
	SELECT coalesce(BS19.statement_section, BS18.statement_section) AS statement_section	# Joining statement sections into one field
		,BS19.Total_Balance AS Total_Balance									# Calculating the % difference btwn 2020 and 2019
		,FORMAT((((BS19.Total_Balance - BS18.Total_Balance) / BS18.Total_Balance) * 100),2) AS percentage_change
	FROM BS_2019_CB AS BS19
	LEFT JOIN BS_2018_CB AS BS18		# Left join to have all the datas
		ON BS19.statement_section = BS18.statement_section
)b;
