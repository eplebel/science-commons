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

class index(object):

	@cherrypy.expose
	def index(self):
		output = "<h1>Discovery Page</h1>"

		articles = db.table.find()

		for article in articles:
			title = article['title']
			author = article['author']
			year = article['year']
			url = "http://%s?doi=%s" % (article_url, article['doi'])
			output += "<a href='%s'>%s, %s, %s</a><br/>" % (url, title, author, year)
		

		return output 

if __name__ == '__main__':
	cherrypy.config.update({'server.socket_host':'97.107.137.132'})
	cherrypy.config.update({'server.socket_port':9191})
	index = index()
	index.article = article.article()
	cherrypy.quickstart(index)

