# RiPSIG-DRIPP 

Here is the *database schema* for your reference.

![Database Schema](https://i.imgur.com/OESeSOH.png)

## Updating the Database

As you probably already know, the database itself was populated via [Google Sheets](https://docs.google.com/spreadsheets/d/1ijC5O5VKvlAwS6U5ZvrhfGXDtT_HvGbSPXe7HpQ7VPM/), for ease of access and collaboration more than anything. To update the database, which was hosted on MySQL server on my personal computer, we used [this website](https://www.convertcsv.com/csv-to-sql.htm) to convert the data from the Sheets (downloaded as CSVs) into SQL CREATEs and INSERTs. The step of doing everything in sheets then manually moving them over to SQL is probably a waste of time; so if you can figure out an easier way to do it, that would be great.

## Querying the Database

For your own analyses, here are some MySQL queries that we used often.

## Database Dashboard

Dashboard.py is a simple command line based dashboard in Python that (when ran on the host computer) queries the database automatically, based on a user's input. As of now it can:
1. Show the user the full list of authors, journals, institutions, or articles,
2. Print a list of articles based on a chosen author, journal, institution, or range of years. 
> For example, I can view all the articles in *Philippine Journal of Psychology*, or all the articles between 1965 and 1975.
3. View the details about a single article from that list.
<details>
  <summary>Example details</summary>
<pre>
+----------------------------------------------+
| Article Title/s                              |
|----------------------------------------------|
| A Model for Filipino Work Team Effectiveness |
+----------------------------------------------+
abstract
This study utilized a sequential mixed method approach in developing a model for team effectiveness in Philippine organizations. In the first phase, qualitative data were
gathered to elicit the factors that were deemed important to creating effective teams. In the second phase, a survey composed of three factors identified in the first phase:
team member competencies, quality of relations, and leadership, was administered to 418 employees from 85 Filipino work teams from various sectors and industries. Results
revealed that the three significant predictors accounted for 60% of the variance in perceived team effectiveness. The proposed model of input-process-output was partially
supported. Results showed that quality of relations partially mediated the relationship of leadership and team member competence on perceived team effectiveness. The study
highlights the importance of social relations especially in the Philippine context and underscores the value of understanding team effectiveness from a cultural perspective.

+-----------------------+-----------------------------+
| Author                | Institution                 |
|-----------------------+-----------------------------|
| Cristina Alfariz      | Ateneo de Manila University |
| Mendiola Teng-Calleja | Ateneo de Manila University |
| Ma. Regina Hechanova  | Ateneo de Manila University |
| Ivan Jacob Pesigan    | University of Macau         |
+-----------------------+-----------------------------+
+----------------------------------+-------------------------+--------+-------------+
| Journal                          | ISSN                    |   Year | Page no/s   |
|----------------------------------+-------------------------+--------+-------------|
| Philippine Journal of Psychology | ISSN 2244-1298 (Online) |   2014 | 99-124      |
|                                  | ISSN 0115-3153 (Print)  |        |             |
+----------------------------------+-------------------------+--------+-------------+
+-------+-----------------------------------------------+
| DOI   | Access Link                                   |
|-------+-----------------------------------------------|
|       | https://core.ac.uk/download/pdf/335032312.pdf |
+-------+-----------------------------------------------+
</pre></details>
5. Create and write the same article details to a text file in the same directory, so that it can be accessed even after the program is closed.

This dashboard, at least in its current form, is more of a proof of concept showing off and testing the capabilities of our database structure; it is very far from being a functional tool. It is extremely basic, and does not correct for error from incorrect user input, have the ability to do complex queries (e.g. select all the articles by Fr. Bulatao in the Philippine Journal of Psychology in 1969), and it is **NOT SECURE**. Someone who knows what they're doing can ruin the database accessing it through the dashboard. [I think you can fix it if you figure out how to use this](https://www.btelligent.com/en/blog/best-practice-for-sql-statements-in-python/) and replce my f strings. You're smarter and less tired than me. In fact, I probably made more mistakes in my coding that I don't even know about, and I won't be offended if you start over from scratch.

Of course, it's also not useful because it can only run with a local MySQL server. For this to be really useful, it has to (1) work over the internet, and (2) have a GUI, probably through a website.
