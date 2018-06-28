require(htmltools)
require(shiny) #required functions to source
#require(gsheet) #not currently required, but perhaps for multiple sheets

#All-replications HTML table functions
#remember to DELETE output.txt file before running function
PDF.HTML <- function(PDF.URL) {
  if(toString(PDF.URL) != "NA") {
    return(HTML(paste("<a href='",PDF.URL,"' target='_blank' class='sprite sprite-pdf-icon'></a>")))}
}
data.HTML <- function(data.URL) {
  if (toString(data.URL) != "NA") {
    return(HTML(paste("<a href='",data.URL,"' target='_blank' class='sprite sprite-data'></a>")))} 
}
materials.HTML <- function(materials.URL) {
  if (toString(materials.URL) != "NA") {
    return(HTML(paste("<a href='",materials.URL,"' target='_blank' class='sprite sprite-materials'></a>")))} 
}
prereg.HTML <- function(prereg.URL) {
  if (toString(prereg.URL) != "NA") {
    return(HTML(paste("<a href='",prereg.URL,"' target='_blank' class='sprite sprite-preregisteredplus'></a>")))} 
}
EC.icon.HTML <- function(EC.URL) {
  if (toString(EC.URL) != "NA") {
    return(HTML(paste("<a href='",EC.URL,"' class='sprite sprite-ec-icon' title='Go to evidence collection this replication is part of'></a>")))} 
}
NA.to.blank <- function (x) {
  if (is.na(x)) {
  return(replace(x,is.na(x),""))  }
  else return(x)
}
concat.ES.CI <- function (ES.type, ES.value, ES.CI) {
  if (ES.CI!="") {
    if (substr(ES.CI,1,1)=="[") {
      return( paste(ES.type, "=", ES.value, ES.CI)) } #an extra space somehow being added bet. ES. value & ES.CI so removed , "" ,
    else {
      return( paste(ES.type, "=", ES.value, "±", ES.CI))  }
    }
  if (ES.CI=="" & ES.value!="") #added & ES.value!="" to deal with cases where no ES.value available
    { return( paste(ES.type, "=", ES.value))  }
}
#add ES.description title to original and replication ES cells (assumes same ES.description for both orig & rep)
td.custom.title <- function (x,ES.description) {
  if (ES.description!="") {
     return(HTML(paste("<td title='",ES.description,"'>",x,"</td>")))  }
  else 
    { return(HTML(paste("<td>",x,"</td>"))) } #or could use shiny's tags$td fxn
}
td.rep.outcome.title <- function (x) {
  if (substring(x,1,19)=="signal - consistent") {
    return(HTML(paste("<td title='replication ES 95% CI excludes 0 and includes original ES point estimate'>",x,"</td>")))  }
  else if (substring(x,1,21)=="signal - inconsistent") {
    if (substring(x,1,30)=="signal - inconsistent, smaller"){
      return(HTML(paste("<td title='replication ES 95% CI excludes 0 but also excludes original ES point estimate (smaller, same-direction)'>",x,"</td>")))  }
    else if (substring(x,1,29)=="signal - inconsistent, larger"){
      return(HTML(paste("<td title='replication ES 95% CI excludes 0 but also excludes original ES point estimate (larger, same-direction)'>",x,"</td>")))  }
    else if (substring(x,1,31)=="signal - inconsistent, opposite"){
      return(HTML(paste("<td title='replication ES 95% CI excludes 0 but also excludes original ES point estimate (opposite direction/pattern)'>",x,"</td>")))  }
    else {
      return(HTML(paste("<td title='replication ES 95% CI excludes 0 but also excludes original ES point estimate'>",x,"</td>")))  }
    }
  else if (substring(x,1,22)=="no signal - consistent"){
    return(HTML(paste("<td title='replication ES 95% CI includes 0 but also includes original ES point estimate'>",x,"</td>")))  }
  else if (substring(x,1,24)=="no signal - inconsistent"){
    return(HTML(paste("<td title='replication ES 95% CI includes 0 but excludes original ES point estimate'>",x,"</td>")))  }
  else {
    if (substring(x,1,6)=="signal"){
      return(HTML(paste("<td title='replication ES 95% CI excludes 0'>",x,"</td>")))  }
    else if (substring(x,1,9)=="no signal"){
      return(HTML(paste("<td title='replication ES 95% CI includes 0'>",x,"</td>")))  }
    else {
     return(HTML(paste("<td>",x,"</td>"))) } #or could use shiny's tags$td fxn }
  }
}
#effect.title <- function (effect.description) {
#  if (effect.description!="") {
#    return(paste(" title='",effect.description,"'")) } #on hold for now given DataTables ellipsis functions override <td> titles (use td.custom.title fxn above)
#}
replication.HTML <- function(rep.num, rep.effort.type, orig.study.number, orig.N, orig.ES.type, orig.ES, orig.ES.CI,
                             rep.N, rep.ES.type, rep.ES, rep.ES.CI, rep.study.number, rep.outcome, target.effect, 
                             rep.num.in.set, discipline, rep.method.differences, rep.active.sample.evidence, IVs, DVs, 
                             rep.type, other.outcomes, rep.open.data.URL, rep.open.materials.URL, rep.pre.reg.URL, 
                             orig.study.article.URL, rep.study.article.URL, orig.open.data.URL, orig.open.materials.URL,
                             orig.pre.reg.URL, effect.description, design, statistical.effect.type, orig.test.statistic,
                             orig.pvalue, rep.outcome.bayesian, study.order.CS, RPP.study.number, orig.article.title,EC.URL,
                             orig.study.pub.year, ES.description, include.in.HTML.table) {
  #include only most precise replications among large-scale rep efforts (to declutter table and improve performance/loading time)
  #if (substr(rep.effort.type,1,3)=="ML3") {
    row.string <- tags$tr(tags$td(NA.to.blank(target.effect)),
        tags$td(orig.study.number,PDF.HTML(orig.study.article.URL),
                data.HTML(orig.open.data.URL),materials.HTML(orig.open.materials.URL),prereg.HTML(orig.pre.reg.URL)),        
        tags$td(orig.N),
        td.custom.title(concat.ES.CI(orig.ES.type, orig.ES, orig.ES.CI),ES.description),
        tags$td(rep.N),
        td.custom.title(concat.ES.CI(rep.ES.type, rep.ES, rep.ES.CI),ES.description),
        tags$td(rep.study.number,PDF.HTML(rep.study.article.URL),
                data.HTML(rep.open.data.URL),materials.HTML(rep.open.materials.URL),
                prereg.HTML(rep.pre.reg.URL),EC.icon.HTML(EC.URL)),        
        td.rep.outcome.title(rep.outcome),
        tags$td(IVs),
        tags$td(DVs),
        tags$td(rep.type),
        tags$td(rep.effort.type),
        tags$td(rep.method.differences),
        tags$td(rep.active.sample.evidence),
        tags$td(other.outcomes),
        tags$td(effect.description))
    cat(iconv(row.string, to="UTF-8"), file="output-all-replications.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
  #}
}
replication.HTML.5.columns <- function(rep.num, rep.effort.type, orig.study.number, orig.N, orig.ES.type, orig.ES, orig.ES.CI,
                             rep.N, rep.ES.type, rep.ES, rep.ES.CI, rep.study.number, rep.outcome, target.effect, 
                             rep.num.in.set, discipline, rep.method.differences, rep.active.sample.evidence, IVs, DVs, 
                             rep.type, other.outcomes, rep.open.data.URL, rep.open.materials.URL, rep.pre.reg.URL, 
                             orig.study.article.URL, rep.study.article.URL, orig.open.data.URL, orig.open.materials.URL,
                             orig.pre.reg.URL, effect.description, design, statistical.effect.type, orig.test.statistic,
                             orig.pvalue, rep.outcome.bayesian, study.order.CS, RPP.study.number, orig.article.title,EC.URL,
                             orig.study.pub.year, ES.description, include.in.HTML.table) {
    row.string <- tags$tr(tags$td(rep.study.number,PDF.HTML(rep.study.article.URL),
                                  data.HTML(rep.open.data.URL),materials.HTML(rep.open.materials.URL),
                                  prereg.HTML(rep.pre.reg.URL),EC.icon.HTML(EC.URL)),
                          tags$td(orig.study.number,PDF.HTML(orig.study.article.URL),
                                  data.HTML(orig.open.data.URL),materials.HTML(orig.open.materials.URL),
                                  prereg.HTML(orig.pre.reg.URL)),
                          tags$td(rep.type),
                          tags$td(NA.to.blank(target.effect)),
                          tags$td(rep.effort.type))
    cat(iconv(row.string, to="UTF-8"), file="output-all-replications-5-columns.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}
replication.HTML.12.columns <- function(rep.num, rep.effort.type, orig.study.number, orig.N, orig.ES.type, orig.ES, orig.ES.CI,
                                       rep.N, rep.ES.type, rep.ES, rep.ES.CI, rep.study.number, rep.outcome, target.effect, 
                                       rep.num.in.set, discipline, rep.method.differences, rep.active.sample.evidence, IVs, DVs, 
                                       rep.type, other.outcomes, rep.open.data.URL, rep.open.materials.URL, rep.pre.reg.URL, 
                                       orig.study.article.URL, rep.study.article.URL, orig.open.data.URL, orig.open.materials.URL,
                                       orig.pre.reg.URL, effect.description, design, statistical.effect.type, orig.test.statistic,
                                       orig.pvalue, rep.outcome.bayesian, study.order.CS, RPP.study.number, orig.article.title,EC.URL,
                                       orig.study.pub.year, ES.description, include.in.HTML.table) {
  row.string <- tags$tr(tags$td(rep.study.number,PDF.HTML(rep.study.article.URL),
                                data.HTML(rep.open.data.URL),materials.HTML(rep.open.materials.URL),
                                prereg.HTML(rep.pre.reg.URL),EC.icon.HTML(EC.URL)),
                        tags$td(orig.study.number,PDF.HTML(orig.study.article.URL),
                                data.HTML(orig.open.data.URL),materials.HTML(orig.open.materials.URL),
                                prereg.HTML(orig.pre.reg.URL)),
                        tags$td(rep.type),
                        tags$td(NA.to.blank(target.effect)),
                        tags$td(rep.effort.type),
                        tags$td(orig.N),
                        td.custom.title(concat.ES.CI(orig.ES.type, orig.ES, orig.ES.CI),ES.description),
                        tags$td(rep.N),
                        td.custom.title(concat.ES.CI(rep.ES.type, rep.ES, rep.ES.CI),ES.description),
                        td.rep.outcome.title(rep.outcome),
                        tags$td(IVs),
                        tags$td(DVs))
  cat(iconv(row.string, to="UTF-8"), file="output-all-replications-12-columns.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}

gSheet.url <- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdCTs0OOhcOI9LvmHkD4bXXm_kgxv7yq79VWtxwIgmwgi_LnK-2uWc-um_pfZBgbx2cWrNliMh9v7B/pub?output=csv'
run <- function() {
  rep.table <- read.csv(url(gSheet.url), quote = "\"", stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
  for (i in 1:nrow(rep.table)) {
    #calling by header names so still works if column order changes in CSV file
    replication.HTML(rep.num=rep.table[i,"rep.num"],
                     orig.study.number=rep.table[i,"orig.study.number"],
                     orig.study.pub.year=rep.table[i,"orig.study.pub.year"],
                     orig.N=NA.to.blank(rep.table[i,"orig.N"]),
                     orig.ES.type=NA.to.blank(rep.table[i,"orig.ES.type"]),
                     orig.ES=NA.to.blank(rep.table[i,"orig.ES"]),
                     orig.ES.CI=NA.to.blank(rep.table[i,"orig.ES.CI"]),
                     rep.N=NA.to.blank(rep.table[i,"rep.N"]),
                     rep.ES.type=NA.to.blank(rep.table[i,"rep.ES.type"]),
                     rep.ES=NA.to.blank(rep.table[i,"rep.ES"]),
                     rep.ES.CI=NA.to.blank(rep.table[i,"rep.ES.CI"]),
                     rep.study.number=rep.table[i,"rep.study.number"],
                     rep.outcome=NA.to.blank(rep.table[i,"rep.outcome"]),
                     target.effect=rep.table[i,"target.effect"],
                     rep.effort.type=rep.table[i,"rep.effort.type"],
                     IVs=NA.to.blank(rep.table[i,"IVs"]),
                     DVs=NA.to.blank(rep.table[i,"DVs"]),
                     rep.type=NA.to.blank(rep.table[i,"rep.type"]),
                     rep.method.differences=NA.to.blank(rep.table[i,"rep.method.differences"]),
                     rep.active.sample.evidence=NA.to.blank(rep.table[i,"rep.active.sample.evidence"]),
                     other.outcomes=NA.to.blank(rep.table[i,"other.outcomes"]),
                     discipline=NA.to.blank(rep.table[i,"discipline"]),
                     rep.num.in.set=NA.to.blank(rep.table[i,"rep.num.in.set"]),
                     orig.study.article.URL=rep.table[i,"orig.study.article.URL"],
                     rep.study.article.URL=rep.table[i,"rep.study.article.URL"],
                     rep.open.data.URL=rep.table[i,"rep.open.data.URL"],
                     rep.open.materials.URL=rep.table[i,"rep.open.materials.URL"],
                     rep.pre.reg.URL=rep.table[i,"rep.pre.reg.URL"],
                     orig.open.data.URL=rep.table[i,"orig.open.data.URL"],
                     orig.open.materials.URL=rep.table[i,"orig.open.materials.URL"],
                     orig.pre.reg.URL=rep.table[i,"orig.pre.reg.URL"],
                     effect.description=NA.to.blank(rep.table[i,"effect.description"]),
                     design=NA.to.blank(rep.table[i,"design"]),
                     statistical.effect.type=NA.to.blank(rep.table[i,"statistical.effect.type"]),
                     orig.test.statistic=NA.to.blank(rep.table[i,"orig.test.statistic"]),
                     orig.pvalue=NA.to.blank(rep.table[i,"orig.pvalue"]),
                     rep.outcome.bayesian=NA.to.blank(rep.table[i,"rep.outcome.bayesian"]),
                     study.order.CS=NA.to.blank(rep.table[i,"study.order.CS"]),
                     RPP.study.number=NA.to.blank(rep.table[i,"RPP.study.number"]),
                     orig.article.title=NA.to.blank(rep.table[i,"orig.article.title"]),
                     EC.URL=rep.table[i,"EC.URL"],
                     ES.description=NA.to.blank(rep.table[i,"ES.description"]),
                     include.in.HTML.table=rep.table[i,"include.in.HTML.table"])
  }
}