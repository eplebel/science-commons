#config.py
import mongo_tools as mt
import copy

db = mt.Connect("sciencecommons", "articles")

ITEMS = ['doi','year', 'title','author','affiliation','journal','editor','reviewers','abstract','keywords','stats','ev','replications','data','materials','prereg','disclosure','comments', 'dataSourceLogo', 'materialSourceLogo', 'preRegSourceLogo', 'disclSourceLogo', 'commentSourceLogo', 'replBadge', 'dataAvailBadge',  'reprodAnalBadge', 'MatAvailBadge', 'PreRegBadge', 'DisclBadge']

url = '127.0.0.1'
index_port = '9191'
article_port = '9292'

index_url = '%s:%s' (url, index_port)
article_url = '%s:%s' (url, article_port)

