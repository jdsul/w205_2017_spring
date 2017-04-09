#Importing the necessary libraries
from __future__ import absolute_import, print_function, unicode_literals
from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

#Creating wordcounter class
class WordCounter(Bolt):
#Connecting to postgres
    def initialize(self, conf, ctx):
        self.conn = psycopg2.connect(database = "tcount", user = "postgres", password="pass", host = "localhost", port = "5432")
        self.cur = self.conn.cursor()
        self.counts = Counter()
#Function for the process of getting the word and updating the postgres table.
    def process(self, tup):
#Store the word as the first value in the tuple.
        word = tup.values[0]
#If the word is in postgres increment the count for the word by 1. 
        self.cur.execute("UPDATE tweetwordcount SET count = count + 1 WHERE word = %s", (word,))
#If the word is not in postgres, insert a new row for the word, set the count equal to 1. 
        if self.cur.rowcount == 0:
            self.cur.execute("INSERT INTO tweetwordcount (word, count) VALUES (%s, 1)",(word,))
#Commit the changes
        self.conn.commit()

#Increment and emit the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

#Log the count the verify the topology is running.
        self.log('%s: %s' % (word, self.counts[word]))



