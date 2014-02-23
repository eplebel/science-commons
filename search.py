import mongo_tools as mt

s = raw_input('What? --->')

authors = mt.Connect('sciencecommons').setTable('authors')
journals = mt.Connect('sciencecommons').setTable('journals') 
articles = mt.Connect('sciencecommons').setTable('articles')

#parse the search string in spaces

s = s.split(' ')

#find dois matching anything along the specified lines
dois = {'author':[], 'journal':[], 'year':[], 'keywords':[], 'title':[]}

#first check for authors and years
r = []
for search in s:
	#is this a number
	if search.isdigit():
		year = int(search)
		if year > 1990 and year <= 2014:
			#search articles for pubyear
			for row in articles.find({'year':year}):
				dois['year'].append(row['doi'])

			#remove the pub year from the search terms
			r.append(search)

	else:
		#else look for an author

		for auth_row in authors.find({'lastName': { '$regex': "^%s" % search, '$options': '-i' }}):
			for row in articles.find({'authorIDs' : {'$all': [auth_row['authorID']]}}):
				dois['author'].append(row['doi'])

			#remove the author name from the search terms
			r.append(search)

for rem in r:
	s.remove(rem)	
r = []

#now attempt to look for a journal name in the search string
for search in s:
	regex = { '$regex': "^%s" % search, '$options': '-i' }

	#look for matches in acronyms
	for journal_row in journals.find({'acronym' : regex}):
		#search articles by journal
		for row in articles.find({'journalID':journal_row['journalID']}):
			dois['journal'].append(row['doi'])

		#remove journal acronym from the search terms
		r.append(search)

	#look for matches in journal titles:
	regex = {'$regex': "/.*%s.*/" % search, '$options' : '-i' }

	print regex
	for journal_row in journals.find({'journalName': regex }):
		print journal_row
		#search articles by journal
		for row in articles.find({'journalID':journal_row['journalID']}):
			dois['journal'].append(row['doi'])

		#remove journal acronym from the search terms
		r.append(search)

for rem in r:
	s.remove(rem)	
r = []



#now attempt to find the rest of the string in the keywords or the journal title
for search in s:
	for row in articles.find({'keywords' : '/%s/' % search}):
		doi['keywords'].append(row['doi'])

	for row in articles.find({'title' : '/%s/' % search}):
		doi['title'].append(row['doi'])

#now go through the dois and see which ones are the most popular
doi_list = []

for key in dois.keys():
	uniques = list(set(dois[key]))
	dois[key] = uniques
	doi_list += uniques

doi_list = list(set(doi_list))

print dois
print doi_list	

	
	


