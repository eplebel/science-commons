require(htmltools)
require(shiny) #required functions to source


#remember to DELETE output.txt file before running function

article.title.TD <- function(article.title, article.PDF.URL,
                             open.mat.URL, prereg.URL, open.data.URL, open.code.URL, 
                             code.ocean.URL, reporting.type, disclosure.URL,
                             disclosure.date, discl.exclusions, discl.conditions, discl.DVs,
                             discl.sample.size, discl.analyses, discl.other.studies, discl.others, rr,
                             article.preprint.URL, article.HTML.URL, article.type, rep.num) {
      
      return(HTML(paste0("<td>",article.title, " ", PDF.HTML(article.PDF.URL), RR.label(rr, prereg.URL), 
                         preprint.label(article.preprint.URL),
                         article.HTML.label(article.HTML.URL), rep.label(article.type, rep.num), "<br>",
                          disclosure.HTML(reporting.type, disclosure.URL, disclosure.date, 
                                          discl.exclusions, discl.conditions, discl.DVs, 
                                          discl.sample.size, discl.analyses, discl.other.studies, discl.others),
                          materials.HTML(open.mat.URL),
                          prereg.HTML(rr, prereg.URL),
                          data.HTML(open.data.URL),
                          code.HTML(open.code.URL),
                          code.ocean.HTML(code.ocean.URL),
                          "</td>")))
  }

basic4.at.subm.HTML <- "<div style='display:inline;' class='popUpOnHover'>
<img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'>
  <span class='toDisplayBasic4Submission popUpStyle' style='padding-left:5px;white-space:nowrap;'>
  <span style='font-size:14px;font-weight:bold;color:gray;'>Study complies with the 
<a href='https://www.psychologicalscience.org/publications/psychological_science/ps-submissions#DISC' target='_blank'>
Basic 4 (at submission)</a> <img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'> reporting standard:</span>
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
    return(HTML(" <a title='Compliance to reporting standard information is not available'>
                <img src='logos/sprite-icons/disclosure-unavailable.png' class='shrunk-16'></a>"))
  }
}

materials.HTML <- function(open.mat.URL) {
  if (toString(open.mat.URL) != "NA") {
    return(HTML(paste0(" <a href='",open.mat.URL,"' target='_blank' title='Go to study materials files'>
                       <img src='logos/sprite-icons/materials-available.png' class='shrunk-16 transparent'></a> "))) }
  else {
    return(HTML(" <a title='Open study materials information is not available'>
                <img src='logos/sprite-icons/materials-unavailable.png' class='shrunk-16'></a> "))
  }
}
prereg.HTML <- function(rr, prereg.URL) 
  { if (toString(rr) != "NA") #is an RR
    { if (toString(prereg.URL) != "NA") #is an RR *and* pre-reg protocol available
      { return(HTML(paste0(" <a href='",prereg.URL,"' target='_blank' 
                           title='Go to Registered Report preregistered study protocol'>
                           <img src='logos/sprite-icons/preregistered-plus-available.png' class='shrunk-16 transparent'></a> ")))
      }  
      else #RR, but pre-reg protocol unavailable
      { return(HTML(" <a title='Registered Report preregistered study protocol not (yet) publicly available'>
                    <img src='logos/sprite-icons/preregistered-plus-available.png' class='shrunk-16 transparent'></a> "))
      }
    }
  else #not an RR
    { if (toString(prereg.URL) != "NA") #not an RR, but pre-registered
      { return(HTML(paste0(" <a href='",prereg.URL,"' target='_blank' title='Go to preregistered study protocol'>
                           <img src='logos/sprite-icons/preregistered-available.png' class='shrunk-16 transparent'></a> ")))
      }
      else  #not an RR, nor pre-registered
      { return(HTML(" <a title='Preregistration information is not available'>
                    <img src='logos/sprite-icons/preregistered-unavailable.png' class='shrunk-16'></a> "))
      }
    }
}
data.HTML <- function(open.data.URL) {
  if (toString(open.data.URL) != "NA") {
    return(HTML(paste0(" <a href='",open.data.URL,"' target='_blank' title='Go to data files'>
                       <img src='logos/sprite-icons/data-available.png' class='shrunk-16 transparent'></a> ")))}
  else {
    return(HTML(" <a title='Open data information is not available'>
                <img src='logos/sprite-icons/data-unavailable.png' class='shrunk-16'></a> "))
  }
}
code.HTML <- function(open.code.URL) {
  if (toString(open.code.URL) != "NA") {
    return(HTML(paste0(" <a href='",open.code.URL,"' target='_blank' title='Go to reproducible code files'>
                       <img src='logos/sprite-icons/reproducible-code.png' class='shrunk-16 transparent'></a> ")))}
}
code.ocean.HTML <- function(code.ocean.URL) {
  if (toString(code.ocean.URL) != "NA") {
    return(HTML(paste0(" <a href='",code.ocean.URL,"' target='_blank' title='Go to computational container'>
                       <img src='logos/sprite-icons/code-ocean.png' class='shrunk-16 transparent'></a> ")))}
}
PDF.HTML <- function(PDF.URL) {
  if(toString(PDF.URL) != "NA") {
    return(HTML(paste0(" <a href='",PDF.URL,"' target='_blank'>
                       <img src='logos/sprite-icons/pdf.png' class='shrunk-14 transparent'></a> ")))}
}
EC.icon.HTML <- function(EC.URL) {
  if (toString(EC.URL) != "NA") {
    return(HTML(paste0("<a href='",EC.URL,"' title='Go to replication collection this replication is part of'>
                       <img src='logos/sprite-icons/collection.png' class='shrunk-16 transparent'></a>")))} 
}
rep.label <- function(article.type, rep.num) {
  if(toString(article.type) == "rep") {
    return(HTML(paste0(" <span class='label label-info-brown' 
                       title='This article reports replications.'>Replication <span class='badge badge-repnum'>",
                       rep.num, "</span></span> ")))}
  }
preprint.label <- function(article.preprint.URL) {
  if(toString(article.preprint.URL) != "NA") {
    return(HTML(paste0("<span class='label label-info-purple'><a href='",article.preprint.URL,"' target='_blank' 
                      class='black' title='View preprint of this article.'>Preprint</a></span> ")))}
}
article.HTML.label <- function(article.HTML.URL) {
  if(toString(article.HTML.URL) != "NA") {
    return(HTML(paste0("<span class='label label-default'><a href='",article.HTML.URL,"' target='_blank' 
                      class='black' title='View interactive HTML version of this article.'>HTML</a></span> ")))}
}
RR.label <- function(rr, prereg.URL) {
  if(toString(rr) != "NA") {
    if (toString(prereg.URL) != "NA")
      { return(HTML(paste0("<span class='label label-info-red'><a href='",prereg.URL,"' target='_blank' 
                      class='black' title='Go to Registered Report preregistered study protocol.'>Registered Report</a></span> ")))}
    else 
      { return(HTML("<span class='label label-info-red' 
                    title='Registered Report preregistered study protocol not (yet) publicly available.'>Registered Report</span> "))}
  }
}
DOI.HTML <- function(DOI) {
  if(toString(DOI) != "NA") {
    return(HTML(paste0("<a href='https://doi.org/", DOI,"' target='_blank' class='doi-dimmed grey'>",DOI,"</a>")))} #still not trimming correctly but link still works
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
                         rs, om, prereg, od, rc, article.type, rr, rep.num) {
    
  row.string <- tags$tr(tags$td(authors.pub.year),
                        article.title.TD(article.title, article.PDF.URL,
                                         open.mat.URL, prereg.URL, open.data.URL, open.code.URL, 
                                         code.ocean.URL, reporting.type, disclosure.URL,
                                         disclosure.date, discl.exclusions, discl.conditions, discl.DVs,
                                         discl.sample.size, discl.analyses, discl.other.studies, discl.others, rr,
                                         article.preprint.URL, article.HTML.URL, article.type, rep.num),
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
                 rr = article.table[i,"rr"],
                 rep.num = article.table[i,"rep.num"])
  }
}