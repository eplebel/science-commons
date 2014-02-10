"""
Update.py
Update the dang ol' database
"""

from mongo_tools import ReadFile, Connect
import time

db = Connect("sciencecommons", "articles")

#get the data
print "Uploading articles.csv"
ReadFile("articles.csv", "sciencecommons", "articles", clear=True)
print "Uploading journals.csv"
ReadFile("journals.csv", "sciencecommons", "journals", clear=True)
print "Uploading comments.csv"
ReadFile("comments.csv", "sciencecommons", "comments", clear=True)
print "Uploading stats.csv"
ReadFile("stats.csv", "sciencecommons", "stats", clear=True)
print "Uploading authors.csv"
ReadFile("authors.csv", "sciencecommons", "authors", clear=True)

time.sleep(1)

#now format the data for later use

#break up the stuff between the |
for row in db.table.find():
	for k in row.keys():
		#split up the stuff separated by a |
		if type(row[k]) == unicode and row[k].count('|'):
			row[k] = row[k].split('|')
	
	db.table.save(row)

"""		
#format the stats pile
for row in db.table.find({'stats' : {'$ne':'NA'}}):
	stats = []
	for stat in row['stats']:
		try:
			stats.append(eval(stat))
		except:
			raise(Exception("Stats Field Update Error : Cannot parse %s into dictionary format" % stat))
	row['stats'] = stats
	db.table.save(row)


#format the EV pile
for row in db.table.find({'ev' : {'$ne':'NA'}}):
	evs = []
	for ev in row['ev']:
		try:
			evs.append(eval(ev))
		except:
			raise(Exception("EV Field Update Error : Cannot parse %s into dictionary format" % ev))
	row['ev'] = evs
	db.table.save(row)
"""

#format the author pile
for row in db.table.find():
	row['authorIDs'] = row['authorIDs'].split(',')
	db.table.save(row)


#format the replication stuff
for row in db.table.find({'repLink' : {'$ne': 'NA'}}):
	try:
		reps = eval(row['repLink'])
	except:
		raise(Exception("Replication Field Update Error : Cannot parse %s into dictionary format" % rep))
	row['repLink'] = reps
	db.table.save(row)



