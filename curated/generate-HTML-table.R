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
                             outcome,target.effect,rep.num.in.set,discipline,replication.method.differences,
                             replication.positive.control.evidence,IVs,DVs,replication.type,other.outcomes,replication.open.data.URL,
                             replication.open.materials.URL,replication.pre.reg.URL,original.study.article.URL,
                             replication.study.article.URL,original.open.data.URL,original.open.materials.URL,
                             original.pre.reg.URL,effect.description,design,statistical.effect.type,original.test.statistic,
                             original.pvalue,original.N,replication.N,outcome.bayesian,study.order.CS,RPP.study.number,
                             original.article.title) {
  row.string <- tags$tr(tags$td(original.study.number,PDF.HTML(original.study.article.URL),
              data.HTML(original.open.data.URL),materials.HTML(original.open.materials.URL),prereg.HTML(original.pre.reg.URL)),        
      tags$td(original.ES),
      tags$td(replication.ES),
      tags$td(replication.study.number,PDF.HTML(replication.study.article.URL),
              data.HTML(replication.open.data.URL),materials.HTML(replication.open.materials.URL),prereg.HTML(replication.pre.reg.URL)),        
      tags$td(NA.to.blank(outcome)),
      tags$td(NA.to.blank(target.effect)),
      tags$td(NA.to.blank(rep.effort.type)),
      tags$td(NA.to.blank(IVs)),
      tags$td(NA.to.blank(DVs)),
      tags$td(NA.to.blank(replication.type)),
      tags$td(NA.to.blank(replication.method.differences)),
      tags$td(NA.to.blank(replication.positive.control.evidence)),
      tags$td(NA.to.blank(other.outcomes)),
      tags$td(NA.to.blank(discipline)),
      tags$td(NA.to.blank(rep.num)),
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
    #calling by header names so still works if column order changes in CSV file
    replication.HTML(rep.num=rep.table[i,"rep.num"],
                     original.study.number=rep.table[i,"original.study.number"],
                     original.ES=rep.table[i,"original.effect.size"],
                     replication.ES=rep.table[i,"replication.effect.size"],
                     replication.study.number=rep.table[i,"replication.study.number"],
                     outcome=rep.table[i,"outcome"],
                     target.effect=rep.table[i,"target.effect"],
                     rep.effort.type=rep.table[i,"rep.effort.type"],
                     IVs=rep.table[i,"IVs"],
                     DVs=rep.table[i,"DVs"],
                     replication.type=rep.table[i,"replication.type"],
                     replication.method.differences=rep.table[i,"replication.method.differences"],
                     replication.positive.control.evidence=rep.table[i,"replication.positive.control.evidence"],
                     other.outcomes=rep.table[i,"other.outcomes"],
                     discipline=rep.table[i,"discipline"],
                     rep.num.in.set=rep.table[i,"rep.num.in.set"],
                     original.study.article.URL=rep.table[i,"original.study.article.URL"],
                     replication.study.article.URL=rep.table[i,"replication.study.article.URL"],
                     replication.open.data.URL=rep.table[i,"replication.open.data.URL"],
                     replication.open.materials.URL=rep.table[i,"replication.open.materials.URL"],
                     replication.pre.reg.URL=rep.table[i,"replication.pre.reg.URL"],
                     original.open.data.URL=rep.table[i,"original.open.data.URL"],
                     original.open.materials.URL=rep.table[i,"original.open.materials.URL"],
                     original.pre.reg.URL=rep.table[i,"original.pre.reg.URL"],
                     effect.description=rep.table[i,"effect.description"],
                     design=rep.table[i,"design"],
                     statistical.effect.type=rep.table[i,"statistical.effect.type"],
                     original.test.statistic=rep.table[i,"original.test.statistic"],
                     original.pvalue=rep.table[i,"original.pvalue"],
                     original.N=rep.table[i,"original.N"],
                     replication.N=rep.table[i,"replication.N"],
                     outcome.bayesian=rep.table[i,"outcome.bayesian"],
                     study.order.CS=rep.table[i,"study.order.CS"],
                     RPP.study.number=rep.table[i,"RPP.study.number"],
                     original.article.title=rep.table[i,"original.article.title"])
  }
}