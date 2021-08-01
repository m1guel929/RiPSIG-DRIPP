# Using the packages "mysql-connector-python" and "tabulate"
import mysql.connector
from tabulate import tabulate

# Prints table using tabulate
def print_table(query,style):
    mycursor = mydb.cursor()
    mycursor.execute(query)
    myresult = mycursor.fetchall()
    field_names = [i[0] for i in mycursor.description]
    print(tabulate(myresult,headers = field_names, tablefmt=style))

# Same as above function, but writes to file instead of printing
def save_table(query,style,filename):
    f = open(filename + ".txt", "a")
    mycursor = mydb.cursor()
    mycursor.execute(query)
    myresult = mycursor.fetchall()
    field_names = [i[0] for i in mycursor.description]
    f.write(tabulate(myresult,headers = field_names, tablefmt=style))
    f.write("\n")
    f.close()

## Prints all relevant info about a selected article
def print_article_info(article):
    # Title
    print_table(f"SELECT article_name AS 'Article Title/s' FROM article WHERE article_id= {article}", 'psql')
    # Abstract
    print_table(f"SELECT abstract FROM article WHERE article_id = {article}", 'plain')
    # Author name and institution
    print_table(f"""SELECT CONCAT(author.first_name, ' ', author.last_name) AS 'Author', inst_name AS 'Institution' FROM article 
        JOIN relationship ON relationship.article_id = article.article_id
        JOIN author ON author.author_id = relationship.author_id
        JOIN institution ON institution.inst_id = relationship.inst_id
        WHERE article.article_id = {article}""", 'psql')
    # Journal, ISSN, year of publishing, page numbers
    print_table(f"""SELECT journal.journal_name AS 'Journal', journal.ISSN AS 'ISSN', article.year AS 'Year', article.page_number AS 'Page no/s' FROM article 
        JOIN journal ON article.journal_id = journal.journal_id
        WHERE article.article_id= {article}""", 'psql')
    # DOI, access link
    print_table(f"""SELECT article.DOI AS 'DOI', article.link AS 'Access Link' FROM article
        WHERE article.article_id= {article}""", 'psql')

# Same as above function, but saves to file instead of prints
def save_article_info(article):
    filename = input("File name: ")
    save_table(f"SELECT article_name AS 'Article Title/s' FROM article WHERE article_id= {article}", 'psql', filename)
    save_table(f"SELECT abstract FROM article WHERE article_id = {article}", 'plain', filename)
    save_table(f"""SELECT CONCAT(author.first_name, ' ', author.last_name) AS 'Author', inst_name AS 'Institution' FROM article 
        JOIN relationship ON relationship.article_id = article.article_id
        JOIN author ON author.author_id = relationship.author_id
        JOIN institution ON institution.inst_id = relationship.inst_id
        WHERE article.article_id = {article}""", 'psql', filename)
    save_table(f"""SELECT journal.journal_name AS 'Journal', journal.ISSN AS 'ISSN', article.page_number AS 'Page no/s' FROM article 
        JOIN journal ON article.journal_id = journal.journal_id
        WHERE article.article_id= {article}""", 'psql', filename)
    save_table(f"""SELECT article.DOI AS 'DOI', article.link AS 'Access Link' FROM article
        WHERE article.article_id= {article}""", 'psql', filename)

# This loop prompts users to view an article by typing the article ID, then asks if they want to save it and/or view another article
def view_article_loop():
    N = -1
    first = -1
    while N == -1:
        if first == -1:
            print("If you would like to see futher information about an article, input article no.,\notherwise type 'end'.")
            first = first + 1
        else: print("If you would like to see futher information about another article, input article no.,\notherwise type 'end'.")
        articleno = input()
        if articleno == 'end':
            N = N+1
        else:
            # PRINT ARTICLE INFO
            print_article_info(articleno)
            save = input("Would you like to save this output (y/n): ")
            # SAVE ARTICLE INFO
            if save == "y":
                save_article_info(articleno)
            else:
                N = N+1

## REPLACE WITH YOUR MYSQL INFORMATION HERE
pw = input('MySQL Password: ')
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password=pw,
  database="RiPSIG"
)

print("Welcome to the RiPSIG database dashboard!")
resume = 'yes'
while resume == 'yes':
    print("Options:")
    print("(1) Articles")
    print("(2) Authors (DONT USE THIS, OPTION NOT READY)")
    print("(3) Institutions (DONT USE THIS, OPTION NOT READY)")
    print("(4) Journals (DONT USE THIS, OPTION NOT READY)")
    option = int(input("Enter option number: "))

    # ARTICLES
    if option == 1:
        print("(1) View by Author")
        print("(2) View by Institution")
        print("(3) View by Journal")
        print("(4) View by Year")
        print("(5) View All")
        option = int(input("Enter option number: "))
        
        # VIEW BY AUTHOR
        if option == 1:
            print_table("""SELECT author_id AS 'Author Number', CONCAT(first_name,' ', last_name)
                AS 'Name' FROM author ORDER BY last_name""", 'psql')
            print('Above is the list of authors;\ninput the author number to see the articles by that author.')
            author = input("Enter author number: ")
            print_table(f"""SELECT article.article_id AS 'no.', SUBSTRING(article_name, 1,100) AS 'Title',
                journal.journal_name AS 'Journal',
                year AS 'Year',
                methodology AS 'Methodology' FROM article
                JOIN journal ON journal.journal_id = article.journal_id
                JOIN relationship ON relationship.article_id = article.article_id
                JOIN author ON author.author_id = relationship.author_id
                WHERE author.author_id = {author} GROUP BY article.article_id ORDER BY year""", 'psql')
            view_article_loop()

        # VIEW BY INSTITUTION
        elif option == 2:
            print_table("SELECT inst_id AS 'Inst. No.', inst_name AS 'Institution' FROM institution ORDER BY inst_name", 'psql')
            print('Above is the list of institutions;\ninput the institution number to see the articles by that institution.')
            inst = input("Enter institution number: ")
            print_table(f"""SELECT article.article_id AS 'no.', SUBSTRING(article_name, 1,100) AS 'Title',
                journal.journal_name AS 'Journal',
                year AS 'Year',
                methodology AS 'Methodology' FROM article
                JOIN relationship ON relationship.article_id = article.article_id
                JOIN journal ON journal.journal_id = article.journal_id
                JOIN institution ON institution.inst_id = relationship.inst_id
                WHERE institution.inst_id = {inst} GROUP BY article.article_id ORDER BY year""", 'psql')
            view_article_loop()
        
        # VIEW BY JOURNAL
        elif option == 3:
            print_table("SELECT journal_id AS 'no.', journal_name AS 'Name', ISSN AS 'ISSN' FROM journal ORDER BY journal_name", 'psql')
            print('Above is the list of journals;\ninput the journal number to see the articles in that journal.')
            journal = input("Enter journal number: ")
            print_table(f"SELECT journal_id AS 'no.', journal_name AS 'Journal Name', ISSN AS 'ISSN' FROM journal WHERE journal_id = {journal}", 'psql')
            print_table(f"""SELECT article.article_id AS 'no.', SUBSTRING(article_name, 1,100) AS 'Title',
                year AS 'Year',
                methodology AS 'Methodology' FROM article
                JOIN journal ON journal.journal_id = article.journal_id
                WHERE journal.journal_id = {journal} GROUP BY article.article_id ORDER BY year""", 'psql')
            view_article_loop()
            
        # VIEW BY YEAR
        elif option == 4:
            start = input('Enter first year of search: ')
            end = input('Enter last year of search: ')
            print_table(f"""SELECT article.article_id AS 'no.', SUBSTRING(article_name, 1,100) AS 'Title',
                year AS 'Year',
                methodology AS 'Methodology' FROM article WHERE year BETWEEN {start} AND {end} ORDER BY year""", 'psql')
            view_article_loop()
            
        # VIEW ALL
        elif option == 5:
            print_table("""SELECT article.article_id AS 'no.', SUBSTRING(article_name, 1,100) AS 'Title',
                year AS 'Year',
                methodology AS 'Methodology' FROM article ORDER BY year""", 'psql')
            view_article_loop()

    print('Would you like to\n(1) Start again from the beginning, or\n(2) Exit the Database')
    exitprogram = int(input('Enter option number: '))
    if exitprogram == 1:
        continue
    elif exitprogram == 2:
        resume = 'no'
    
    # AUTHORS
    elif option == 2:
        query = "SELECT * FROM author"
