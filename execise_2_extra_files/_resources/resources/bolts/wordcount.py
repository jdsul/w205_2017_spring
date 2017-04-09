from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

#Things to think absolute_import
#1 what do we need to import on libraries
#2 what do we need to go into initialization
#initialization run once, process once for every word that comes through
#3 what do we need to go into process?



class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.conn = psycopg2.connect(database = "tcount", user = "postgres", password="pass", host = "localhost", port = "5432")
        self.cur = self.conn.cursor()

        self.counts = Counter()




    def process(self, tup):
        word = tup.values[0]
        #then update the db. The last thing needs a comma because it needs a list
        self.cur.execute("UPDATE tweetwordcount SET count = count + 1 WHERE word = %s", (word,))
        #Adding a row if the word is not there
        if self.cur.rowcount == 0:
            self.cur.execute("INSERT INTO tweetwordcount (word, count) VALUES (%s, 1)",(word,))
        self.conn.commit()

        #Then do the commit of the new word

#down here we need to grab the cursor, update, if it doesn't update commit a new row
########Everything comes back in unicode, which could be a PITA. If you get compatibility errors, you can use str(word)
#to convert it to a regular string
        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
#don't use the concatenation operation, use what's in the other file with the comma space
#get the code working then come back for some checks to make it fault tolerant
        self.log('%s: %s' % (word, self.counts[word]))


