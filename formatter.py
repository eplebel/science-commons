#formatter.py
from config import *

def dummy(x):
	if x == 'NA':
		return 'Unknown '
	else:
		return x

def repLink(repLink):
	pass	

def author(a):
	output = ""

	if type(a) == list:
		for author in a:
			output += "%s, " % author.strip()
		output.rstrip(', ')

	else:
		output = a

	return output

def stats(kw, rep=False):
	output = ""
	count = 1
	if type(kw) != list:
		kw = [kw]

	for study in kw:
		if not rep:
			output += "Study %i: " % count
		for k in study.keys():
			val = study[k]
			if k == 'power':
				val = str(study[k]) + '%'
			output += "%s = %s, " % (k, val)
		output = output.rstrip(', ')
		output += "<br/>"
		count += 1

	return output


def keywords(kw):
	output = ""
	for kw in kw.split(','):
		output += "<a href='#'>%s</a>, " % kw
		output.rstrip(", ")
	return output

def replications(reps):
	label = ['Very Close', 'Fairly Close', 'Close', 'Unknown']

	num_studies = db.table.find_one({'replications':reps})['numStudies']

	repList = []
	for i in range(num_studies):
		repList.append(copy.deepcopy([]))


	print reps
	for rep in reps:
		doi = rep.strip()

		row = db.table.find_one({'doi':doi})
		if row:
			repLink = row['repLink']
			stats = row['stats']
			journal = formatter['journal'](row['journal'])
			author = formatter['author'](row['author'])
			for rep in repLink:
				url = "<a href='http://%s?doi=%s'>go to paper</a>" % (article_url, doi)
				repList[rep[0]-1].append([journal, author, formatter['stats'](stats[rep[1]-1], rep=True), label[rep[2]-1], url])

	count = 1
	output = ""

	for item in repList:
		output += "<h3>Study %i</h3>\n" % count
		for i in item:
			output += "%s, %s, %s, type: %s, %s<br/>\n" % (i[0], i[1], i[2].rstrip('<br/>'), i[3], i[4])
		count +=1 

	return output

def materials(m):
	output = ""

	if m != "NA":
		count = 1
		for mats in m:
			output += "<h5>For study %i:</h5>" % count
			output += "<ul>"
			for item in mats.split(','):
				output += "<li>%s</li>" %  item.strip()
			count += 1
			output += "</ul>"

	return output

def disclosure(d):
	output = ""
	if d != "NA":
		for disc in d:
			output += "<p>%s</p>" % disc

	return output

def comments(c):
	output = ""
	if c != "NA":
		output = c

	return output

formatter = dict.fromkeys(ITEMS, dummy)
formatter['keywords'] = keywords
formatter['stats'] = stats
formatter['author'] = author
formatter['affiliation'] = author
formatter['replications'] = replications
formatter['materials'] = materials
formatter['data'] = materials
formatter['prereg'] = materials
formatter['comments'] = comments
