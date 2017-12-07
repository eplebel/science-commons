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
#effect.title <- function (effect.description) {
#  if (effect.description!="") {
#    return(paste(" title='",effect.description,"'"))  } #on hold for now given DataTables ellipsis functions override <td> titles
#}
replication.HTML <- function(rep.num, rep.effort.type, orig.study.number, orig.effect.size, rep.effect.size,
                             rep.study.number, rep.outcome, target.effect, rep.num.in.set, discipline, rep.method.differences,
                             rep.active.sample.evidence, IVs, DVs, rep.type, other.outcomes, rep.open.data.URL,
                             rep.open.materials.URL, rep.pre.reg.URL, orig.study.article.URL,
                             rep.study.article.URL, orig.open.data.URL, orig.open.materials.URL,
                             orig.pre.reg.URL, effect.description, design, statistical.effect.type, orig.test.statistic,
                             orig.pvalue, orig.N, rep.N, rep.outcome.bayesian, study.order.CS, RPP.study.number,
                             orig.article.title,EC.URL) {
  row.string <- tags$tr(tags$td(NA.to.blank(target.effect)),
      tags$td(orig.study.number,PDF.HTML(orig.study.article.URL),
              data.HTML(orig.open.data.URL),materials.HTML(orig.open.materials.URL),prereg.HTML(orig.pre.reg.URL)),        
      tags$td(orig.effect.size),
      tags$td(rep.effect.size),
      tags$td(rep.study.number,PDF.HTML(rep.study.article.URL),
              data.HTML(rep.open.data.URL),materials.HTML(rep.open.materials.URL),
              prereg.HTML(rep.pre.reg.URL),EC.icon.HTML(EC.URL)),        
      tags$td(NA.to.blank(rep.outcome)),
      tags$td(NA.to.blank(IVs)),
      tags$td(NA.to.blank(DVs)),
      tags$td(NA.to.blank(rep.type)),
      tags$td(NA.to.blank(rep.effort.type)),
      tags$td(NA.to.blank(rep.method.differences)),
      tags$td(NA.to.blank(rep.active.sample.evidence)),
      tags$td(NA.to.blank(other.outcomes)),
      tags$td(NA.to.blank(effect.description)))
  cat(iconv(row.string, to="UTF-8"), file="output-all-replications.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}
gSheet.url <- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdCTs0OOhcOI9LvmHkD4bXXm_kgxv7yq79VWtxwIgmwgi_LnK-2uWc-um_pfZBgbx2cWrNliMh9v7B/pub?output=csv'
run <- function() {
  rep.table <- read.csv(url(gSheet.url), quote = "\"", stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
  for (i in 1:nrow(rep.table)) {
    #calling by header names so still works if column order changes in CSV file
    replication.HTML(rep.num=rep.table[i,"rep.num"],
                     orig.study.number=rep.table[i,"original.study.number"],
                     orig.effect.size=rep.table[i,"original.effect.size"],
                     rep.effect.size=rep.table[i,"replication.effect.size"],
                     rep.study.number=rep.table[i,"replication.study.number"],
                     rep.outcome=rep.table[i,"rep.outcome"],
                     target.effect=rep.table[i,"target.effect"],
                     rep.effort.type=rep.table[i,"rep.effort.type"],
                     IVs=rep.table[i,"IVs"],
                     DVs=rep.table[i,"DVs"],
                     rep.type=rep.table[i,"rep.type"],
                     rep.method.differences=rep.table[i,"rep.method.differences"],
                     rep.active.sample.evidence=rep.table[i,"rep.active.sample.evidence"],
                     other.outcomes=rep.table[i,"other.outcomes"],
                     discipline=rep.table[i,"discipline"],
                     rep.num.in.set=rep.table[i,"rep.num.in.set"],
                     orig.study.article.URL=rep.table[i,"orig.study.article.URL"],
                     rep.study.article.URL=rep.table[i,"rep.study.article.URL"],
                     rep.open.data.URL=rep.table[i,"rep.open.data.URL"],
                     rep.open.materials.URL=rep.table[i,"rep.open.materials.URL"],
                     rep.pre.reg.URL=rep.table[i,"rep.pre.reg.URL"],
                     orig.open.data.URL=rep.table[i,"orig.open.data.URL"],
                     orig.open.materials.URL=rep.table[i,"orig.open.materials.URL"],
                     orig.pre.reg.URL=rep.table[i,"orig.pre.reg.URL"],
                     effect.description=rep.table[i,"effect.description"],
                     design=rep.table[i,"design"],
                     statistical.effect.type=rep.table[i,"statistical.effect.type"],
                     orig.test.statistic=rep.table[i,"orig.test.statistic"],
                     orig.pvalue=rep.table[i,"orig.pvalue"],
                     orig.N=rep.table[i,"orig.N"],
                     rep.N=rep.table[i,"rep.N"],
                     rep.outcome.bayesian=rep.table[i,"rep.outcome.bayesian"],
                     study.order.CS=rep.table[i,"study.order.CS"],
                     RPP.study.number=rep.table[i,"RPP.study.number"],
                     orig.article.title=rep.table[i,"orig.article.title"],
                     EC.URL=rep.table[i,"EC.URL"])
  }
}