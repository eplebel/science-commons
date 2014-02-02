#config.py

ITEMS = ['doi','title','author','affiliation','journal','editor','reviewers','abstract','keywords','stats','ev','replicability','data','materials','prereg','disclosure','comments']

def dummy(x):
	if x == 'NA':
		return ''
	else:
		return x

def stats(kw):
	output = ""
	count = 1
	for study in kw:
		output += "Study %i: " % count
		for k in study.keys():
			output += "%s = %s, " % (k, study[k])
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

formatter = dict.fromkeys(ITEMS, dummy)
formatter['keywords'] = keywords
formatter['stats'] = stats

