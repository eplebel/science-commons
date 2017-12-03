####ML3 by-site ES +/- CIs calculations and formatting code (EPL Nov 2017)###
####(Adapted from ML3 Inter-Site Meta Analysis script####

require(metafor)
require(compute.es)

###Stroop
StroopMeta<-read.csv(file="Stroop.csv",header=TRUE)
head(StroopMeta)
attach(StroopMeta)
Model<-escalc(ri=r,ni=N,data=StroopMeta,measure="UCOR",vtype="UB")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#sd(Model$yi)
dat <- escalc(measure="COR", ri=r, ni=N)
Model.CIs<-res(r=r, n=N, var.r=dat$vi)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(StroopMeta)

###Metaphoric Restructuring
MRMeta<-read.csv(file="Metaphor.csv",header=TRUE)
head(MRMeta)
attach(MRMeta)
Model<-escalc(ri=r,ni=N,data=MRMeta,measure="UCOR",vtype="UB")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#sd(Model$yi)
dat <- escalc(measure="COR", ri=r, ni=N)
Model.CIs<-res(r=r, n=N, var.r=dat$vi)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(MRMeta)

###Availability Heuristic
AVMeta<-read.csv(file="Availability.csv",header=TRUE)
head(AVMeta)
attach(AVMeta)
Model<-escalc(ri=r,ni=N,data=AVMeta,measure="UCOR",vtype="UB")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#sd(Model$r)
dat <- escalc(measure="COR", ri=r, ni=N)
Model.CIs<-res(r=r, n=N, var.r=dat$vi)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(AVMeta)

###Power and Perspective Taking
#setwd("C:/Users/Etienne/Desktop/ML3 Meta Analysis (Effect size by site)/ML3 Meta")
PPMeta<-read.csv(file="PowerPerspective.csv",header=TRUE)
head(PPMeta)
attach(PPMeta)
Model<-escalc(n1i=Nhigh,n2i=Nlow,m1i=Mhigh,m2i=Mlow,sd1i=SDHigh,sd2i=SDLow,data=PPMeta,measure="SMD")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#sd(Model$yi)
#modified to extract site-specific ES CIs!
Model.CIs<-mes(n.1=Nhigh,n.2=Nlow,m.1=Mhigh,m.2=Mlow,sd.1=SDHigh,sd.2=SDLow)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(PPMeta)

###Weight Embodiment
WEMeta<-read.csv(file="WeightEmbodiment.csv",header=TRUE)
head(WEMeta)
attach(WEMeta)
Model<-escalc(n1i=NHeavy,n2i=NLight,m1i=MHeavy,m2i=MLight,sd1i=SDHeavy,sd2i=SDLight,data=WEMeta,measure="SMD")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)
#modified to extract site-specific ES CIs!
Model.CIs<-mes(n.1=NHeavy,n.2=NLight,m.1=MHeavy,m.2=MLight,sd.1=SDHeavy,sd.2=SDLight)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(WEMeta)

###Warmth Perceptions
WPMeta<-read.csv(file="WarmthPerceptions.csv",header=TRUE)
head(WPMeta)
attach(WPMeta)
Model<-escalc(n1i=NAgentic,n2i=Ncommunal,m1i=MAgentic,m2i=MCommunal,sd1i=SDAgentic,sd2i=SDCommunal,data=WPMeta,measure="SMD")
#Model<-escalc(ri=r,ni=N,data=WPMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)
#modified to extract site-specific ES CIs!
Model.CIs<-mes(n.1=NAgentic,n.2=Ncommunal,m.1=MAgentic,m.2=MCommunal,sd.1=SDAgentic,sd.2=SDCommunal)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(WPMeta)


###Elaboration Likelihood
ELMMeta<-read.csv(file="ELM.csv",header=TRUE)
attach(ELMMeta)
head(ELMMeta)
#Interaction
Model<-escalc(ri=rInter,ni=NT,data= ELMMeta,measure="UCOR",vtype="UB")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#median(ELMMeta$rInter)^2
#sd(ELMMeta$rInter)
#plot(ELMMeta$Site,ELMMeta$rInter)
dat <- escalc(measure="COR", ri=rInter, ni=NT)
Model.CIs<-res(r=rInter, n=NT, var.r=dat$vi)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(ELMMeta)
#compute d effect size w/ CI of ORIGINAL ES so it's comparable (previously had eta-squared)
#converted from eta-squared to r using formula from Cohen (1988) via Converting-eta-squared-to-d-(used only for original ES calculations).xls
res(r=0.4123,n=114) #d(N=114) = .91 +/- .40 #convert from r to d

###Self-Esteem and Subjective Distance
SDMeta<-read.csv(file="SubjectiveDistance.csv",header=TRUE)
attach(SDMeta)
head(SDMeta)
#Interaction
Model<-escalc(ri=rInter,ni=NT,data=SDMeta,measure="UCOR",vtype="UB")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#median(SDMeta$rInter)^2
#sd(SDMeta$rInter)
#plot(SDMeta$Site,SDMeta$rInter)
dat <- escalc(measure="COR", ri=rInter, ni=NT)
Model.CIs<-res(r=rInter, n=NT, var.r=dat$vi)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(SDMeta)

###Moral Credentials
MCMeta<-read.csv(file="Credentials.csv",header=TRUE)
attach(MCMeta)
head(MCMeta)
#Interaction
Model<-escalc(ri=rInter,ni=NT,data=MCMeta,measure="UCOR",vtype="UB")
Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#median(MCMeta$rInter)
#sd(Model$yi)
#sd(MCMeta$rInter)
#plot(MCMeta$Site,MCMeta$rInter)
dat <- escalc(measure="COR", ri=rInter, ni=NT)
Model.CIs<-res(r=rInter, n=NT, var.r=dat$vi)
Model.CIs
CIs<-round(((Model.CIs$u.d-Model.CIs$l.d)/2),digits=2)
#concatenate and remove leading & trailing white spaces;
ES.CIs<-paste("d(N=",Model.CIs$N.total,") = ",sub('^(-)?0[.]', '\\1.', Model.CIs$d)," \u00B1 ",sub('^(-)?0[.]', '\\1.', CIs),sep="")
cat(iconv(ES.CIs, to="UTF-8"), file="_ES.with.CIs.csv",append=TRUE,sep="\n")
detach(MCMeta)
#compute d effect size w/ CI of ORIGINAL ES so it's comparable (previously had eta-squared)
#converted from eta-squared to r using formula from Cohen (1988) via Converting-eta-squared-to-d-(used only for original ES calculations).xls
res(r=.21,n=198) #d(N=198) = .43 +/- .29 #convert from r to d




##NOT USED
#Main Effect
#MCMeta<-read.csv(file="Credentials.csv",header=TRUE)
#head(MCMeta)
#Model<-escalc(ri=rMain,ni=NT,data=MCMeta,measure="COR",vtype="UB")
#Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#median(MCMeta$rMain)^2
#sd(Model$yi)
#sd(MCMeta$rMain)
#plot(MCMeta$Site,MCMeta$rMain)

#Main Effect
#SDMeta<-read.csv(file="SubjectiveDistance.csv",header=TRUE)
#head(SDMeta)
#Model<-escalc(ri=rMain,ni=NT,data=SDMeta,measure="COR",vtype="UB")
#Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#median(SDMeta$rMain)^2
#sd(Model$yi)
#sd(SDMeta$rMain)


#Main Effect
#ELMMeta <-read.csv(file="ELM.csv",header=TRUE)
#head(ELMMeta)
#Model<-escalc(ri=rMain,ni=NT,data= ELMMeta,measure="COR",vtype="UB")
#Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#sd(Model$yi)
#sd(ELMMeta$rMain)


###Conscientiousness and Persistence
#CPMeta<-read.csv(file="ConscientiousnessPersistence.csv",header=TRUE)
#head(CPMeta)
#Interaction
#Model<-escalc(ri=r,ni=N,data= CPMeta,measure="COR",vtype="UB")
#Model
#Model2<-rma.uni(yi,vi,data=Model)
#summary(Model2)
#sd(Model$yi)
#sd(CPMeta$r)


####PLOTS####
#plot(MCMeta$Site,MCMeta$rInter,ylim=c(-.35,.35))
#plot(SDMeta$Site,SDMeta$rInter,ylim=c(-.35,.35))
#plot(ELMMeta$Site,ELMMeta$rInter,ylim=c(-.35,.35))

#plot(MCMeta$Site,MCMeta$rMain,ylim=c(-.5,.5))
#plot(SDMeta$Site,SDMeta$rMain,ylim=c(-.5,.5))
#plot(ELMMeta$Site,ELMMeta$rMain,ylim=c(-.5,.5))


#plot(CPMeta$Site,CPMeta$r,ylim=c(-.35,.35))
