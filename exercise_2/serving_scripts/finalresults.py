#Importing the necessary packages
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

#Test if no words were passed as arguments.
if len(sys.argv) != 2:
#Connect to postgres
    conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
    cur = conn.cursor()
#Select statement that returns all words in Postgres, ordered alphabetically
    cur.execute("SELECT word, count FROM tweetwordcount ORDER BY word ASC")
    records = cur.fetchall()
#Prints all records.
    for rec in records:
        print (rec[0], rec[1]), "\n"
#Closes the connection
    conn.close()

#If there is a word entered, store it in the variable word.
word = sys.argv[1]

#Establish a connection to Postgres
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

#SQL to select the word and it's count
cur.execute("SELECT word, count FROM tweetwordcount WHERE word = %s;", (word,))
records = cur.fetchall()
#Print statment telling you how many times the word is in Postgres.
for rec in records:
   print "There were", rec[1], "occurences of", rec[0], "in the stream."
#Closing the connection.
conn.close()

