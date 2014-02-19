"""
Christian's MongoDB Tools FTW
"""

import pymongo
from pymongo import Connection
from bson import Code
import copy
import string
import glob
import os
import csv

def dictString(d):
	output = ""
	for k in d.keys():
		output += "%s_%s_" % (k, d[k])
	output = output.rstrip('_')
	return output

class Connect:
	"""
	This is a simple class to provide easy
	access to a mongo database
	"""
	def __init__(self, db="test_database", table=""):

		try:		
			self.connection = Connection()
		except:
			os.system("nohup mongod --dbpath /home/xian/ &")
		self.dbName = db
		self.db = self.connection[db]
		if table:
			self.setTable(table)
	
	def setTable(self, table):
		self.table = self.db[table]
		return self.table

def GetKeys(p):
	mr = Code("function() {for (var key in this) { emit(key, null);}}")
	r = Code("function(key, stuff) { return null;}")

	result = p.map_reduce(mr, r, "keyresults")

	keys = result.distinct("_id")

	return keys

def KeySafe(key):
	key = key.replace(".", "_")
	return key

def StringToType(value):
	if value.isdigit():
		val = int(value)

	elif value.count('.') == 1:
		try:
			val = float(value)
		except:
			val = value

		#val = value.split('.')
		#if val[0].isdigit() and val[1].isdigit():

	else:
		val = value

	return val

def strip(i):
	i = i.strip()
	i = i.replace('\t', '')
	return i

class ReadFile:
	"""
	Class to read single or a set of data files
	Args are...
	fileName (String) - name of the file, or a pattern to be globbed
	dbName (String) - name of the DB you'd like to submit this data to
	tableName (String) - name of the table you'd like to enter this data into
	clear (Boolean) - Whether or not to erase the contents of the table 
					  before uploading this data into it
	startLine (int) - The line on which the headers appear in the file
	columns (String List) - If you want to upload only specific columns
							from the data files, put the header names in this list
	sep (String) - the character which separates data in your data file
	"""
	def __init__(self, fileName, dbName, tableName, data=None, kind="", clear=False, startLine=0, columns=[], sep=",", addrow={}):

		db = Connect(dbName, tableName)
		table = db.table

		if clear:
			table.remove()

		self.table = table

		self.sep = ","

		self.startLine = startLine
		self.columns = columns

		self.addrow = addrow

		if fileName:

			if fileName.count('*'):
				self.fileList = glob.glob(fileName)
			else:
				self.fileList = [fileName]

			for myFile in self.fileList:
				lines = open(myFile, 'r').readlines()
				self.process(lines, myFile)


		else:
			self.process(data, fileName)


	def process(self, raw_lines, thefile):
		lines = []
		#remove illegal chars, convert to utf, remove whitespace
		for line in raw_lines:
			lines.append(filter(lambda x: x in string.printable, line).encode('utf8').strip())

		if lines[0] == "*** Header Start ***":
			self.processEPrime(lines)
		else:
			self.processCSV(thefile)


	def processCSV(self, thefile):
		print "Processing as CSV"
		r = csv.reader(open(thefile, 'r'))


		#get the headers, make the variables
		headers = r.next()
		headers = map(strip, headers)
		#make sure the keys are all safe
		headers = map(KeySafe, headers)

		VARs = {}
		index = {}

		for k in headers:
			if self.columns:
				if k in self.columns:
					index[k] = headers.index(k)
					VARs[k] = []
			else:
				index[k] = headers.index(k)
				VARs[k] = []

		for line in r:
			line = map(strip, line)
			row = {}
			for k in VARs.keys():
				try:
					value = line[index[k]]
					if value:
						row[k] = StringToType(value)
				except:
						print "I shat myself because of %s" % line[index[k]]

			if self.addrow:
				row = dict(row, **self.addrow)

			try:
				self.table.insert(row)
			except: 
				print "I peed myself because of %s" % row

	def processEPrime(self, lines):
		print "processing as E-Prime"


		i1 = lines.index("*** Header Start ***")
		i2 = lines.index("*** Header End ***")


		header = lines[i1+1:i2]

		info = {}

		data = {}

		for h in header:
			frags = h.split(":")
			frags = map(strip, frags)

			if self.columns:
				if frags[0] in self.columns:
					info[KeySafe(frags[0])] = StringToType(frags[1])
			else:
				info[KeySafe(frags[0])] = StringToType(frags[1])

		i1 = i2

		dataLines = lines[i1 + 1:]

		trial = 1
		row = {}
		for d in dataLines:
			for k in info.keys():
				row[k] = info[k]
			if d.count(":"):
				frags = d.split(":")
				frags = map(strip, frags)
				if self.columns:
					if frags[0] in self.columns:
						row[KeySafe(frags[0])] = StringToType(frags[1])
				else:
					row[KeySafe(frags[0])] = StringToType(frags[1])
	
			elif d == "*** LogFrame End ***":
				if row:
					row['trial'] = trial
					trial = trial + 1
					if self.addrow:
						row = dict(row, **self.addrow)
					self.table.insert(row)
				row = {}
