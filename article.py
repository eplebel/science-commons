"""
Science-Commons Prototype Article Page
Copyright (C) 2014 Christian Battista

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import cherrypy
from mako_defs import *
import mongo_tools as mt
import os
from config import *
from formatter import formatter

class article(object):

	@cherrypy.expose
	def index(self, **kwargs):
		output = ""

		if kwargs.has_key('doi'):
			data = self.fetchData(kwargs['doi'])
		else:
			data = "no DOI provided"

		return data

	def fetchData(self, doi):
		db = mt.Connect("sciencecommons", "articles")
		row = db.table.find_one({'doi': doi})

		#format stuff, check if data present
		data = {}
	
		data['comments'] = formatter['comments'](doi)
		data['stats'] = formatter['stats'](doi)

		for item in ITEMS:
			if row.has_key(item):
				data[item] = formatter[item](row[item])
			else:
				data[item] = ''

		for badge in BADGES:
			if row.has_key(badge):
				data[badge] = formatter[badge](row[badge], badge)

		output = article_template.render(index_url = index_url, data=data)

		return output


if __name__ == '__main__':
	cherrypy.config.update({'server.socket_host':url})
	cherrypy.config.update({'server.socket_port':article_port})
	cherrypy.quickstart(article())

