--total billionaires
SELECT * 
FROM ['Billionares Project$'];


--billionaires in each industry
SELECT COUNT(name)AS total_in_industry, industry
FROM ['Billionares Project$']
GROUP BY industry
ORDER BY total_in_industry DESC;


--self made status
SELECT COUNT(name) AS count, self_made
FROM ['Billionares Project$']
GROUP BY self_made;


--number of billionares per country
SELECT DISTINCT [country_of _residence], COUNT(name) AS number_of_billionaires
FROM ['Billionares Project$']
WHERE [country_of _residence] IS NOT NULL
GROUP BY [country_of _residence]
ORDER BY number_of_billionaires DESC


--popular gender
SELECT COUNT(name)AS count, gender
FROM ['Billionares Project$']
GROUP BY gender;


--population of billionares by region
SELECT COUNT(*) AS count, region
FROM ['Billionares Project$']
WHERE region IS NOT NULL
GROUP BY region;

--top billionaires in each country
WITH ranked_billionaires AS(
SELECT 
    net_worth, 
	name, 
	[country_of _residence],
	--ROW_NUMBER() OVER (PARTITION BY [country_of _residence] ORDER BY net_worth DESC)
	RANK() OVER(PARTITION BY [country_of _residence] ORDER BY net_worth DESC) AS rank_of_billionaire
FROM ['Billionares Project$']
WHERE [country_of _residence] IS NOT NULL
AND net_worth IS NOT NULL
)
SELECT 
    net_worth,
	name, 
	[country_of _residence]
FROM ranked_billionaires
WHERE rank_of_billionaire = 1
ORDER BY net_worth DESC


--total count of females in each industry
SELECT COUNT(name) AS count,industry
FROM['Billionares Project$']
WHERE gender = 'F' 
GROUP BY industry
ORDER BY count DESC


--total count of males in each industry
SELECT COUNT(name) AS count,industry
FROM['Billionares Project$']
WHERE gender = 'M' 
GROUP BY industry
ORDER BY COUNT(name) DESC


--top female billionaire
WITH female_billionaires AS(
SELECT DISTINCT net_worth, name, industry, age, [country_of _residence], self_made ,ROW_NUMBER() OVER(ORDER BY net_worth DESC) AS rank_no
FROM ['Billionares Project$']
WHERE gender = 'F' 
--AND [country_of _residence]='United States'
--ORDER BY net_worth DESC
)
select name
FROM female_billionaires
WHERE rank_no = 1


--top male billionare
SELECT TOP 1 name
FROM ['Billionares Project$']
WHERE gender = 'M' 
--AND [country_of _residence]='United States'
ORDER BY net_worth DESC




