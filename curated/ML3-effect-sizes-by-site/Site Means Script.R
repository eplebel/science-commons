setwd("/Users/Charlie/Desktop")

ML3<-read.csv(file="ML3AllSitesandmTurk.csv",header=TRUE)
SiteMeans<-summarise(group_by(ML3,Site),ConMean=mean(Conscientiousness,na.rm=TRUE),
AgreeMean=mean(Agreeableness,na.rm=TRUE),
OpenMean=mean(Openness,na.rm=TRUE),
NeuroMean=mean(Neuroticism,na.rm=TRUE),
ExtraMean=mean(Extraversion,na.rm=TRUE)
)
SiteMeans

write.csv(SiteMeans,file="B5SiteMeans.csv",row.names=FALSE)

