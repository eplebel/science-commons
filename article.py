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


class article(object):

	@cherrypy.expose
	def index(self, **kwargs):
		output = ""

		if kwargs.has_key['DOI']:
			data = self.fetchData(kwargs['DOI'])
		else:
			data = "no DOI provided"

		return data

	def fetchData(self, doi):
		db = mt.Connect("sciencecommons", "articles")
		row = db.table.find_one({'DOI' : doi})
		output = article_template.render(data=row)
		return output



if __name__ == '__main__':

	cherrypy.quickstart(article())

