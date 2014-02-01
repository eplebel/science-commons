#config.py

ITEMS = ['doi','title','author','affiliation','journal','editor','reviewers','abstract','keywords','stats','ev','replicability','data','materials','prereg','disclosure','comments']

def dummy(x):
	return x


def keywords(kw):
	output = ""
	for kw in kw.split(','):
		output += "<a href='#'>%s</a>, " % kw
		output.rstrip(", ")
	return output

formatter = dict.fromkeys(ITEMS, dummy)
formatter['keywords'] = keywords


