require(htmltools)
require(shiny) #required functions to source


#remember to DELETE output.txt file before running function

authors.TD <- function(authors.pub.year, open.mat.URL, prereg.URL, open.data.URL, open.code.URL, 
                       code.ocean.URL, reporting.type, disclosure.URL,
                       disclosure.date, discl.exclusions, discl.conditions, discl.DVs,
                       discl.sample.size, discl.analyses, discl.other.studies, discl.others, rr) {
      
      return(HTML(paste0("<td style='white-space: nowrap'>",authors.pub.year, 
                          disclosure.HTML(reporting.type, disclosure.URL, disclosure.date, 
                                          discl.exclusions, discl.conditions, discl.DVs, 
                                          discl.sample.size, discl.analyses, discl.other.studies, discl.others),
                          materials.HTML(open.mat.URL),
                          prereg.HTML(rr, prereg.URL),
                          data.HTML(open.data.URL),
                          code.HTML(open.code.URL),
                          code.ocean.HTML(code.ocean.URL),"</td>")))
  }

basic4.at.subm.HTML <- "<div style='display:inline;' class='popUpOnHover'><a class='sprite sprite-disclosure-medium-available'></a>
  <span class='toDisplayBasic4Submission popUpStyle'>
  <span style='font-size:14px;font-weight:bold;color:gray;'>Study complies with the 
<a href='https://www.psychologicalscience.org/publications/psychological_science/ps-submissions#DISC' target='_blank'>
Basic 4 (at submission)</a><a class='sprite sprite-disclosure-medium-available'></a> reporting standard:</span>
  <ol style='margin-top:5px;margin-bottom:5px;'>
  <li><strong>Excluded data (subjects/observations):</strong> Full details reported in article.</li>
  <li><strong>Experimental conditions:</strong> Full details reported in article.</li>
  <li><strong>Outcome measures:</strong> Full details reported in article.</li>
  <li><strong>Sample size determination:</strong> Full details reported in article.</li>
  </ol>
  </span>
  </div>"

disclosure.HTML <- function(reporting.type, disclosure.URL, disclosure.date, 
                            discl.exclusions, discl.conditions, discl.DVs, 
                            discl.sample.size, discl.analyses, discl.other.studies, discl.others) {
  if(toString(reporting.type) == "basic4.at.subm") {
    return(HTML(basic4.at.subm.HTML))}
  else if (toString(reporting.type) == "basic4.retro") {
    return()
  }
  else if (toString(reporting.type) == "basic7.retro") {
    return()
  }
  else {
    return(HTML(" <a class='sprite sprite-disclosure-medium-unavailable' 
                      title='Compliance to reporting standard information is not available'></a>"))
  }
}

materials.HTML <- function(open.mat.URL) {
  if (toString(open.mat.URL) != "NA") {
    return(HTML(paste0(" <a href='",open.mat.URL,"' target='_blank' class='sprite sprite-materials-medium' 
                      title='Go to study materials files'></a> "))) }
  else {
    return(HTML(" <a class='sprite sprite-materials-medium-unavailable' title='Open study materials information is not available'></a> "))
  }
}
prereg.HTML <- function(rr, prereg.URL) 
  { if (toString(rr) != "NA") #is an RR
    { if (toString(prereg.URL) != "NA") #is an RR *and* pre-reg protocol available
      { return(HTML(paste0(" <a href='",prereg.URL,"' target='_blank' class='sprite sprite-preregisteredplus-medium' 
                      title='Go to Registered Report preregistered study protocol'></a> ")))
      }  
      else #RR, but pre-reg protocol unavailable
      { return(HTML(" <a class='sprite sprite-preregisteredplus-medium' 
                     title='Registered Report preregistered study protocol not (yet) publicly available'></a> "))
      }
    }
  else #not an RR
    { if (toString(prereg.URL) != "NA") #not an RR, but pre-registered
      { return(HTML(paste0(" <a href='",prereg.URL,"' target='_blank' class='sprite sprite-preregisteredplus-medium' 
                     title='Go to preregistered study protocol'></a> ")))
      }
      else  #not an RR, nor pre-registered
      { return(HTML(" <a class='sprite sprite-preregisteredplus-medium-unavailable' title='Preregistration information is not available'></a> "))
      }
    }
}
data.HTML <- function(open.data.URL) {
  if (toString(open.data.URL) != "NA") {
    return(HTML(paste0(" <a href='",open.data.URL,"' target='_blank' class='sprite sprite-data-medium' 
                      title='Go to data files'></a> ")))}
  else {
    return(HTML(" <a class='sprite sprite-materials-medium-unavailable' title='Open data information is not available'></a> "))
  }
}
code.HTML <- function(open.code.URL) {
  if (toString(open.code.URL) != "NA") {
    return(HTML(paste0(" <a href='",open.code.URL,"' target='_blank' class='sprite sprite-reproducible-icon-medium' 
                      title='Go to reproducible code files'></a> ")))}
}
code.ocean.HTML <- function(code.ocean.URL) {
  if (toString(code.ocean.URL) != "NA") {
    return(HTML(paste0(" <a href='",code.ocean.URL,"' target='_blank' class='sprite sprite-code-ocean-icon-medium kinda-link' 
                      title='Go to computational container'></a> ")))}
}
PDF.HTML <- function(PDF.URL) {
  if(toString(PDF.URL) != "NA") {
    return(HTML(paste0("<a href='",PDF.URL,"' target='_blank' class='sprite sprite-pdf-icon-medium'></a>")))}
}
EC.icon.HTML <- function(EC.URL) {
  if (toString(EC.URL) != "NA") {
    return(HTML(paste0("<a href='",EC.URL,"' class='sprite sprite-ec-icon' 
                      title='Go to evidence collection this replication is part of'></a>")))} 
}
#dropped this for now because curating open articles at article-level whereas curating replications at study-level;
#replication.of.HTML <- function(replication.of, orig.article.PDF.URL) {
#  if (toString(replication.of) != "NA") {
#    if (toString(orig.article.PDF.URL) != "NA") {  
#      return(tags$td(replication.of, PDF.HTML(orig.article.PDF.URL)))}
#    else {
#      return(tags$td(replication.of))}
#  }
#  else {
#    return(tags$td())
#  }
#}
preprint.HTML <- function(article.preprint.URL) {
  if(toString(article.preprint.URL) != "NA") {
    return(HTML(paste0("<span class='label label-info-purple'><a href='",article.preprint.URL,"' target='_blank' 
                      class='black' title='View preprint of this article.'>Preprint</a></span>")))}
}
article.HTML.HTML <- function(article.HTML.URL) {
  if(toString(article.HTML.URL) != "NA") {
    return(HTML(paste0("<span class='label label-default'><a href='",article.HTML.URL,"' target='_blank' 
                      class='black' title='View interactive HTML version of this article.'>HTML</a></span>")))}
}
RR.HTML <- function(rr, prereg.URL) {
  if(toString(rr) != "NA") {
    if (toString(prereg.URL) != "NA")
      { return(HTML(paste0("<span class='label label-info-red'><a href='",prereg.URL,"' target='_blank' 
                      class='black' title='Go to Registered Report preregistered study protocol.'>Registered Report</a></span>")))}
    else 
      { return(HTML("<span class='label label-info-red' 
                    title='Registered Report preregistered study protocol not (yet) publicly available.'>Registered Report</span>"))}
  }
}
DOI.HTML <- function(DOI) {
  if(toString(DOI) != "NA") {
    return(HTML(paste0("<a href='https://dx.doi.org/", DOI,"' target='_blank'>",DOI,"</a>")))} #still not trimming correctly but link still works
}
journal.name.HTML <- function(journal.name) {
  return(HTML(paste0("<i>",journal.name,"</i>")))
}
NA.to.blank <- function (x) {
  if (is.na(x)) {
  return(replace(x,is.na(x),""))  }
  else return(x)
}

article.HTML <- function(authors.pub.year, article.title, journal.name, DOI, article.PDF.URL,
                         article.preprint.URL, article.HTML.URL, open.mat.URL, prereg.URL, 
                         open.data.URL, open.code.URL, code.ocean.URL, reporting.type, disclosure.URL,
                         disclosure.date, discl.exclusions, discl.conditions, discl.DVs,
                         discl.sample.size, discl.analyses, discl.other.studies, discl.others,
                         rs, om, prereg, od, rc, article.type, rr) {
    
  row.string <- tags$tr(authors.TD(authors.pub.year, open.mat.URL, prereg.URL, open.data.URL, open.code.URL, 
                                   code.ocean.URL, reporting.type, disclosure.URL,
                                   disclosure.date, discl.exclusions, discl.conditions, discl.DVs,
                                   discl.sample.size, discl.analyses, discl.other.studies, discl.others, rr),
                        tags$td(article.title, RR.HTML(rr, prereg.URL), preprint.HTML(article.preprint.URL),
                                article.HTML.HTML(article.HTML.URL), PDF.HTML(article.PDF.URL)),
                        tags$td(journal.name.HTML(journal.name)),
                        tags$td(DOI.HTML(DOI)),
                        tags$td(NA.to.blank(rs)),
                        tags$td(NA.to.blank(om)),
                        tags$td(NA.to.blank(prereg)),
                        tags$td(NA.to.blank(od)),
                        tags$td(NA.to.blank(rc)),
                        tags$td(NA.to.blank(article.type)),
                        tags$td(NA.to.blank(rr)))
    cat(iconv(row.string, to="UTF-8"), file="output-all-articles.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}
gSheet.url <- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdCTs0OOhcOI9LvmHkD4bXXm_kgxv7yq79VWtxwIgmwgi_LnK-2uWc-um_pfZBgbx2cWrNliMh9v7B/pub?gid=354006826&single=true&output=csv'

run <- function() {
  article.table <- read.csv(url(gSheet.url), quote = "\"", stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
  for (i in 1:nrow(article.table)) {
  #for (i in 28:52) {
    #calling by header names so still works if column order changes in CSV file
    article.HTML(authors.pub.year = article.table[i,"authors.pub.year"],
                 article.title = article.table[i,"article.title"],
                 journal.name = article.table[i,"journal.name"],
                 DOI = article.table[i,"DOI"],
                 article.PDF.URL = article.table[i,"article.PDF.URL"],
                 article.preprint.URL = article.table[i,"article.preprint.URL"],
                 article.HTML.URL = article.table[i,"article.HTML.URL"],
                 open.mat.URL = article.table[i,"open.mat.URL"],
                 prereg.URL = article.table[i,"prereg.URL"],
                 open.data.URL = article.table[i,"open.data.URL"],
                 open.code.URL = article.table[i,"open.code.URL"],
                 code.ocean.URL = article.table[i,"code.ocean.URL"],
                 reporting.type = article.table[i,"reporting.type"],
                 disclosure.URL = article.table[i,"disclosure.URL"],
                 disclosure.date = article.table[i,"disclosure.date"],
                 discl.exclusions = article.table[i,"discl.exclusions"],
                 discl.conditions = article.table[i,"discl.conditions"],
                 discl.DVs = article.table[i,"discl.DVs"],
                 discl.sample.size = article.table[i,"discl.sample.size"],
                 discl.analyses = article.table[i,"discl.analyses"],
                 discl.other.studies = article.table[i,"discl.other.studies"],
                 discl.others = article.table[i,"discl.others"],
                 rs = article.table[i,"rs"],
                 om = article.table[i,"om"],
                 prereg = article.table[i,"prereg"],
                 od = article.table[i,"od"],
                 rc = article.table[i,"rc"],
                 article.type = article.table[i,"article.type"],
                 rr = article.table[i,"rr"])
  }
}