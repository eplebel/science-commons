#Load the necessary packages (make sure each is downloaded first)
library(metafor)
library(pwr)
library(AER)
library(MASS)
##################################################

#Load the data frames, either created and saved by the DataFrames script
#or provided in the data frames file. Do this with the load() function.
#For example, enter the following to load the Hand Grip data frame,
#where the path preceeding the .RData file corresponds to where the
#data frame file has been saved. 

#load("C:/Users/User'sName/Documents/Data/HG.Rdata")

#Note the direction of the slashes.

##################################################

#Run the following to create a function for using TES

TES<-function(pVals,meanPWR){
  
  x=length(subset(pVals,pVals<.05)) #number of significant results
  n=length(pVals) #total number of results
  p=meanPWR #average pwr
  
  #Binom test using meanPWR, return TES
  return(binom.test(x,n,p=p,alternative="greater")$p.value)
}


##################################################
#FC

#models
fcMA=rma(FC$g, FC$g_v, knha = T)

fcMods=rma(FC$g, FC$g_v, mods= ~FC$Baum, knha = T)

fcTF=trimfill(fcMA)

fcPET=lm(FC$g~FC$g_se,weights=1/FC$g_v)

fcPEESE=lm(FC$g~FC$g_v,weights=1/FC$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(fcMA$b), n1=FC$Dep_n, n2=FC$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(fcMA$ci.ub), n1=FC$Dep_n, n2=FC$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(fcMA$ci.lb), n1=FC$Dep_n, n2=FC$Con_n)
llPow=powCalcLL$power

fcIndTES=TES(FC$p,mean(FC$pow))
fcRETES=TES(FC$p,mean(rePow))
fcULTES=TES(FC$p,mean(ulPow))
fcLLTES=TES(FC$p,mean(llPow))


##################################################
#HG

#models
hgMA=rma(HG$g, HG$g_v, knha = T)

hgTF=trimfill(hgMA)

hgPET=lm(HG$g~HG$g_se,weights=1/HG$g_v)

hgPEESE=lm(HG$g~HG$g_v,weights=1/HG$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(hgMA$b), n1=HG$Dep_n, n2=HG$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(hgMA$ci.ub), n1=HG$Dep_n, n2=HG$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(hgMA$ci.lb), n1=HG$Dep_n, n2=HG$Con_n)
llPow=powCalcLL$power

hgIndTES=TES(HG$p,mean(HG$pow))
hgRETES=TES(HG$p,mean(rePow))
hgULTES=TES(HG$p,mean(ulPow))
hgLLTES=TES(HG$p,mean(llPow))


##################################################
#IA

#models
iaMA=rma(IA$g, IA$g_v, knha = T)

iaMods=rma(IA$g, IA$g_v, mods= ~IA$PubType+IA$Baum+IA$M_IV+IA$M_DV, knha = T)

iaTF=trimfill(iaMA)

iaPET=lm(IA$g~IA$g_se,weights=1/IA$g_v)

iaPEESE=lm(IA$g~IA$g_v,weights=1/IA$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(iaMA$b), n1=IA$Dep_n, n2=IA$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(iaMA$ci.ub), n1=IA$Dep_n, n2=IA$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(iaMA$ci.lb), n1=IA$Dep_n, n2=IA$Con_n)
llPow=powCalcLL$power

iaIndTES=TES(IA$p,mean(IA$pow))
iaRETES=TES(IA$p,mean(rePow))
iaULTES=TES(IA$p,mean(ulPow))
iaLLTES=TES(IA$p,mean(llPow))


##################################################
#IP

#models
ipMA=rma(IP$g, IP$g_v, knha = T)

ipMods=rma(IP$g, IP$g_v, mods= ~IP$PubType+IP$Baum, knha = T)

ipTF=trimfill(ipMA)

ipPET=lm(IP$g~IP$g_se,weights=1/IP$g_v)

ipPEESE=lm(IP$g~IP$g_v,weights=1/IP$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(ipMA$b), n1=IP$Dep_n, n2=IP$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(ipMA$ci.ub), n1=IP$Dep_n, n2=IP$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(ipMA$ci.lb), n1=IP$Dep_n, n2=IP$Con_n)
llPow=powCalcLL$power

ipIndTES=TES(IP$p,mean(IP$pow))
ipRETES=TES(IP$p,mean(rePow))
ipULTES=TES(IP$p,mean(ulPow))
ipLLTES=TES(IP$p,mean(llPow))

##################################################
#PA

paMA=rma(PA$g, PA$g_v, knha = T)

paMods=rma(PA$g, PA$g_v, mods= ~PA$Baum + PA$M_IV, knha = T)

funnel(paMA)

paTF=trimfill(paMA)

paPET=lm(PA$g~PA$g_se,weights=1/PA$g_v)
paPEESE=lm(PA$g~PA$g_v,weights=1/PA$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(paMA$b), n1=PA$Dep_n, n2=PA$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(paMA$ci.ub), n1=PA$Dep_n, n2=PA$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(paMA$ci.lb), n1=PA$Dep_n, n2=PA$Con_n)
llPow=powCalcLL$power

paIndTES=TES(PA$p,mean(PA$pow))
paRETES=TES(PA$p,mean(rePow))
paULTES=TES(PA$p,mean(ulPow))
paLLTES=TES(PA$p,mean(llPow))

##################################################
#S

sMA=rma(S$g, S$g_v, knha = T)

sMods=rma(S$g, S$g_v, mods= ~S$Baum+S$PubType+S$M_DV, knha = T)

sTF=trimfill(sMA)

sPET=lm(S$g~S$g_se,weights=1/S$g_v)

sPEESE=lm(S$g~S$g_v,weights=1/S$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(sMA$b), n1=S$Dep_n, n2=S$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(sMA$ci.ub), n1=S$Dep_n, n2=S$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(sMA$ci.lb), n1=S$Dep_n, n2=S$Con_n)
llPow=powCalcLL$power

sIndTES=TES(S$p,mean(S$pow))
sRETES=TES(S$p,mean(rePow))
sULTES=TES(S$p,mean(ulPow))
sLLTES=TES(S$p,mean(llPow))

###############################
# S with YostM_2009_1 removed #
###############################

S1 = subset(S, S$Dep_n<128)

s1MA=rma(S1$g, S1$g_v, knha = T)
s1Mods=rma(S1$g, S1$g_v, mods= ~S1$Baum+S1$PubType+S1$M_DV, knha = T)
s1TF=trimfill(s1MA)
s1PET=lm(S1$g ~ S1$g_se, weights=1/S1$g_v)
s1PEESE=lm(S1$g ~ S1$g_v, weights=1/S1$g_v)


##################################################
#ST

#models
stMA=rma(ST$g, ST$g_v, knha = T)

stMods=rma(ST$g, ST$g_v, mods= ~ST$Baum + ST$PubType, knha = T)
 
stTF=trimfill(stMA)

stPET=lm(ST$g~ST$g_se,weights=1/ST$g_v)

stPEESE=lm(ST$g~ST$g_v,weights=1/ST$g_v)

#############################
# Without Schmeichel_2003_1 #
#############################
stPET1 = lm(subset(ST$g,ST$g<1)~subset(ST$g_se,ST$g<1),weights=1/subset(ST$g_v,ST$g<1))
stPEESE1 = lm(subset(ST$g,ST$g<1)~subset(ST$g_v,ST$g<1),weights=1/subset(ST$g_v,ST$g<1))

#TES
powCalcRE=pwr.t2n.test(as.numeric(stMA$b), n1=ST$Dep_n, n2=ST$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(stMA$ci.ub), n1=ST$Dep_n, n2=ST$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(stMA$ci.lb), n1=ST$Dep_n, n2=ST$Con_n)
llPow=powCalcLL$power

stIndTES=TES(ST$p,mean(ST$pow))
stRETES=TES(ST$p,mean(rePow))
stULTES=TES(ST$p,mean(ulPow))
stLLTES=TES(ST$p,mean(llPow))

##################################################
#WM

wmMA=rma(WM$g, WM$g_v, knha = T)

wmMods=rma(WM$g, WM$g_v, mods= ~WM$Baum + WM$PubType, knha = T)

wmTF=trimfill(wmMA)

wmPET=lm(WM$g~WM$g_se,weights=1/WM$g_v)

wmPEESE=lm(WM$g~WM$g_v,weights=1/WM$g_v)

#TES
powCalcRE=pwr.t2n.test(as.numeric(wmMA$b), n1=WM$Dep_n, n2=WM$Con_n)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(wmMA$ci.ub), n1=WM$Dep_n, n2=WM$Con_n)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(wmMA$ci.lb), n1=WM$Dep_n, n2=WM$Con_n)
llPow=powCalcLL$power

wmIndTES=TES(WM$p,mean(WM$pow))
wmRETES=TES(WM$p,mean(rePow))
wmULTES=TES(WM$p,mean(ulPow))
wmLLTES=TES(WM$p,mean(llPow))

##################################################
#ALL

allMA=rma(ALL$g_ALL, ALL$g_v_ALL, knha = T)

allMods=rma(ALL$g_ALL, ALL$g_v_ALL, mods= ~ALL$M_IV_ALL + 
              ALL$M_DV_ALL + ALL$PubType_ALL + ALL$Baum_ALL, knha = T)

allTF=trimfill(allMA)

allPET=lm(ALL$g_ALL~ALL$g_se_ALL,weights=1/ALL$g_v_ALL)

allPEESE=lm(ALL$g_ALL~ALL$g_v_ALL,weights=1/ALL$g_v_ALL)

#TES
powCalcRE=pwr.t2n.test(as.numeric(allMA$b), n1=ALL$Dep_n_ALL, n2=ALL$Con_n_ALL)
rePow=powCalcRE$power
powCalcUL=pwr.t2n.test(as.numeric(allMA$ci.ub), n1=ALL$Dep_n_ALL, n2=ALL$Con_n_ALL)
ulPow=powCalcUL$power
powCalcLL=pwr.t2n.test(as.numeric(allMA$ci.lb), n1=ALL$Dep_n_ALL, n2=ALL$Con_n_ALL)
llPow=powCalcLL$power

allIndTES=TES(ALL$p_ALL,mean(ALL$pow_ALL))
allRETES=TES(ALL$p_ALL,mean(rePow))
allULTES=TES(ALL$p_ALL,mean(ulPow))
allLLTES=TES(ALL$p_ALL,mean(llPow))

#################################################
# Analysis for ALL dataset without YostM_2009_1 #
#################################################

ALL1 = subset(ALL,ALL$Dep_n_ALL<129)

all1MA=rma(ALL1$g_ALL, ALL1$g_v_ALL, knha = T)
all1Mods=rma(ALL1$g_ALL, ALL1$g_v_ALL, mods= ~ALL1$M_IV_ALL + 
              ALL1$M_DV_ALL + ALL1$PubType_ALL + ALL1$Baum_ALL, knha = T)
all1TF=trimfill(all1MA)
all1PET=lm(ALL1$g_ALL~ALL1$g_se_ALL,weights=1/ALL1$g_v_ALL)
all1PEESE=lm(ALL1$g_ALL~ALL1$g_v_ALL,weights=1/ALL1$g_v_ALL)


#######################################


#########################
# N as a function of IV #
#########################

#Removed those effect sizes that have more than one frequently used IV.
#For those that appear in more than one dataset b/c they have more than one
#IV, removed them and then added them back with aggregated sample size as 
#in the ALL data frame.

#Length of IV is 97
IV = c(as.character(FC$IV),                             
       as.character(HG$IV),                                                           
       as.character(subset(IA$IV,IA$IV!="WM/AV" & paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS")),
       as.character(subset(IP$IV,IP$IV!="TS/FT")),                                    
       as.character(subset(PA$IV,PA$IV!="CL/S")),                                     
       as.character(subset(S$IV,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS")),
       as.character(subset(ST$IV,ST$IV!="CL/S")),                                     
       as.character(WM$IV),
       "T","EV")                                                                      

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

mean(N)

var(N)

pIV=glm(N~IV, family=poisson)
summary(pIV)

dispersiontest(pIV)

qpIV=glm(N~IV, family=quasipoisson)
summary(qpIV)

#removing YostM_2009_1. 
qpIV_outl=glm(subset(N,N<250)~subset(IV,N<250), family=quasipoisson)
summary(qpIV_outl)

