d<-http://www.crossref.org/openurl/?pid=etienne.lebel@gmail.com&format=unixref&id=doi:10.1177/1948550612448196&noredirect=true


install.packages("rcrossref")
require(rcrossref)

cr_cn(dois = "10.1126/science.169.3946.635", format = "text", style = "apa")

ddd<-cr_cn(dois="10.1177/1948550612448196", "citeproc-json")
ddd$author["family"]
ddd$DOI
ddd$`container-title-short`
ddd$`published-online`
