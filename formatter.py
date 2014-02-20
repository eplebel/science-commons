#formatter.py
from config import *

def dummy(x):
	if x == 'NA':
		return 'Unknown '
	else:
		return x

def article_list(rows):
	output = "<div class='list-group'>"
	for row in rows:
		url = 'http://%s?doi=%s' % (article_url, row['doi'])
		title = row['title']
		author = formatter['authorIDs'](row['authorIDs'], short=True)
		year = row['year']

		output += """
			<a href='%s' class="list-group-item">                        
			<h4 class="list-group-item-heading">%s</h4>
			<p class="list-group-item-text">%s (%s)</p></a>""" % (url, title, author, year)

	output += "</div>"
	return output 

def author(authorIDs, short=False):
	output = ""

	n = len(authorIDs)

	if not short:
		for ID in authorIDs:
			i = authorIDs.index(ID)
			last = False
			if i == (n - 1):
				last = True

			if last and (n != 1):
				output = output.rstrip(", ")
				output += " &amp; "
			auth = authors.table.find_one({'authorID' : ID})
			first = auth['firstName']
			last = auth['lastName']
			middle = auth['initials']
			if middle != "NA":
				output += "%s, %s.%s, " % (last, first[0], middle)
			else:
				output += "%s, %s., " % (last, first[0])
	else:

		if n > 2:
			auth = authors.table.find_one({'authorID' : int(authorIDs[0])})
			output += "%s et al." % auth['lastName']
		elif n == 2:
			auth1 = authors.table.find_one({'authorID' : int(authorIDs[0])})
			auth2 = authors.table.find_one({'authorID' : int(authorIDs[1])})
			output += "%s &amp; %s" % (auth1['lastName'], auth2['lastName'])
		else:
			auth = authors.table.find_one({'authorID' : int(authorIDs[0])})
			output += "%s" % auth['lastName']


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
		output += "<div>Study %s: &nbsp; %s, &nbsp;%s, &nbsp;%s</div>\n" % (row['study'], n, power, effect)
	
	return output

def stat_line(doi,study):
	row = stats.table.find_one({'doi':doi, 'study':study})
	n = "N = %s" % row['n']
	effect = "%s = %s" % (row['effectType'], row['effectSize'])
	power = "power = %s" % (row['power']) + "%"
	return n, effect, power

def keywords(kw):
	output = ""
	for kw in kw.split(','):
		output += "<a href='#'>%s</a>, " % kw
		output.rstrip(", ")
	return output

def replications(reps):
	label = ['Very Close', 'Fairly Close', 'Close', 'Unknown']

	#ping the original study we are currently generating a page for
	num_studies = db.table.find_one({'replications':reps})['numStudies']

	repList = []
	for i in range(num_studies):
		repList.append(copy.deepcopy([]))

	if type(reps) != list:
		reps = [reps]


	for rep in reps:
		doi = rep.strip()

		#this is the doi of the paper that is the replication
		row = db.table.find_one({'doi':doi})
		if row:
			#repLink - parent study, child study, type of replication
			repLink = row['repLink']			
			journal = "<span class='label label-default'>%s</span>" % formatter['journalID'](row['journalID'])[1]
			author = formatter['authorIDs'](row['authorIDs'], short=True)

			for rep in repLink:
				parent = rep[0]
				child = rep[1]
				rep_type = label[rep[2]-1]
				n, effect, power = stat_line(doi, child)
				stats = "<td>%s</td><td>%s</td><td>%s</td>" % (n, power, effect)
				auth_url = "<a href='http://%s?doi=%s'>%s</a>" % (article_url, doi, author)
				repList[rep[0]-1].append([journal, auth_url, stats, rep_type])

	count = 1
	output = "<table class='table table-condensed'><tbody>"

	for item in repList:
		if len(item):
			output += "<tr><td colspan='6'>Of Study %i:</td></tr>" % count

		for i in item:
			output += "<tr><td>%s</td><td>%s</td><td><span class='label label-info'>%s</span></td>%s</tr>\n" % (i[0], i[1], i[3], i[2])
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
	output += "<table class='table table-striped'>"

	count = comments.table.find({'doi':doi}).count()

	for row in comments.table.find({'doi':doi}).sort('date'):
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
	d['dataAvailBadge'] = 'badgeAvailData'
	d['reprodAnalBadge'] = 'badgeReprodAnal'
	d['matAvailBadge'] = 'badgeAvailMat'
	d['preRegBadge'] = 'badgePreRegAnal'
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
formatter['article_list'] = article_list

for logo in ['dataSourceLogo', 'materialSourceLogo', 'preRegSourceLogo', 'disclSourceLogo', 'commentSourceLogo']:
	formatter[logo] = image

for b in BADGES:
	formatter[b] = badge
