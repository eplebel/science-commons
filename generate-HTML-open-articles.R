require(htmltools)
require(shiny) #required functions to source
#require(readr)
#remember to DELETE output.txt file before running function

article.single.column <- function(article.title, authors.pub.year, journal.name, DOI,
                             open.mat.URL, prereg.URL, open.data.URL, open.code.URL, 
                             code.ocean.URL, reporting.type, disclosure.URL,
                             disclosure.date, discl.exclusions, discl.conditions, discl.DVs, article.URL,
                             discl.sample.size, discl.analyses, discl.other.studies, discl.others, prereg, EC.URL, target.effects,
                             article.type, rep.num, article.PDF.URL, article.preprint.URL, article.HTML.URL, addition.date, 
                             added.by,commentaries.URLs){
    return(HTML(paste0("<td class='article-styling'>
                            <img src='logos/sprite-icons/article.png' class='shrunk-14 transparent'>
                        </td>
                        <td class='article-styling'>
							              <span class='article-title'>", title.link(article.title,article.URL), "</span>
                            <br>
                                <span class='author-text'>", authors.pub.year, "</span>
                            <br>", 
                                journal.name.HTML(journal.name), "<span class='doi-dimmed'> ", DOI.HTML(DOI), "</span>
                            <br>",
                              prereg.HTML(prereg, prereg.URL),       
                              materials.HTML(open.mat.URL),
                              data.HTML(open.data.URL),
                              code.HTML(open.code.URL),
                              disclosure.HTML(reporting.type, disclosure.URL, disclosure.date, 
                                       discl.exclusions, discl.conditions, discl.DVs, 
                                       discl.sample.size, discl.analyses, discl.other.studies, discl.others),
                              code.ocean.HTML(code.ocean.URL), 
                            " <br>",      
                              rep.label(article.type, rep.num), " ", reanal.label(article.type), " ", EC.icon.HTML(EC.URL), " ",
                              RR.label(prereg, prereg.URL), " ", commentaries.label(commentaries.URLs),
                              target.effects.HTML(target.effects), 
                            "<div class='added-by doi-dimmed'>", added.by, " ", format(as.Date(addition.date, "%m/%d/%Y"), 
                              format="%B %d %Y"), "</div>
                          </td>
                          <td class='article-styling PDF-column'>",
                            preprint.label(article.preprint.URL),
                            article.HTML.label(article.HTML.URL),
                            PDF.HTML(article.PDF.URL), 
                          "</td>"
                       )))
}
collection.single.column <- function(collection.name, rep.num, updating.user, update.date, effects.num, methods.num, labs.num, 
                                     collection.URL, collection.description){
  return(HTML(paste0("<td class='article-styling'>
                          <img src='logos/sprite-icons/collection.png' class='shrunk-16 transparent'></td>
                      <td class='article-styling'>
							              <span class='article-title'>", collection.link(collection.name, collection.URL), "</span>
                            <br>", rep.label("rep", rep.num), " of ", collection.description, "</span>
                            <br>
                          <span class='label label-info-teal-darkest'>", effects.num, "</span> <span class='label label-info-teal-darker'>",
                     methods.num, "</span> <span class='label label-info-teal'>", labs.num, "</span>
                            <div class='added-by doi-dimmed'>", updating.user, " ", 
                                format(as.Date(update.date, "%m/%d/%Y"), format="%B %d %Y"), "</div>
                       </td>
                       <td class='article-styling PDF-column'></td>"
  )))
}


basic4.at.subm.HTML <- "<div style='display:inline;' class='popUpOnHover'>
<img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'>
  <span class='toDisplayBasic4Submission popUpStyle' style='padding-left:5px;white-space:nowrap;'>
  <span style='font-weight:bold;color:gray;'>Study complies with the 
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
    return(HTML(paste0("<div style='display:inline;' class='popUpOnHover'>
                  <img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'>
                       <span class='toDisplayBasic4Submission popUpStyle' style='padding-left:5px;white-space:nowrap;'>
                       <span style='font-weight:bold;color:gray;'>Study complies with the 
                       <a href='http://psychdisclosure.org' target='_blank'>Basic 4 (retroactive)</a> 
                       <img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'> reporting standard:</span>
                       <ol style='margin-top:5px;margin-bottom:5px;'>
                       <li><strong>Excluded data (subjects/observations):</strong> Full details reported in article.</li>
                       <li><strong>Experimental conditions:</strong> Full details reported in article.</li>
                       <li><strong>Outcome measures:</strong> Full details reported in article.</li>
                       <li><strong>Sample size determination:</strong> Full details reported in article.</li>
                       </ol>
                       <span style='color:red;'>Date of retroactive disclosure: ", disclosure.date, ".</span>
                       </span>
                       </div>")))
  }
  else if (toString(reporting.type) == "basic7.retro") {
    return()
  }
  else if (toString(reporting.type) == "MARS") {
    return(HTML(paste0("<div style='display:inline;' class='popUpOnHover'>
                          <img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'>
                            <span class='toDisplayMARS popUpStyle' style='padding-left:5px;white-space:nowrap;'>
                               <span style='font-weight:bold;color:gray;'>Meta-analysis complies with the 
                                  <a href='http://www.apa.org/pubs/journals/releases/amp-amp0000191.pdf' target='_blank'>MARS</a> 
                                <img src='logos/sprite-icons/disclosure-available.png' class='shrunk-16 transparent'> reporting standard: 
    								          	<ul>
                                    <li><a href='http://www.apa.org/pubs/journals/releases/amp-amp0000191.pdf' target='_blank'>
                                        APA's Meta-Analysis Reporting Standards (MARS; Table 9)</a> 
                                    </li></span>
                                </ul>
                          </span>
                       </div>")))
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
prereg.HTML <- function(prereg, prereg.URL) 
  { if (toString(prereg) == "preregplusrr") #is an RR
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
  else #not an RR (but prereg or preregplus)
    { if (toString(prereg) == "preregplus") #pre-registered study design + analytic plans
      { return(HTML(paste0(" <a href='",prereg.URL,"' target='_blank' title='Go to preregistered study protocol (study design + analytic plans) '>
                           <img src='logos/sprite-icons/preregistered-plus-available.png' class='shrunk-16 transparent'></a> ")))
      }
      else if (toString(prereg) == "prereg")  #pre-registered study design ONLY
      { return(HTML(paste0(" <a href='",prereg.URL,"' target='_blank' title='Go to preregistered study protocol (study design only)'>
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
                       <img src='logos/sprite-icons/code.png' class='shrunk-16 code-icon'></a> ")))}
  else {
    return(HTML(" <a title='Open code information is not available'>
                <img src='logos/sprite-icons/code.png' class='shrunk-16 code-icon unavailable'></a> "))
  }
}
code.ocean.HTML <- function(code.ocean.URL) {
  if (toString(code.ocean.URL) != "NA") {
    return(HTML(paste0(" <a href='",code.ocean.URL,"' target='_blank' title='Go to computational container'>
                       <img src='logos/sprite-icons/code-ocean.png' class='shrunk-16 transparent'></a> ")))}
}
PDF.HTML <- function(PDF.URL) {
  if(toString(PDF.URL) != "NA") {
    return(HTML(paste0(" <a href='",PDF.URL,"' target='_blank'>
                       <img src='logos/sprite-icons/pdf.png' class='shrunk-20 transparent'></a> ")))}
}
EC.icon.HTML <- function(EC.URL) {
  if (toString(EC.URL) != "NA") {
    return(HTML(paste0("<a href='",EC.URL,"' title='Go to collection this replication is part of'>
                       <img src='logos/sprite-icons/collection.png' class='shrunk-16 transparent'></a>")))} 
}
target.effects.HTML <- function(target.effects) {
  if (toString(target.effects) != "NA") {
    return(HTML(paste0("<br><span class='target-effects'> ", target.effects, "</span><br>")))} 
  }

rep.label <- function(article.type, rep.num) {
  if(toString(article.type) == "rep") {
    return(HTML(paste0(" <span class='label label-info-brown' 
                       title='This article reports replications.'>Replications <span class='badge badge-repnum'>",
                       rep.num, "</span></span> ")))}
}
commentaries.label <- function(commentaries.URLs) {
  if(toString(commentaries.URLs) != "NA") {
    URLs.list <- strsplit(commentaries.URLs, ";")
    comment.list=""
    for (i in 1:lengths(URLs.list)) { 
      comment.list <- paste0(comment.list, "<li><a href='", URLs.list[[1]][i] , "' target='_blank'>Commentary ", toString(i), "</a></li>") }
    return(HTML(paste0("<div style='display:inline;' class='popUpOnHover'>
                          <span class='label label-info-commentary' >Commentaries <span class='badge badge-repnum'>",
                       lengths(URLs.list), "</span></span> 
                       <span class='toDisplayCommentaries popUpStyle' style='padding-left:5px;white-space:nowrap;'>
                       Commentaries about this article: 
                       <ul>"
                       , comment.list, "</ul></span></div>")))
    }
}
reanal.label <- function(article.type) {
  if(toString(article.type) == "reanal") {
    return(HTML(paste0(" <span class='label label-info-pecan' 
                       title='This article reports a reproducibility or robustness reanalysis of a previously published result.'>Reanalysis</span> ")))}
}
preprint.label <- function(article.preprint.URL) {
  if(toString(article.preprint.URL) != "NA") {
    return(HTML(paste0("<span class='label label-info-purple'><a href='",article.preprint.URL,"' target='_blank' 
                      class='black' title='View preprint of this article.'>Preprint</a></span> ")))}
}
article.HTML.label <- function(article.HTML.URL) {
  if(toString(article.HTML.URL) != "NA") {
    return(HTML(paste0("<span class='label label-default'><a href='",article.HTML.URL,"' target='_blank' 
                      class='black' title='View HTML version of this article.'>HTML</a></span> ")))}
}
RR.label <- function(prereg, prereg.URL) {
  if(toString(prereg) == "preregplusrr") {
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
    return(HTML(paste0("<a href='https://dx.doi.org/", DOI,"' target='_blank' class='doi-dimmed grey'>", DOI,"</a>")))} 
}
journal.name.HTML <- function(journal.name) {
  if (toString(journal.name) != "NA") 
   { return(HTML(paste0("<span class='journal-text'> ",journal.name,"</span>"))) }
}
NA.to.blank <- function (x) {
  if (is.na(x)) {
  return(replace(x,is.na(x),""))  }
  else return(x)
}
EC.coding.for.filter <- function(EC.URL){
  if(toString(EC.URL) != "NA") {
    return(HTML("ec"))} 
}
title.link <- function(article.title, article.URL){
  if (toString(article.URL) != "NA") {
    return(HTML(paste0(" <a href='",article.URL,"' title='Go to article page'>", article.title, "</a> "))) }
  else {
    return(article.title)
  }
}
collection.link <- function(collection.title, collection.URL){
    return(HTML(paste0(" <a href='", collection.URL,"' title='Go to collection page'>", collection.title, "</a> "))) 
}

article.HTML.single.column <- function(authors.pub.year, article.title, journal.name, DOI, article.PDF.URL,
                         article.preprint.URL, article.HTML.URL, open.mat.URL, prereg.URL, 
                         open.data.URL, open.code.URL, code.ocean.URL, reporting.type, disclosure.URL,
                         disclosure.date, discl.exclusions, discl.conditions, discl.DVs,
                         discl.sample.size, discl.analyses, discl.other.studies, discl.others, article.URL,
                         rs, om, prereg, od, rc, article.type, rep.num, addition.date, EC.URL, target.effects, 
                         added.by,commentaries.URLs) {
  
  row.string <- tags$tr(article.single.column(article.title, authors.pub.year, journal.name, DOI,
                                         open.mat.URL, prereg.URL, open.data.URL, open.code.URL, 
                                         code.ocean.URL, reporting.type, disclosure.URL,
                                         disclosure.date, discl.exclusions, discl.conditions, discl.DVs, article.URL,
                                         discl.sample.size, discl.analyses, discl.other.studies, discl.others, prereg, EC.URL,
                                         target.effects, article.type, rep.num, article.PDF.URL, article.preprint.URL, 
                                         article.HTML.URL,addition.date, added.by,commentaries.URLs),
                        tags$td(addition.date),
                        tags$td(NA.to.blank(rs)),
                        tags$td(NA.to.blank(om)),
                        tags$td(NA.to.blank(prereg)),
                        tags$td(NA.to.blank(od)),
                        tags$td(NA.to.blank(rc)),
                        tags$td(NA.to.blank(article.type)))
  cat(iconv(row.string, to="UTF-8"), file="output-all-single-column.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}
collection.HTML.single.column <- function(collection.name, rep.num, updating.user, update.date, effects.num, methods.num, labs.num, 
                                          collection.URL, collection.description) {
  
  row.string <- tags$tr(collection.single.column(collection.name, rep.num, updating.user, update.date, effects.num, methods.num, labs.num, 
                                                 collection.URL, collection.description),
                        tags$td(update.date),
                        tags$td(),
                        tags$td(),
                        tags$td(),
                        tags$td(),
                        tags$td(),
                        tags$td("ec"))
  cat(iconv(row.string, to="UTF-8"), file="output-all-single-column.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}

gSheet.article.url <- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdCTs0OOhcOI9LvmHkD4bXXm_kgxv7yq79VWtxwIgmwgi_LnK-2uWc-um_pfZBgbx2cWrNliMh9v7B/pub?gid=354006826&single=true&output=csv'
gSheet.collection.url <- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdCTs0OOhcOI9LvmHkD4bXXm_kgxv7yq79VWtxwIgmwgi_LnK-2uWc-um_pfZBgbx2cWrNliMh9v7B/pub?gid=1508057244&single=true&output=csv'

run <- function() {
  article.table <- read.csv(url(gSheet.article.url), quote = "\"", stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
  for (i in 1:nrow(article.table)) {
  #for (i in 1:92) {
    #calling by header names so still works if column order changes in CSV file
    article.HTML.single.column(authors.pub.year = article.table[i,"authors.pub.year"],
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
                 rep.num = article.table[i,"rep.num"],
                 addition.date = article.table[i,"addition.date"],
                 target.effects = article.table[i,"target.effects"],
                 EC.URL = article.table[i,"EC.URL"],
                 added.by = NA.to.blank(article.table[i,"added.by"]),
                 article.URL = article.table[i,"article.URL"],
                 commentaries.URLs = article.table[i,"commentaries.URLs"])
  }

  collection.table <- read.csv(url(gSheet.collection.url), quote = "\"", stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
  for (i in 1:nrow(collection.table)) {
    #for (i in 1:92) {
    #calling by header names so still works if column order changes in CSV file
    collection.HTML.single.column(collection.name = collection.table[i,"collection.name"],
                               rep.num = collection.table[i,"rep.num"],
                               updating.user = collection.table[i,"updating.user"],
                               update.date = collection.table[i,"update.date"],
                               effects.num = collection.table[i,"effects.num"],
                               methods.num = collection.table[i,"methods.num"],
                               labs.num = collection.table[i,"labs.num"],
                               collection.URL = collection.table[i,"collection.URL"],
                               collection.description = collection.table[i,"collection.description"])
  }
  
}
