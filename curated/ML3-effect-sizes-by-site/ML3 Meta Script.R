####Inter-Site Meta Analysis####

require(metafor)

###Power and Perspective Taking
setwd("C:/Users/Etienne/Desktop/ML3 Meta Analysis (Effect size by site)/ML3 Meta")
PPMeta<-read.csv(file="PowerPerspective.csv",header=TRUE)
head(PPMeta)
Model<-escalc(n1i=Nhigh,n2i=Nlow,m1i=Mhigh,m2i=Mlow,sd1i=SDHigh,sd2i=SDLow,data=PPMeta,measure="SMD")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)

###Warmth Perceptions
WPMeta<-read.csv(file="WarmthPerceptions.csv",header=TRUE)
head(WPMeta)
Model<-escalc(n1i=NAgentic,n2i=Ncommunal,m1i=MAgentic,m2i=MCommunal,sd1i=SDAgentic,sd2i=SDCommunal,data=WPMeta,measure="SMD")
Model<-escalc(ri=r,ni=N,data=WPMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)

###Weight Embodiment
WEMeta<-read.csv(file="WeightEmbodiment.csv",header=TRUE)
head(WEMeta)
Model<-escalc(n1i=NHeavy,n2i=NLight,m1i=MHeavy,m2i=MLight,sd1i=SDHeavy,sd2i=SDLight,data=WEMeta,measure="SMD")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)

###Availability Heuristic
AVMeta<-read.csv(file="Availability.csv",header=TRUE)
head(AVMeta)
Model<-escalc(ri=r,ni=N,data=AVMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$r)

###Metaphoric Restructuring
MRMeta<-read.csv(file="Metaphor.csv",header=TRUE)
head(MRMeta)
Model<-escalc(ri=r,ni=N,data=MRMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)

###Stroop
StroopMeta<-read.csv(file="Stroop.csv",header=TRUE)
head(StroopMeta)
Model<-escalc(ri=r,ni=N,data=StroopMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)

###Moral Credentials
MCMeta<-read.csv(file="Credentials.csv",header=TRUE)
head(MCMeta)
#Interaction
Model<-escalc(ri=rInter,ni=NT,data=MCMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
median(MCMeta$rInter)
sd(Model$yi)
sd(MCMeta$rInter)
plot(MCMeta$Site,MCMeta$rInter)

#Main Effect
MCMeta<-read.csv(file="Credentials.csv",header=TRUE)
head(MCMeta)
Model<-escalc(ri=rMain,ni=NT,data=MCMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
median(MCMeta$rMain)^2
sd(Model$yi)
sd(MCMeta$rMain)
plot(MCMeta$Site,MCMeta$rMain)

###Self-Esteem and Subjective Distance
SDMeta<-read.csv(file="SubjectiveDistance.csv",header=TRUE)
head(SDMeta)
#Interaction
Model<-escalc(ri=rInter,ni=NT,data=SDMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
median(SDMeta$rInter)^2
sd(SDMeta$rInter)
plot(SDMeta$Site,SDMeta$rInter)

#Main Effect
SDMeta<-read.csv(file="SubjectiveDistance.csv",header=TRUE)
head(SDMeta)
Model<-escalc(ri=rMain,ni=NT,data=SDMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
median(SDMeta$rMain)^2
sd(Model$yi)
sd(SDMeta$rMain)

###Elaboration Likelihood
ELMMeta<-read.csv(file="ELM.csv",header=TRUE)
head(ELMMeta)
#Interaction
Model<-escalc(ri=rInter,ni=NT,data= ELMMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
median(ELMMeta$rInter)^2
sd(ELMMeta$rInter)
plot(ELMMeta$Site,ELMMeta$rInter)

#Main Effect
ELMMeta <-read.csv(file="ELM.csv",header=TRUE)
head(ELMMeta)
Model<-escalc(ri=rMain,ni=NT,data= ELMMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)
sd(ELMMeta$rMain)


###Conscientiousness and Persistence
CPMeta<-read.csv(file="ConscientiousnessPersistence.csv",header=TRUE)
head(CPMeta)
#Interaction
Model<-escalc(ri=r,ni=N,data= CPMeta,measure="COR",vtype="UB")
Model
Model2<-rma.uni(yi,vi,data=Model)
summary(Model2)
sd(Model$yi)
sd(CPMeta$r)


####PLOTS####
plot(MCMeta$Site,MCMeta$rInter,ylim=c(-.35,.35))
plot(SDMeta$Site,SDMeta$rInter,ylim=c(-.35,.35))
plot(ELMMeta$Site,ELMMeta$rInter,ylim=c(-.35,.35))

plot(MCMeta$Site,MCMeta$rMain,ylim=c(-.5,.5))
plot(SDMeta$Site,SDMeta$rMain,ylim=c(-.5,.5))
plot(ELMMeta$Site,ELMMeta$rMain,ylim=c(-.5,.5))


plot(CPMeta$Site,CPMeta$r,ylim=c(-.35,.35))
