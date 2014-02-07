#test_format

from config import *
from formatter import formatter

for row in db.table.find({'ev': {'$ne':'NA'}}):
	print row['ev'], type(row['ev'])
	print formatter['ev'](row['ev'])
