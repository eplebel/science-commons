#formatter.py
from config import *

def dummy(x):
	if x == 'NA':
		return 'Unknown '
	else:
		return x

def author(a):
	output = ""

	if type(a) == list:
		for author in a:
			output += "%s, " % author.strip()
		output.rstrip(', ')

	else:
		output = a

	return output

def reviewers(r):
	output = ""
	if reviewers != "NA":
		if type(r) != list:
			r = [r]
		count = 1
		for reviewer in r:
			output += "<b>Reviewer %i:</b> <i>%s</i>, " % (count, reviewer)
			count += 1

	output = output.rstrip(', ')

	return output

def stats(kw, rep=False):
	output = ""
	count = 1
	if type(kw) != list:
		kw = [kw]

	for study in kw:
		if not rep:
			output += "Study %i: " % count
		print study
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

	for rep in reps:
		doi = rep.strip()

		row = db.table.find_one({'doi':doi})
		if row:
			repLink = row['repLink']
			stats = row['stats']
			journal = "<span class='label label-default'>%s</span>" % formatter['journalID'](row['journalID'])[1]
			author = formatter['author'](row['author'])
			for rep in repLink:
				author = "<a href='http://%s?doi=%s'>%s</a>" % (article_url, doi, author)
				repList[rep[0]-1].append([journal, author, formatter['stats'](stats[rep[1]-1], rep=True), label[rep[2]-1]])

	count = 1
	output = "<table class='table table-condensed'><tbody>"


	for item in repList:
		output += "<tr><td colspan='6'>Of Study %i:</td></tr>" % count

		for i in item:
			output += "<tr><td>%s</td><td>%s</td><td>type: <span class='label label-default'>%s</span><td>%s</td></td></tr>\n" % (i[0], i[1], i[3], i[2].rstrip('<br/>'))
		count +=1 

	output += "</tbody></table>"

	return output

def materials(m):
	output = ""

	if m != "NA":
		count = 1
		for mats in m:
			output += "<p class='tab'>For study %i:</p>" % count
			output += "<ul><ul>"
			for item in mats.split(','):
				output += "<li>%s</li>" %  item.strip()
			count += 1
			output += "</ul></ul>"
			

	else:
		output = "<i>None yet identified or posted.</i>"

	return output

def disclosure(d):
	output = ""
	if d != "NA":
		output += "<ol><ol>"
		for disc in d:
			output += "<li>%s</li>" % disc
		output += "</ol></ol>"

	return output

def comments(c):
	output = ""
	if c != "NA":
		output += "<table class='table table-striped'><tbody>"

		if type(c) != list:
			c = list(c)
		for comment in c:
			output += "<tr>%s<br/></tr>" % comment

		output += "</tbody></table>"

	return output

def explanatory_value(ev):
	output = ""
	if ev != "NA":
		pass
	return output

def image(i):
	output = ""
	if i != "NA":
		output = "<img src='http://%s/logos/%s' width='50' class='pull-left'/>" % (url, i)
	return output

def journalID(j):
	output = ""
	journal = journals.table.find_one({'journalID' : j})
	if journal:
		output = [journal['journalName'], journal['acronym']]

	return output

def badge(b, field):
	output = ""
	d ={}
	d['replBadge'] = 'badgeReplFindings'
	d['dataAvailBadge'] = 'badgeOpenData'
	d['reprodAnalBadge'] = 'badgeReprodAnal'
	d['matAvailBadge'] = 'badgeOpenMat'
	d['preRegBadge'] = 'badgeRegStudy'
	d['disclBadge'] = 'badgeDisclMethods'

	if b == 1:
		output = "<img src='http://%s/logos/%s.png' width = '50'>" % (url, d[field])
	else:
		output = "<img src='http://%s/logos/badgeBlank.png' width = '50'>" % (url)

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
formatter['journalID'] = journalID
formatter['disclosure'] = disclosure
formatter['ev'] = stats
formatter['reviewers'] = reviewers
formatter['comments'] = comments

for logo in ['dataSourceLogo', 'materialSourceLogo', 'preRegSourceLogo', 'disclSourceLogo', 'commentSourceLogo']:
	formatter[logo] = image

for b in BADGES:
	formatter[b] = badge
