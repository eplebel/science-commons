#config.py
import mongo_tools as mt
import copy

db = mt.Connect("sciencecommons", "articles")

ITEMS = ['doi','year', 'title','author','affiliation','journal','editor','reviewers','abstract','keywords','stats','ev','replications','data','materials','prereg','disclosure','comments']

index_url = '97.107.137.132:9191'
article_url = '97.107.137.132:9292'

