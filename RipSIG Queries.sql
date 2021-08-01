-- Per Decade Stats (Find and replace the years to the years you need)
SELECT * FROM
(SELECT COUNT(article_id) AS 'Total Articles' FROM article WHERE year BETWEEN 2010 AND 2021) sub2, 
(SELECT COUNT(DISTINCT journal.journal_id) AS '# of Journals' FROM journal JOIN article ON journal.journal_id = article.journal_id WHERE article.year BETWEEN 2010 AND 2021) sub3,
(SELECT COUNT(DISTINCT relationship.author_id) AS '# of Authors' FROM relationship JOIN article ON relationship.article_id = article.article_id WHERE article.year BETWEEN 2010 AND 2021) sub4,
(SELECT COUNT(DISTINCT relationship.author_id) AS 'Male Authors' FROM relationship JOIN article ON relationship.article_id = article.article_id JOIN author ON relationship.author_id = author.author_id
WHERE author.gender = 'male' AND article.year BETWEEN 2010 AND 2021) sub4_1,
(SELECT COUNT(DISTINCT relationship.author_id) AS 'Female Authors' FROM relationship JOIN article ON relationship.article_id = article.article_id JOIN author ON relationship.author_id = author.author_id
WHERE author.gender = 'female' AND article.year BETWEEN 2010 AND 2021) sub4_2,
(SELECT COUNT(DISTINCT relationship.author_id) AS 'Gender Unknown' FROM relationship JOIN article ON relationship.article_id = article.article_id JOIN author ON relationship.author_id = author.author_id
WHERE author.gender = 'unsure' AND article.year BETWEEN 2010 AND 2021) sub4_3,
(SELECT COUNT(DISTINCT relationship.inst_id) AS '# of Institutions' FROM relationship JOIN article ON relationship.article_id = article.article_id WHERE article.year BETWEEN 2010 AND 2021) sub5,
(SELECT COUNT(article_id) AS '# of Qualitative Articles' FROM article WHERE year BETWEEN 2010 AND 2021 AND methodology = 'qualitative') sub6,
(SELECT COUNT(article_id) AS 'Quantitative' FROM article WHERE year BETWEEN 2010 AND 2021 AND methodology = 'quantitative') sub7,
(SELECT COUNT(article_id) AS 'Mixed Methods' FROM article WHERE year BETWEEN 2010 AND 2021 AND methodology = 'mixed') sub8,
(SELECT COUNT(article_id) AS 'Other' FROM article WHERE year BETWEEN 2010 AND 2021 AND methodology = 'other') sub9;

-- institution count by location (edit 'system' to either 'NCR', 'foreign' or 'outside' to find the count of those respectively, or remove the line for overall)
-- you can also replace said line with a WHERE article.year BETWEEN if you join with article
SELECT COUNT(*) FROM
(SELECT institution.inst_id, institution.inst_name FROM relationship JOIN institution ON relationship.inst_id = institution.inst_id 
WHERE institution.location = 'system' 
GROUP BY relationship.inst_id
HAVING COUNT(article_id)>3) sub1;


--TOP TEN JOURNALS
SELECT COUNT(article_name), journal.journal_name
FROM article
JOIN journal ON article.journal_id = journal.journal_id
GROUP BY article.journal_id
ORDER BY COUNT(*) DESC
LIMIT 10;

-- TOP TEN INSTITUTIONS BY ARTICLES (ommit the 'WHERE article.year BETWEEN' if you want the overall top ten)
SELECT DISTINCT relationship.inst_id, SUBSTRING(institution.inst_name,1,50), COUNT(DISTINCT relationship.article_id, relationship.inst_id)
FROM relationship
JOIN institution ON relationship.inst_id = institution.inst_id
JOIN article ON relationship.article_id = article.article_id
WHERE article.year BETWEEN 1960 AND 1969
GROUP BY relationship.inst_id
ORDER BY COUNT(DISTINCT relationship.article_id, relationship.inst_id) DESC
LIMIT 10;
