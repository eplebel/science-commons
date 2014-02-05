"""
Update.py
Update the dang ol' database
"""

from mongo_tools import ReadFile, Connect
import time

#get the data
ReadFile("articles.csv", "sciencecommons", "articles", clear=True)

time.sleep(1)

#now format the data for later use
db = Connect("sciencecommons", "articles")

#break up the stuff between the |
for row in db.table.find():
	for k in row.keys():
		#split up the stuff separated by a |
		if type(row[k]) == unicode and row[k].count('|'):
			row[k] = row[k].split('|')
	
	db.table.save(row)
		
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

#format the replication stuff
for row in db.table.find({'repLink' : {'$ne': 'NA'}}):
	try:
		reps = eval(row['repLink'])
	except:
		raise(Exception("Replication Field Update Error : Cannot parse %s into dictionary format" % rep))
	row['repLink'] = reps
	db.table.save(row)

