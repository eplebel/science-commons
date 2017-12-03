####ML1 by-site ES +/- CIs calculations and formatting code (EPL Nov 2017)###
require(metafor)
require(compute.es)
require(foreign)
require(xlsx)
require(dplyr)

ML1.data<-read.spss(file="ML1.CleanedDataset-subject-level.sav", to.data.frame=TRUE, use.value.labels=TRUE)
#attach(ML1.data)
#for each effect

#MONEY PRIMING (skipped given already had already manually calculated ES CIs)

#FLAG PRIMING
#dt_result = ML1.data %>% group_by(referrer) %>% do(tidy(t.test(flagdv ~ flagGroup))) #so close, but doesn't work somehow
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$flagdv ~ spp[[x]]$flagGroup, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= -(out[[i]]$statistic) #flip sign so ES in correct direction
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
  }
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#IMAGINED CONTACT
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$Imagineddv ~ spp[[x]]$ContactGroup, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= -(out[[i]]$statistic) #flip sign so ES in correct direction
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
}
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#SUNK COST
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$sunkDV ~ spp[[x]]$sunkgroup, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= (out[[i]]$statistic) 
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
}
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#RECIPROCITY NORM -- categorical DV: will use alternative approach
#PLAN: read in ds from ML1-all-effectsizes.xls (or .sav) file 
# and corresponding Ns from ML1-sitename-authorname-pairs.csv 
# (won't be exact Ns , but good enough for now)
#Then infer t-value using following equation: t = d * 2 sqrt(N)
#and feed into tes() ES function as usual!!
sum.data <- read.xlsx("ML1-all-effectsizes.xls", sheetName = "ML1-all-effectsizes")
rep.Ns <- read.csv("ML1-sitename-authorname-pairs.csv")
#copy remaining code for other categorical DV effects
reciprocity.data <- cbind(filter(sum.data, sum.data$Study=="reciprocityd"),rep.Ns$N) #filter effect-specific reps + add Ns column
#infer t.values from ds and Ns (standard formula; Cohen 1988)
t.values <- reciprocity.data$EffectSize * (sqrt(reciprocity.data$`rep.Ns$N`)/2)
#now use formatting functions as used above
Model.CIs<-tes(t.values,reciprocity.data$`rep.Ns$N`/2,reciprocity.data$`rep.Ns$N`/2)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#QUOTE ATTRIBUTION
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$quote ~ spp[[x]]$quoteGroup, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= -(out[[i]]$statistic) #flip sign so ES in correct direction
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
}
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#SCALE OPTIONS -- categorical DV: will use alternative approach
scale.options.data <- cbind(filter(sum.data, Study=="scalesd"),rep.Ns$N) #filter effect-specific reps + add Ns column
#infer t.values from ds and Ns (standard formula; Cohen 1988)
t.values <- scale.options.data$EffectSize * (sqrt(scale.options.data$`rep.Ns$N`)/2)
#now use formatting functions as used above
Model.CIs<-tes(t.values,scale.options.data$`rep.Ns$N`/2,scale.options.data$`rep.Ns$N`/2)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#SEX DIFFERENCES in IMPLICIT MATH ATTITUDES
#alternative solution using lapply function
ML1.data.valid.gender <- subset(ML1.data, partgender=="male" | partgender=="female") #exclude unknown genders
spp <- split(ML1.data.valid.gender, ML1.data.valid.gender$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$d_art ~ spp[[x]]$partgender, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= (out[[i]]$statistic) 
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
}
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")


#GAIN VS LOSS FRAMING -- categorical DV: will use alternative approach
gain.loss.data <- cbind(filter(sum.data, Study=="gainlossd"),rep.Ns$N) #filter effect-specific reps + add Ns column
#infer t.values from ds and Ns (standard formula; Cohen 1988)
t.values <- gain.loss.data$EffectSize * (sqrt(gain.loss.data$`rep.Ns$N`)/2)
#now use formatting functions as used above
Model.CIs<-tes(t.values,gain.loss.data$`rep.Ns$N`/2,gain.loss.data$`rep.Ns$N`/2)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")


#RETROACTIVE GAMBLER'S FALLACY
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$gambfalDV ~ spp[[x]]$gambfalgroup, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= -(out[[i]]$statistic) #flip sign so ES in correct direction
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
}
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#implicit-explicit math attitude correlation
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- cor.test(spp[[x]]$IATexp.overall, spp[[x]]$d_art)) #correlation test
#convert list to array through sites where 1=abington, 2=brasilia, etc
r.array=array(0,dim=36)
n.array=array(0,dim=36)
for (i in 1:length(out)) {
  r.array[i]= out[[i]]$estimate
  n.array[i]= out[[i]]$parameter+2
}
Model.CIs<-res(r=r.array,n=n.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#ANCHORING EFFECT (population of chicago DV)
#alternative solution using lapply function
spp <- split(ML1.data, ML1.data$referrer,drop=FALSE) 
out <- vector("list", length = length(spp))
out <- lapply(1:length(spp),function (x) out[[x]]<- t.test(spp[[x]]$Ranch2 ~ spp[[x]]$anch2group, var.equal=TRUE))
#convert list to array through sites where 1=abington, 2=brasilia, etc
t.array=array(0,dim=36)
n1.array=array(0,dim=36)
n2.array=array(0,dim=36)
for (i in 1:length(out)) {
  t.array[i]= -(out[[i]]$statistic) #flip sign so ES in correct direction
  n1.array[i]= (out[[i]]$parameter+2)/2
  n2.array[i]= (out[[i]]$parameter+2)/2
}
Model.CIs<-tes(t.array,n1.array,n2.array)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")

#QUESTION PHRASING EFFECT -- categorical DV: will use alternative approach
question.phrasing.data <- cbind(filter(sum.data, Study=="allowedforbiddend"),rep.Ns$N) #filter effect-specific reps + add Ns column
#infer t.values from ds and Ns (standard formula; Cohen 1988)
t.values <- question.phrasing.data$EffectSize * (sqrt(question.phrasing.data$`rep.Ns$N`)/2)
#now use formatting functions as used above
Model.CIs<-tes(t.values,question.phrasing.data$`rep.Ns$N`/2,question.phrasing.data$`rep.Ns$N`/2)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
