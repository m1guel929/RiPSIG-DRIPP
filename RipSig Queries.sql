-- List of articles
SELECT name AS 'Title', journal.journal_name AS 'Journal',
	vol_issue AS 'Vol/Issue', ISSN, DOI FROM articles
	JOIN journal ON journal.journal_id=articles.journal_id
	;

-- List of author
SELECT CONCAT(first_name,' ',last_name) AS 'Authors' FROM author
	ORDER BY last_name;

-- List of articles by author
SELECT name AS 'Title', journal.journal_name AS 'Journal',
	vol_issue AS 'Vol/Issue', ISSN, DOI FROM articles
	JOIN journal ON journal.journal_id=articles.journal_id
	JOIN art_auth_uni ON articles.article_id=art_auth_uni.article_id
	JOIN author ON art_auth_uni.author_id=author.author_id
-- EDIT THE FOLLOWING LINE FOR AUTHOR
	WHERE author.last_name = 'Baquiano';
	
	SELECT 	article_name AS 'Title',
			journal.journal_name AS 'Journal',
			journal.ISSN AS 'ISSN', volissue AS 'vol(issue)',
			page_number AS 'Page No.', year AS 'Year',
			methodology AS 'Methodology' FROM article 
			JOIN journal ON journal.journal_id = article.journal_id
			JOIN relationship on relationship.article_id = article.article_id
			JOIN author ON author.author_id = relationship.author_id
			WHERE author.author_id = 130;
			
			   
                article = input()
                if article == 'end':
                    N = N + 1
                else:
			            while N == -1:
                print("If you would like to see futher information about an article, input article no.,\notherwise type 'end'.")
                article = input()
                if article == 'end':
                    N = N + 1
                else:
				
				SELECT CONCAT(author.first_name, ' ', author.last_name) AS 'Author', inst_name AS 'Institution' FROM article
				JOIN relationship ON relationship.article_id = article.article_id
				JOIN author ON author.author_id = relationship.author_id
				JOIN institution ON institution.inst_id = relationship.inst_id
				WHERE article.article_id = 55;
				
-- Per Decade Stats
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

-- author count by year


-- institution count by years
SELECT COUNT(*) FROM
(SELECT institution.inst_id, institution.inst_name FROM relationship JOIN institution ON relationship.inst_id = institution.inst_id 
WHERE institution.location = 'system' 
GROUP BY relationship.inst_id
HAVING COUNT(article_id)>3) sub1;


-- journal count by year


--TOP TEN JOURNALS
SELECT COUNT(article_name), journal.journal_name
FROM article
JOIN journal ON article.journal_id = journal.journal_id
GROUP BY article.journal_id
ORDER BY COUNT(*) DESC
LIMIT 10;

-- TOP TEN INSTITUTIONS BY ARTICLES
SELECT DISTINCT relationship.inst_id, SUBSTRING(institution.inst_name,1,50), COUNT(DISTINCT relationship.article_id, relationship.inst_id)
FROM relationship
JOIN institution ON relationship.inst_id = institution.inst_id
JOIN article ON relationship.article_id = article.article_id
WHERE article.year BETWEEN 1960 AND 1969
GROUP BY relationship.inst_id
ORDER BY COUNT(DISTINCT relationship.article_id, relationship.inst_id) DESC
LIMIT 10;

-- TOP TEN AUTHORS BY ARTICLES
SELECT DISTINCT relationship.inst_id, CONCAT(author.first_name, author.last_name), COUNT(DISTINCT article_id, relationship.inst_id)
FROM relationship
JOIN author ON relationship.author_id = author.author_id
GROUP BY relationship.inst_id
ORDER BY COUNT(DISTINCT article_id, relationship.inst_id) DESC
LIMIT 10;