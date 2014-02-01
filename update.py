"""
Update.py
Update the dang ol' database
"""

from mongo_tools import ReadFile, Connect

#get the data
ReadFile("articles.csv", "sciencecommons", "articles", clear=True)

#now format the data for later use
db = Connect("sciencecommons", "articles")

for row in db.table.find():
	for k in row.keys():
		#split up the stuff separated by a |
		if type(row[k]) == unicode and row[k].count('|'):
			row[k] = row[k].split('|')
	
	db.table.save(row)
		




