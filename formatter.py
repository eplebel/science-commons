#formatter.py
from config import *

def dummy(x):
	if x == 'NA':
		return 'Unknown '
	else:
		return x

def author(authorIDs):
	output = ""

	for ID in authorIDs:
		try:
			auth = authors.table.find_one({'authorID' : int(ID)})
			first = auth['firstName']
			last = auth['lastName']
			middle = auth['initials']
			if middle != "NA":
				output += "%s, %s %s, " % (last, first, middle)
			else:
				output += "%s, %s, " % (last, first)
		except:
			pass

	output = output.rstrip(", ")

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

def statistics(doi):
	output = ""
	for row in stats.table.find({'doi':doi}).sort('study'):		
		n, effect, power = stat_line(doi, row['study'])
		output += "<div>Study %s: &nbsp; %s, &nbsp;%s, &nbsp;%s</div>\n" % (row['study'], n, effect, power)

	return output

def stat_line(doi,study):
	row = stats.table.find_one({'doi':doi, 'study':study})
	n = "N = %s" % row['n']
	effect = "%s = %s" % (row['effectType'], row['effectSize'])
	power = "power = %s" % (row['power']) + "%"
	return n, effect, power

"""
def stats(kw, rep=False):
	output = ""
	if kw != "NA":
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
"""

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

		#this is the doi of the paper that is the replication
		row = db.table.find_one({'doi':doi})
		if row:
			#repLink - parent study, child study, type of replication
			repLink = row['repLink']			
			journal = "<span class='label label-default'>%s</span>" % formatter['journalID'](row['journalID'])[1]
			author = formatter['authorIDs'](row['authorIDs'])

			for rep in repLink:
				parent = rep[0]
				child = rep[1]
				rep_type = label[rep[2]-1]
				n, effect, power = stat_line(doi, child)
				stats = "<td>%s</td><td>%s</td><td>%s</td>" % (n, effect, power)
				author = "<a href='http://%s?doi=%s'>%s</a>" % (article_url, doi, author)
				repList[rep[0]-1].append([journal, author, stats, rep_type])

	count = 1
	output = "<table class='table table-condensed'><tbody>"

	for item in repList:
		output += "<tr><td colspan='6'>Of Study %i:</td></tr>" % count

		for i in item:
			output += "<tr><td>%s</td><td>%s</td><td><span class='label label-info'>%s</span><td>%s</td></td></tr>\n" % (i[0], i[1], i[3], i[2])
		count +=1 

	output += "</tbody></table>"

	return output

def materials(m):
	output = ""

	if m != "NA":
		if type(m) != list:
			m = [m]
		count = 1
		for mats in m:
			output += "<p class='tab'>For study %i:</p>" % count
			output += "<ul><ul>"
			for item in mats.split(','):
				output += "<li>%s</li>" %  item.strip()
			count += 1
			output += "</ul></ul>"
			

	else:
		output = NA

	return output

def disclosure(d):
	output = ""
	if d != "NA":
		output += "<ol><ol>"
		for disc in d:
			output += "<li>%s</li>" % disc
		output += "</ol></ol>"

	return output

def comment(doi):
	output = ""
	doi = doi.strip()
	output += "<table>"

	count = comments.table.find({'doi':doi}).count()

	for row in comments.table.find({'doi':doi}).sort('date'):
		print row
		output += "<tr>\n"
		output += "<td style='vertical-align:middle'><img src='http://%s/logos/%s' width='100px'/></td>\n" % (url, row['img'])
		output += "<td><strong>%s</strong> &nbsp; &nbsp; %s <br/> %s <br/><a href='%s'>%s</a></td> \n" % (row['author'], row['date'], row['text'], row['link'], row['linkText'])
		output += "</tr>"
	
	output += "</table>"
	
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
formatter['stats'] = statistics
formatter['authorIDs'] = author
formatter['affiliation'] = author
formatter['replications'] = replications
formatter['materials'] = materials
formatter['data'] = materials
formatter['prereg'] = materials
formatter['journalID'] = journalID
formatter['disclosure'] = disclosure
formatter['reviewers'] = reviewers
formatter['comments'] = comment

for logo in ['dataSourceLogo', 'materialSourceLogo', 'preRegSourceLogo', 'disclSourceLogo', 'commentSourceLogo']:
	formatter[logo] = image

for b in BADGES:
	formatter[b] = badge
