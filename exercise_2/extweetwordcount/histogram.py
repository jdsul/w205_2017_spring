import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

#Store the arguments passed into the function as a string.
highlow = sys.argv[1]

#Store the upper and lower bounds
lowerbound = highlow.split(",")[0]
upperbound = highlow.split(",")[1]


#Establish a connection to Postgres
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

#SQL to select all words and their counts if the count is between the upper and lower bound.
cur.execute("SELECT word, count FROM tweetwordcount WHERE count >= %s AND count <= %s ORDER BY count ASC;", (lowerbound,upperbound,))
records = cur.fetchall()
#Print statment printing all the words returned by the previous select statement.
for rec in records:
   print rec[0], ":", rec[1], "\n"
#Closing the connection.
conn.close()
