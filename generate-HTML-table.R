require(htmltools)
require(shiny) #required functions to source

data.HTML <- function(data.URL) {
  if (toString(data.URL) != "") {
    return(HTML(paste("<td><a href=\"",data.URL,"\" target=\"_blank\"><img class='open-logos active' src='logos/_data.png' title='This study has open data'></a>")))} 
  else return(HTML(paste("<td><img class='open-logos' src='logos/_data.png'>")))
}
materials.HTML <- function(materials.URL) {
  if (toString(materials.URL) != "") {
    return(HTML(paste("<a href=\"",materials.URL,"\" target=\"_blank\"><img class='open-logos active' src='logos/_materials.png' title='This study has open materials'></a>")))} 
  else return(HTML(paste("<img class='open-logos' src='logos/_materials.png'>")))
}
prereg.HTML <- function(prereg.URL) {
  if (toString(prereg.URL) != "") {
    return(HTML(paste("<a href=\"",prereg.URL,"\" target=\"_blank\"><img class='open-logos active' src='logos/_preregisteredplus.png' title='Study and analysis plans were pre-registered'></a></td>")))} 
  else return(HTML(paste("<img class='open-logos' src='logos/_preregisteredplus.png'></td>")))
}

badges.HTML <- function(data.URL="",materials.URL="",prereg.URL=""){
  data.string <- data.HTML(toString(data.URL))
  materials.string <- materials.HTML(toString(materials.URL))
  prereg.string <- prereg.HTML(toString(prereg.URL))
  writeClipboard(HTML(paste(data.string,materials.string,prereg.string)))
  return(HTML(paste(data.string,materials.string,prereg.string)))
}

span.title.es <- function(effect.description, effect.size) {
  if (toString(effect.description) != "") {
    return(HTML(paste("<span title=\"",effect.description,"\"><u class='dotted'>",effect.size,"</u></span>")))} 
  else return(HTML(paste("<span title=\"\">",effect.size,"</span>")))
}

#trim and display full string in a span title for elements greater than 110 characters
span.title <- function(text) {
  if (nchar(toString(text)) > 110) {
    return(HTML(paste("<span title=\"",text,"\">",substr(text,1,110),"</span>")))} 
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

original.HTML <- function(authors,effect.size,active.sample,effect.description,design.difference,IVs,DVs,other.outcomes){
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

replication.HTML <- function(authors,effect.size,active.sample,effect.description,design.difference,IVs,DVs,other.outcomes) {
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

run <- function(file="C:/Users/Etienne/Google Drive/Curate Science/website/science-commons/curated/input.csv") {
  rep.table <- read.csv(header = FALSE, sep = ",", quote = "\"", file=file, stringsAsFactors=FALSE)
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

