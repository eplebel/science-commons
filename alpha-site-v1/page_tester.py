#page_tester.py
import mongo_tools as mt
from config import *
from formatter import formatter
from mako_defs import *

db = mt.Connect("sciencecommons", "articles")

dois = db.table.find().distinct('doi')

for doi in dois:
		row = db.table.find_one({'doi': doi})

		#format stuff, check if data present
		data = {}
	
		for item in ITEMS:
			if row.has_key(item):
				data[item] = formatter[item](row[item])
			else:
				data[item] = ''

		for badge in BADGES:
			if row.has_key(badge):
				data[badge] = formatter[badge](row[badge], badge)


		output = article_template.render(index_url = index_url, data=data)

		doi = doi.replace("/", "_")

		f = open("test_html/%s.html" % doi, "w")

		f.write(output)

		f.close()  
