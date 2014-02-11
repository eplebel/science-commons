#index.py

"""
This file is part of Science Commons.

Science Commons is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Foobar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Science Commons.  If not, see <http://www.gnu.org/licenses/>.

"""

from config import *
import cherrypy
import article
from formatter import formatter
from mako_defs import index_template

class index(object):

	@cherrypy.expose
	def index(self):
		output = ""

		articles = db.table.find()

		#get the recent articles
		complete = db.table.find({'mostComplete' : {'$gte' : 1}}).sort([('mostComplete', 1)]).limit(5)
		recents = db.table.find().sort([('recentlyUpdated', -1)]).limit(5)

		complete_articles = formatter['article_list'](complete)
		recent_articles = formatter['article_list'](recents)

		"""
		#get the most updated articles
		for article in articles:
			title = article['title']
			author = formatter['authorIDs'](article['authorIDs'])
			year = article['year']
			url = "http://%s?doi=%s" % (article_url, article['doi'])
			output += "<a href='%s'>%s, %s, %s</a><br/>" % (url, title, author, year)
		"""

		output = index_template.render_unicode(recents = recent_articles, completes = complete_articles)		


		return output 

if __name__ == '__main__':
	cherrypy.config.update({'server.socket_host':url})
	cherrypy.config.update({'server.socket_port':index_port})
	index = index()
	index.article = article.article()
	cherrypy.quickstart(index)

