"""
Update.py
Update the dang ol' database
"""

from mongo_tools import ReadFile, Connect
from collections import OrderedDict

#get the data
ReadFile("articles.csv", "sciencecommons", "articles", clear=True)

#now format the data for later use
db = Connect("sciencecommons", "articles")

#break up the stuff between the |
for row in db.table.find():
	for k in row.keys():
		#split up the stuff separated by a |
		if type(row[k]) == unicode and row[k].count('|'):
			row[k] = row[k].split('|')
	
		print k

	db.table.save(row)
		
#format the stats pile
for row in db.table.find({'stats' : {'$exists':True}}):
	stats = []
	for stat in row['stats']:
		d = OrderedDict()
		st = stat.split(',')
		for s in st:
			k = s.split('=')[0].strip()
			v = s.split('=')[1].strip()
			d[k] = v
		stats.append(d)
	row['stats'] = stats
	db.table.save(row)


