#test_format

from config import *
from formatter import formatter

dois = db.table.find().distinct("doi")

for doi in dois:
	print formatter['stats'](doi)

	print "\n\n"
