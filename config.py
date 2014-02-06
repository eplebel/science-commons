#config.py
import mongo_tools as mt
import copy

db = mt.Connect("sciencecommons", "articles")
journals = mt.Connect("sciencecommons", "journals")

ITEMS = ['doi','year', 'title','author','affiliation','journalID','editor','reviewers','abstract','keywords','stats','ev','replications','data','materials','prereg','disclosure','comments', 'dataSourceLogo', 'materialSourceLogo', 'preRegSourceLogo', 'disclSourceLogo', 'commentSourceLogo']

BADGES = ['replBadge', 'dataAvailBadge', 'reprodAnalBadge', 'matAvailBadge', 'preRegBadge', 'disclBadge']

url = '127.0.0.1'
index_port = 9191
article_port = 9292

index_url = '%s:%i' % (url, index_port)
article_url = '%s:%i' % (url, article_port)

