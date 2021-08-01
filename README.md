# RiPSIG-DRIPP 

Here is the *database schema* for your reference.

![Database Schema](https://i.imgur.com/OESeSOH.png)

## Updating the Database

As you probably already know, the database itself was populated via [Google Sheets](https://docs.google.com/spreadsheets/d/1ijC5O5VKvlAwS6U5ZvrhfGXDtT_HvGbSPXe7HpQ7VPM/), for ease of access and collaboration more than anything. To update the database, which was hosted on MySQL server on my personal computer, we used [this](https://www.convertcsv.com/csv-to-sql.htm) website to convert the data from the Sheets (downloaded as CSVs) into SQL commands. The step of doing everything in sheets then manually moving them over to SQL is probably a waste of time; so if you can figure out an easier way to do it, that would be great.

## Querying the Database

For your own analyses, here are some MySQL queries that we used often.

## Database Dashboard

We created a very simple command line based dashboard in Python that would query the database automatically, based on a user's input. As of now it can:
1. Show the user the full list of authors, journals, institutions, or articles,
2. Print a list of articles based on a chosen author, journal, institution, or range of years. 
> For example, I can view all the articles in *Philippine Journal of Psychology*, or all the articles between 1965 and 1975.
3. View the details about a single article from that list, including the article's full title, abstact, authors, journal, page number, and access link.
4. 
