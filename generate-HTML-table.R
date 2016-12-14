require(htmltools)
require(shiny)
#required functions to source
span.title.es <- function(effect.description, effect.size) {
  if (toString(effect.description) != "") {
    return(HTML(paste("<span title=\"",effect.description,"\"><u class='dotted'>",effect.size,"</u></span>")))} 
  else return(HTML(paste("<span title=\"\">",effect.size,"</span>")))
}
#trim and display full string in a span title
span.title <- function(text) {
  if (nchar(toString(text)) > 115) {
    return(HTML(paste("<span title=\"",text,"\">",substr(text,1,115),"</span>")))} 
  else return(text)
}

area.HTML <- function(area){
  row.string <- tags$tr(class='area',
          tags$td(colspan='8',area))
  write(as.character(row.string), file="C:/Users/Etienne/Desktop/output.txt", append=TRUE)
}

effect.HTML <- function(effect){
  row.string <- tags$tr(class='effect',
                        tags$td(colspan='8',effect))
  write(as.character(row.string), file="C:/Users/Etienne/Desktop/output.txt", append=TRUE)
}

#study.string = ",,Williams & Bargh (2008a) Study 2,,OR = 3.52 [1.0611.73],,*OR = 1.0 indicates a null effect (i.e. even odds of selfish responding),,,,"
original.HTML <- function(authors,effect.size,active.sample,effect.description,design.difference,IVs,DVs,other.outcomes){
  #v = unlist(strsplit(substr(study.string,3,nchar(study.string)), ",")) #split string to respective elements
  #author.names <- trimws(v[1])
  #effect.size <- trimws(v[3])
  #active.sample <- trimws(v[4])
  #effect.description <- trimws(v[5])
  #design.difference <- trimws(v[6])
  #IVs <- trimws(v[7])
  #DVs <- trimws(v[8])
  #other.outcomes <- gsub("NA","",toString(trimws(v[9])))
  row.string <- tags$tr(class='original',
      tags$td(HTML("<a href='' target='_blank'><img src='logos/pdf-icon.gif' class='pdf-icon'></a>",authors)),
      tags$td(HTML("<img class='open-logos' src='logos/_data.png'><img class='open-logos' src='logos/_materials.png'><img class='open-logos' src='logos/_preregisteredplus.png'>")),
      tags$td(class="original primary outcome",span.title.es(effect.description,effect.size)),
      tags$td(class="secondary active-sample",span.title(active.sample)),
      tags$td(class="secondary design-differences",span.title(design.difference)),
      tags$td(class="secondary IVs",span.title(IVs)),
      tags$td(class="secondary DVs",span.title(DVs)),
      tags$td(class="secondary outcome",span.title(other.outcomes)))
  write(as.character(row.string), file="C:/Users/Etienne/Desktop/output.txt", append=TRUE)
}

#study.string <- "1,,,Balzarini et al. (2015) Study 1,Δd = +.29 ± .46,Nudes rated as more pleasant than abstract art,,Updated pictures of abstract art & male/female nudes; Two attention check questions,Playboy centerfolds vs. control; Participant sex,Love for partner (Rubin Love-scale),"
replication.HTML <- function(authors,effect.size,active.sample,effect.description,design.difference,IVs,DVs,other.outcomes) {
  #v = unlist(strsplit(substr(study.string,5,nchar(study.string)), ",")) #split string to respective elements
  #author.names <- trimws(v[1])
  #effect.size <- trimws(v[2])
  #active.sample <- trimws(v[3])
  #effect.description <- trimws(v[4]) #not usually listed for replications
  #design.difference <- trimws(v[5])
  #IVs <- trimws(v[6])
  #DVs <- trimws(v[7])
  #other.outcomes <- gsub("NA","",toString(trimws(v[8])))
  row.string <- tags$tr(class='replication',
     tags$td(HTML("<a href='' target='_blank'><img src='logos/pdf-icon.gif' class='pdf-icon'></a>",authors)),
     tags$td(HTML("<img class='open-logos' src='logos/_data.png'><img class='open-logos' src='logos/_materials.png'><img class='open-logos' src='logos/_preregisteredplus.png'>")),
     tags$td(class="replication primary outcome",span.title.es(effect.description,effect.size)),
     tags$td(class="secondary active-sample",span.title(active.sample)),
     tags$td(class="secondary design-differences",span.title(design.difference)),
     tags$td(class="secondary IVs",span.title(IVs)),
     tags$td(class="secondary DVs",span.title(DVs)),
     tags$td(class="secondary outcome",span.title(other.outcomes)))
  write(as.character(row.string), file="C:/Users/Etienne/Desktop/output.txt", append=TRUE)
}


fuck <- function() {
  rep.table <- read.csv(header = FALSE, sep = ",", quote = "\"", file="C:/Users/Etienne/Google Drive/Curate Science/website/science-commons/curated/input.csv", stringsAsFactors=FALSE)
  for (i in 1:nrow(rep.table)) {
    if (rep.table[i,1] != ""){
        area.HTML(area=rep.table[i,1])  
    } else if (rep.table[i,2] != "") {
        effect.HTML(effect=rep.table[i,2])  
    } else if (rep.table[i,3] != "") {
        original.HTML(authors=rep.table[i,3], effect.size=rep.table[i,5],active.sample=rep.table[i,6],effect.description=rep.table[i,7],design.difference=rep.table[i,8],IVs=rep.table[i,9],DVs=rep.table[i,10],other.outcomes=rep.table[i,11])
    } else
        replication.HTML(authors=rep.table[i,4], effect.size=rep.table[i,5],active.sample=rep.table[i,6],effect.description=rep.table[i,7],design.difference=rep.table[i,8],IVs=rep.table[i,9],DVs=rep.table[i,10],other.outcomes=rep.table[i,11])
  }
} #remember to DELETE output.txt file before running function






#do different versions/functions of this for different tasks:
#1. entire original study row
#2. entire replication study row
#3. component logos <td> specifically (because will be going back to do these later)
#4. and more likely

