require(htmltools)
require(shiny) #required functions to source

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
NA.to.blank <- function (x) {
  if (is.na(x)) {
  return(replace(x,is.na(x),""))  }
  else return(x)
}
replication.HTML <- function(rep.num,rep.effort.type,original.study.number,original.ES,replication.ES,replication.study.number,
                             outcome,target.effect,rep.num.in.set,discipline,replication.method.differences,replication.positive.controls,
                             IVs,DVs,other.outcomes,replication.open.data.URL,replication.open.materials.URL,replication.pre.reg.URL,
                             original.study.article.URL,replication.study.article.URL,original.open.data.URL,original.open.materials.URL,
                             original.pre.reg.URL,effect.description,design,statistical.effect.type,original.test.statistic,original.pvalue,
                             original.N,replication.N,outcome.bayesian,study.order.CS,RPP.study.number,original.article.title) {
  row.string <- tags$tr(tags$td(class='lockcolumnclass', style='background:lightgrey',original.study.number,PDF.HTML(original.study.article.URL),
              data.HTML(original.open.data.URL),materials.HTML(original.open.materials.URL),prereg.HTML(original.pre.reg.URL)),        
      tags$td(class='lockcolumnclass', style='background:lightgrey;font-weight:bold',original.ES),
      tags$td(class='lockcolumnclass', style='background:lightgrey;font-weight:bold',replication.ES),
      tags$td(replication.study.number,PDF.HTML(replication.study.article.URL),
              data.HTML(replication.open.data.URL),materials.HTML(replication.open.materials.URL),prereg.HTML(replication.pre.reg.URL)),        
      tags$td(NA.to.blank(outcome)),
      tags$td(NA.to.blank(discipline)),
      tags$td(NA.to.blank(target.effect)),
      tags$td(NA.to.blank(rep.effort.type)),
      tags$td(NA.to.blank(rep.num)),
      tags$td(NA.to.blank(replication.method.differences)),
      tags$td(NA.to.blank(replication.positive.controls)),
      tags$td(NA.to.blank(other.outcomes)),
      tags$td(NA.to.blank(IVs)),
      tags$td(NA.to.blank(DVs)),
      tags$td(NA.to.blank(effect.description)),
      tags$td(NA.to.blank(design)),
      tags$td(NA.to.blank(statistical.effect.type)),
      tags$td(NA.to.blank(original.test.statistic)),
      tags$td(NA.to.blank(original.pvalue)))
  cat(iconv(row.string, to="UTF-8"), file="output-all-replications.txt",append=TRUE) #needed to fix stupid Windows locale problem$@##@%!
}
run <- function(file="C:/Users/Etienne/Google Drive/Curate Science/website/science-commons/curated/replications-master-file.csv") {
  rep.table <- read.csv(header = TRUE, sep = ",", quote = "\"", file=file, stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
  for (i in 1:nrow(rep.table)) {
    #these should be called by header names so still works if column order changes, e.g,original.ES=rep.table[i,"original.effect.size"]
    replication.HTML(rep.num=rep.table[i,1],
                     rep.effort.type=rep.table[i,2],
                     original.study.number=rep.table[i,3],
                     original.ES=rep.table[i,4],
                     replication.ES=rep.table[i,5],
                     replication.study.number=rep.table[i,6],
                     outcome=rep.table[i,7],
                     target.effect=rep.table[i,8],
                     rep.num.in.set=rep.table[i,9],
                     discipline=rep.table[i,10],
                     replication.method.differences=rep.table[i,11],
                     replication.positive.controls=rep.table[i,12],
                     IVs=rep.table[i,13],
                     DVs=rep.table[i,14],
                     other.outcomes=rep.table[i,15],
                     replication.open.data.URL=rep.table[i,16],
                     replication.open.materials.URL=rep.table[i,17],
                     replication.pre.reg.URL=rep.table[i,18],
                     original.study.article.URL=rep.table[i,19],
                     replication.study.article.URL=rep.table[i,20],
                     original.open.data.URL=rep.table[i,21],
                     original.open.materials.URL=rep.table[i,22],
                     original.pre.reg.URL=rep.table[i,23],
                     effect.description=rep.table[i,24],
                     design=rep.table[i,25],
                     statistical.effect.type=rep.table[i,26],
                     original.test.statistic=rep.table[i,27],
                     original.pvalue=rep.table[i,28],
                     original.N=rep.table[i,29],
                     replication.N=rep.table[i,30],
                     outcome.bayesian=rep.table[i,31],
                     study.order.CS=rep.table[i,32],
                     RPP.study.number=rep.table[i,33],
                     original.article.title=rep.table[i,34])
  }
}