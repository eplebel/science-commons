
##################################################

#Load the necessary libraries. Make sure these have been downloaded. 

library(meta)
library(metafor)
library(MAd)
library(MASS)
library(pwr)
library(Cairo)
library(ggplot2)

##################################################

#Run the following function for contour-enhanced funnel plots (used for Figures 1 and 2).
 
#arguments:
#d = variable name of the effect size
#ste = variable name of the standard error of effect size 
#pt = variable name of dummy code for publication (1 = published)
#xlimits = the min and max for the x axis
#pLine = T if you want to include the best fit line for PET, F otherwise
#peLine = T if you want to include the best fit line for PEESE, F otherwise
#To change the default colors, modify within the function below.

plotFunnel = function(d,ste,pt,title,xlimits,pLine,peLine){
  
  var = ste^2                     #get the variance of the effect size
  MA=rma(yi=d, vi=var, knha = T)  #run a standard MA model (note use of knha)
  
  shadeCol = "light blue"         #shade color, null contour  
  unPubCol = "black"              #border color, unpublished points 
  unPubPCH = 21                   #type, unpublished points
  unPubBG = "white"               #fill color, published points
  pubCol = "black"                #border color, published points
  pubPCH = 21                     #type, published points
  pubBG = "dark red"              #fill color, published points
  petCol="red"                    #best fit line, PET
  peeseCol="red"                  #best fit line, PEESE
  
  #set the funnel plot with the contours
  funnel(MA, refline=0, xlim=xlimits, shade=shadeCol,back="white",xlab=expression(italic("g")), 
         ylab=expression(italic("SE")), main=title, cex.main=1.5, pch=19, xaxt="n", yaxt="n",
         cex.lab=1.4,family = "serif")
  par(new = T)
  funnel(MA, xlim=xlimits, shade=NULL, back=NULL,hlines = NULL,xlab=NA, ylab=NA, main=NA, pch=19,
         family = "serif")
  #add in points color-coded for publication status
  points(subset(d,pt==1),subset(ste,pt==1),col = pubCol,pch=pubPCH,bg=pubBG)
  points(subset(d,pt==0),subset(ste,pt==0),col = unPubCol,pch=unPubPCH,bg=unPubBG)
  #add best fit lines for WLS models (if requested)
  #PET
  if (pLine==T){
    pet = lm(d ~ ste, weights=1/var)
    petb0=as.numeric(pet$coefficients[1])
    petb1=as.numeric(pet$coefficients[2])
    se = seq(0,max(ste),.01)
    y = matrix(NA,length(se))
    for (i in 1:length(y)){
      y[i] = petb0 + petb1*se[i]
    }
    lines(x=y, y=se, typ='l',col=petCol)
  }
  #PEESE
  if (peLine==T){
    peese = lm(d ~ var, weights=1/var)
    peeseb0=as.numeric(peese$coefficients[1])
    peeseb1=as.numeric(peese$coefficients[2])
    se = seq(0,max(ste),.01)
    v = se^2
    y = matrix(NA,length(se))
    for (i in 1:length(y)){
      y[i] = peeseb0 + peeseb1*v[i]
    }
    lines(x=y, y=se, typ='l',col=peeseCol) 
  }
}


##################################################

#Load the data frames, either created and saved by the DataFrames script
#or provided in the data frames file. Do this with the load() function.
#For example, enter the following to load the Hand Grip data frame,
#where the path preceeding the .RData file corresponds to where the
#data frame file has been saved. 

#load("C:/Users/User'sName/Documents/Data/HG.Rdata")

#Note the direction of the slashes.

##################################################

#Figure 1

pLine=F
peLine=F

#CairoPNG(file="egoDepMA_Fig1.png", width = 2500, height = 1200, res = 250)
CairoPDF("EgoDepMA_Fig1.pdf",11,5)
layout(matrix(c(1:8), 2, 4, byrow = T), respect = TRUE)
#FC
plotFunnel(d=FC$g,ste=FC$g_se,pt=FC$PubType,title="Food Consumed",xlimits=c(-1,3),pLine,peLine)
#HG
plotFunnel(d=HG$g,ste=HG$g_se,pt=HG$PubType,title="Hand Grip",xlimits=c(-1,1.5),pLine,peLine)
#IA
plotFunnel(d=IA$g,ste=IA$g_se,pt=IA$PubType,title="Impossible Anagrams",xlimits=c(-1,2),pLine,peLine)
#IP
plotFunnel(d=IP$g,ste=IP$g_se,pt=IP$PubType,title="Impossible Puzzles",xlimits=c(-1,2),pLine,peLine)
#PA
plotFunnel(d=PA$g,ste=PA$g_se,pt=PA$PubType,title="Possible Anagrams",xlimits=c(-1,1.5),pLine,peLine)
#S
plotFunnel(d=S$g,ste=S$g_se,pt=S$PubType,title="Stroop",xlimits=c(-1,1.5),pLine,peLine)
#ST
plotFunnel(d=ST$g,ste=ST$g_se,pt=ST$PubType,title="Standardized Tests",xlimits=c(-1,1.5),pLine,peLine)
#WM
plotFunnel(d=WM$g,ste=WM$g_se,pt=WM$PubType,title="Working Memory",xlimits=c(-1,1.5),pLine,peLine)
dev.off()

##################################################

#Figure 2

pLine=F
peLine=F

#CairoPNG(file="egoDepMA_Fig2.png", width = 2500, height = 1200, res = 250)
CairoPDF("EgoDepMA_Fig2.pdf",11,5)
plotFunnel(d=ALL$g_ALL,ste=ALL$g_se_ALL,pt=ALL$PubType_ALL,title=NULL,xlimits=c(-1,3),pLine,peLine)
dev.off()

##################################################

#Figure 3

#Removed those effect sizes that have more than one frequently used IV.
#For those that appear in more than one dataset, removed them and then 
#added them back with aggregated sample size as in the ALL data frame.
                                                                     
Dep_n = c(FC$Dep_n,
          HG$Dep_n,
          subset(IA$Dep_n,IA$IV!="WM/AV" & paste0(IA$Author,IA$Exp)!="Barber1"
                 & IA$Author!="MuravenS"),
          subset(IP$Dep_n,IP$IV!="TS/FT"),
          subset(PA$Dep_n,PA$IV!="CL/S"),
          subset(S$Dep_n,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
          subset(ST$Dep_n,ST$IV!="CL/S"),
          WM$Dep_n,
          38,18)                      #For Barber and MuravenS

Con_n = c(FC$Con_n,
          HG$Con_n,
          subset(IA$Con_n,IA$IV!="WM/AV" & paste0(IA$Author,IA$Exp)!="Barber1"
                 & IA$Author!="MuravenS"),
          subset(IP$Con_n,IP$IV!="TS/FT"),
          subset(PA$Con_n,PA$IV!="CL/S"),
          subset(S$Con_n,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
          subset(ST$Con_n,ST$IV!="CL/S"),
          WM$Con_n,
          38,18)                 #For Barber and MuravenS

N = Dep_n + Con_n

df = data.frame(N)

#CairoPNG(file="egoDepMA_Fig3.png", width = 2100, height = 1200, res = 250)
CairoPDF("EgoDepMA_Fig3.pdf",11,8)
ggplot(df, aes(x=N)) + geom_histogram(binwidth = 5, fill = "grey", colour = "black") +
  theme_classic()+
  theme(axis.text.x = element_text(size = 20, family = "serif"),
        axis.text.y = element_text(size = 20, family = "serif"),
        axis.title.x = element_text(size = 25, family = "serif", vjust =-0.4),
        axis.title.y = element_text(size = 25, family = "serif", vjust =1.5)) + 
  xlab("Sample Size") +
  ylab("Frequency")
dev.off()

##################################################

#Figure 4

IV = c(as.character(FC$IV),                             
       as.character(HG$IV),                                                           
       as.character(subset(IA$IV,IA$IV!="WM/AV" & paste0(IA$Author,IA$Exp)!="Barber1" 
                           & IA$Author!="MuravenS")),
       as.character(subset(IP$IV,IP$IV!="TS/FT")),                                    
       as.character(subset(PA$IV,PA$IV!="CL/S")),                                     
       as.character(subset(S$IV,paste0(S$Author,S$Exp)!="Barber1"                     
                           & S$Author!="MuravenS")),
       as.character(subset(ST$IV,ST$IV!="CL/S")),                                     
       as.character(WM$IV),
       "T","EV") 

meds = rep(NA,length(N))
for (i in 1:length(N)){
  if (IV[i] == "AE"){meds[i] = median(subset(df$N,df$IV=="AE"))}else
  if (IV[i] == "AV"){meds[i] = median(subset(df$N,df$IV=="AV"))}else
  if (IV[i] == "CL"){meds[i] = median(subset(df$N,df$IV=="CL"))}else
  if (IV[i] == "EV"){meds[i] = median(subset(df$N,df$IV=="EV"))}else
  if (IV[i] == "FT"){meds[i] = median(subset(df$N,df$IV=="FT"))}else
  if (IV[i] == "M"){meds[i] = median(subset(df$N,df$IV=="M"))}else
  if (IV[i] == "S"){meds[i] = median(subset(df$N,df$IV=="S"))}else
  if (IV[i] == "SE"){meds[i] = median(subset(df$N,df$IV=="SE"))}else
  if (IV[i] == "T"){meds[i] = median(subset(df$N,df$IV=="SE"))}else
  if (IV[i] == "TS"){meds[i] = median(subset(df$N,df$IV=="SE"))}else
  if (IV[i] == "WM"){meds[i] = median(subset(df$N,df$IV=="SE"))}
}

df = data.frame(IV,N,meds) 

#CairoPNG(file="egoDepMA_Fig4.png", width = 2100, height = 1200, res = 250)
CairoPDF("EgoDepMA_Fig4.pdf",11,5)
ggplot(df, aes(y = N, x=IV)) +
  geom_point(size = 2)+
  geom_point(aes(y = meds),color = "red", shape = 95, size = 10)+
  theme_classic()+
  theme(axis.text.x = element_text(size = 20, family = "serif"),
        axis.text.y = element_text(size = 20, family = "serif"),
        axis.title.x = element_text(size = 25, family = "serif", vjust =-.4),
        axis.title.y = element_text(size = 25, family = "serif", vjust = 1.5)) + 
  xlab("Manipulation Task") +
  ylab("Sample Size") 

dev.off()

