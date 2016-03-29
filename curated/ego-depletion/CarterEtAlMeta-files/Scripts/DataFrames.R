#Load the necessary packages (make sure each is downloaded first)
library(pwr)
library(meta)
library(MAd)

##########################################################
#Each data frame can be compiled using the following and then
#saved. To do so, a path and file title will be needed for use
#with the save() function. 
#For example, if a file has been created in the documents
#folder called "Data", and the user's nameis "User'sName",
#and the file to be saved is titled "FC" (for food consumed), use:

#save(FC,file="C:/Users/User'sName/Documents/Data/FC.Rdata")

##########################################################

#FC
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14)
Author<-c("BaumeisterD","ChristiansenC","DingemansM",
          "FrieseH","FrieseH","HofmannR","ImhoffS",
          "MuravenC","OatenW","StillmanT","VohsH",
          "LattimoreM","VohsB","DewitteB") 
Exp<-as.character(c(2,"0a",0,2,3,0,1,0,1,3,3,0,5,"2a"))
Year<-as.character(c(2005,2012,2009,2008,2008,2007,2013,2002,2008,
        2009,"2000a",2004,2013,2009))
IV = c("SE", "EV", "EV", "EV", "EV", "EV", "S", "TS", "SE", "AV", "EV", "S", "AE", "FT")
PubType<-c(1,1,1,1,1,1,1,1,1,1,1,1,1,1)
Baum<-c(1,0,0,0,0,0,0,1,0,1,1,0,1,0)
M_IV <-c(0,0,0,0,0,0,0,0,0,0,0,0,0,0)
M_DV<-c(0,0,0,0,0,0,0,0,0,0,0,0,1,1)
Dep_n<-c(19,40,33,33,25,26,69,29,37,33,18,29,15,35) 
Con_n<-c(19,40,33,33,21,24,68,29,36,33,18,30,15,41) 
d<-c(0.9,0.67,-0.02,0.34,0.31,-0.12,0.7,0.43,2.69,0.1,
     0.75,-0.55,0.74,-0.55) 
d_v<-c(0.12,0.05,0.06,0.06,0.09,0.08,0.03,0.07,0.1,0.06,
       0.12,0.07,0.14,0.06) 
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se) #note, ci() is from the meta package
p=ci$p

FC=data.frame(ID,Author,Exp,Year,IV,
              M_IV,M_DV,PubType,Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#HG 
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13) 
Author<-c("BrayA","BrayA","EganH","Litvin","MartijnT",
          "MoldenD","MuravenT","MurtaghT","Neale-Lorello",
          "SeeleyG","SeeleyG","TylerB","TylerB") 
Exp<-c(0,0,2,0,1,2,1,1,1,1,2,2,3)
Year<-c(2008,2011,2012,2012,2002,2012,1998,2004,2009,2003,2003,2009,2009)
IV = c("S","S","CL","TS","EV","CL","EV","S","CL","TS","TS","CL","TS")
PubType<-c(1,1,1,1,1,1,1,1,0,1,1,1,1) 
Baum<-c(0,0,0,0,0,0,1,0,0,0,0,0,0) 
M_IV<-c(0,0,0,0,0,0,0,0,0,0,0,0,0) 
M_DV<-c(0,0,0,0,0,0,0,0,0,0,0,0,0) 
Dep_n<-c(26,33,21,54,17,11,40,42,30,37,28,30,20) 
Con_n<-c(23,28,20,108,16,11,20,27,29,36,27,30,20) 
d<-c(0.47,0.18,1.2,0.16,0.72,1.09,0.68,0.07,0.22,0.31,0.8,1.19,1.14) 
d_v<-c(0.08,0.07,0.12,0.03,0.13,0.21,0.08,0.06,0.07,0.06,0.08,0.08,0.12) 
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

HG=data.frame(ID,Author,Exp,Year,IV,
              M_IV,M_DV,Baum,PubType,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#IA 

ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21) 
Author<-c("DvorakS","EganH","Gohar","Gohar","MuravenT","Myers",
           "ScherschelM","ScherschelM","SegerstromN","Smith",
           "Smith","Wan","MuravenS","Ruci",
          "Barber","Barber",
          "Holmqvist","Holmqvist",
           "Holmqvist", "Barber","DarowskiH") 

IV = c("EV","TS","T","T","TS","AV","AE","T","FT","TS","TS","TS",
       "T","S","AE","AE","AV","WM/AV","WM/AV", "EV","M")


Baum<-c(0,0,0,0,1,0,0,0,0,1,1,0,1,0,0,0,0,0,0,0,0) 
Exp<-c(0,1,2,3,2,2,1,2,0,1,"p1",6,4,2,      
       2,3,1,2,3,1,2) 
Year<-c(2009,2012,2011,2011,1998,2010,2011,2011,2007,2002,2002,
        2007,2005,2003,       
        2011,2011,2008,2008,2008,2011,2011) 
PubType<-c(1,1,0,0,1,0,0,0,1,0,0,0,1,0,
           0,0,0,0,0,0,0) 
M_IV <-c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0)
M_DV<-c(0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0) 
Dep_n<-c(90,17,14,16,17,25,35,24,41,14,10,14,57,30,24,24,33,51,74,18,16) 
Con_n<-c(90,16,14,12,34,21,33,31,42,14,12,13,19,37,24,24,29,15,27,18,13)

d<-c(0.88,0.74,0.16,0.81,0.93,0,0.41,0.25,0.22,1.82,1.53,1.29,0.96,0.59,
     -.11,-.09,-.02,.1,-.13,.33,.55) 

d_v<-c(0.02,0.13,0.14,0.16,0.1,0.09,0.06,0.07,0.05,0.2,0.24,0.18,0.08,0.06,
       .08,.08,.05,.05,.03,.11,.11) 

d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

IA=data.frame(ID,Author,Exp,Year,IV,
              M_IV,M_DV,PubType,Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################
#IP 
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16) 
Author<-c("BaumeisterB","BaumeisterD","KlaphakeS","MuravenS",
          "SatoH","VohsH","WallaceB","Wan","Wan","Wan","Wan","Wan","Wan",
          "GeeraertC","GeeraertC","GeeraertY") 
Exp<-c(1,3,2.1,1,0,2,0,1,2,3,4,7,8,1,2,"1b") 
Year<-c(1998,2005,2011,2003,2010,"2000a",2002,2007,2007,2007,2007,2007,2007,2013,2013,2007) 
IV = c("FT","SE","AE","TS","CL","FT","S","CL","CL","CL","CL","CL","CL","TS/FT","FT","FT")
PubType<-c(1,1,0,1,1,1,1,0,0,0,0,0,0,0,0,1) 
Baum<-c(1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0) 
M_IV<-c(0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0) 
M_DV<-c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
Dep_n<-c(25,10,20,22,86,14,11,13,14,24,39,13,15,15,15,24) 
Con_n<-c(44,10,20,21,109,14,11,12,13,24,38,13,14,15,15,20) 
d<-c(1.32,1.3,-0.07,0.58,0.14,0.82,1.13,1.29,1.29,0.91,0.97,0.87,1.21,1.05,.66,.53) 
d_v<-c(0.05,0.24,0.08,0.1,0.02,0.15,0.21,0.19,0.18,0.09,0.12,0.17,0.16,.11,.11,.07)
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

IP=data.frame(ID,Author,Exp,Year,IV, 
              M_IV,M_DV,PubType,Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#PA 
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12) 
Author<-c("BaumeisterB","BoucherK","ClarksonH","MoldenD","MurtaghT","vanDellenM","UzielL",
          "DewitteB","ConverseD","ConverseD","Daman","MasicampoR") 
Exp<-c(3,2,1,1,2,2,3,2,1,2,3,5) 
Year<-c(1998,2012,2010,2012,2004,2012,2012,2009,2009,2009,2013,2011) 
IV = c("EV","TS","CL","CL","TS","AV","T","FT","WM","CL/S","CL","TS")
PubType<-c(1,1,1,1,1,1,1,1,1,1,0,1) 
Baum<-c(1,0,0,0,0,0,1,0,0,0,1,1) 
M_IV<-c(0,0,0,0,0,0,1,0,1,1,0,0) 
M_DV<-c(0,0,0,0,0,0,0,1,0,0,0,0) 
Dep_n<-c(15,11,16,43,26,56,20,38,38,20,54,27) 
Con_n<-c(15,11,16,42,50,22,23,38,37,20,53,27) 
d<-c(0.76,1.05,0.78,0.31,-0.08,0.19,0.6,0.36,-0.46,-0.72,-0.01,0.76) 
d_v<-c(0.14,0.21,0.13,0.048,0.06,0.06,0.1,0.05,0.05,0.11,0.04,0.08) 
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

PA=data.frame(ID,Author,Exp,Year,IV,M_IV,M_DV,PubType,
              Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#ST 
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13) 
Author<-c("KlaphakeS","KlaphakeS","KlaphakeS","KlaphakeS","KlaphakeS",
          "KlaphakeS","KlaphakeS","KlaphakeS","Schmeichel","Schmeichel",
          "ConverseD","ConverseD","PondD") 
Exp<-c("1.1a","1.1b","1.2a","1.2b","1.3a","1.3b","1.4a","1.4b",1,3,"3a","3b",3) 
Year<-c(2012,2012,2012,2012,2012,2012,2012,2012,2003,2003,2009,2009,2011) 
IV = c("AE","WM","AE","WM","AE","WM","AE","WM","AV","AV","CL","CL/S","AV")
PubType<-c(0,0,0,0,0,0,0,0,1,1,1,1,0) 
Baum<-c(1,1,1,1,1,1,1,1,1,1,0,0,1) 
M_IV <-c(0,0,0,0,0,0,0,0,0,0,0,1,0) 
M_DV<-c(0,0,0,0,0,0,0,0,0,1,0,0,0) 
Dep_n<-c(10,11,19,20,20,20,13,14,12,18,15,15,65) 
Con_n<-c(10,10,20,26,20,20,14,13,12,18,15,15,63) 
d<-c(-0.33,-0.15,0.45,0.04,0.44,0.02,0.43,0.54,1.34,0.67,0.56,-0.31,0.35) 
d_v<-c(0.13,0.13,0.07,0.06,0.07,0.07,0.10,0.11,0.14,0.08,0.11,0.10,0.03) 
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

ST=data.frame(ID,Author,Exp,Year,IV,M_IV,M_DV,PubType,
              Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#S 
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16) 
Author<-c("BoucherK","Cesario","DeWallB","GailliotB","InzlichtG",
          "Myers","PondD","XuH","HedgcockV","MuravenS","Davisson","Friese","Friese","Barber",
          "YostM","YostM") 
Exp<-c(1,0,3,7,0,1,1,0,1,4,1,2,3,1,1,1) 
Year<-c(2012,2011,"2008b","2007c",2007,2010,2011,2012,2012,2005,2009,2012,2012,2011,
        2009,2013) 
IV = c("CL","AV","SE","AV","EV","T","AV","EV","AV","T","CL","TS","EV","EV","AV","AV")
PubType<-c(1,0,1,1,1,0,0,1,1,1,0,0,0,0,0,0) 
Baum<-c(0,0,1,1,1,0,1,0,1,1,0,0,0,0,0,0) 
M_IV <-c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
M_DV<-c(0,0,0,0,0,0,0,0,1,1,0,0,0,1,0,0) 
Dep_n<-c(14,31,14,16,15,24,56,24,30,38,37,29,41,18,129,45) 
Con_n<-c(13,30,14,15,18,26,60,23,30,38,40,32,38,18,122,45) 
d<-c(0.71,0.25,1.1,0.64,0.66,-0.09,0.02,0.66,-0.04,0.7,.26,0.2,0.27,0.11,0.10,-0.14) 
d_v<-c(0.16,0.05,0.16,0.1,0.13,0.06,0.03,0.07,0.05,0.06,.04,0.07,0.05,0.08,.01,0.02) 
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

S=data.frame(ID,Author,Exp,Year,IV,M_IV,M_DV,PubType,
             Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#WM 
ID<-c(1,2,3,4,5,6,7,8,9,10,11,12,13) 
Author<-c("HealyH","HealyH","HealyH","HealyH",
          "Schmeichel","Schmeichel","Schmeichel",
          "Schmeichel","Schmeichel", 
          "KlaphakeS","CarterM","DarowskiH","DarowskiH")
Exp<-c(1,2,3,4,"1a","1b",3,2,4,2.2,"1a","p2","p3")
Year<-c(2011,2011,2011,2011,2007,2007,
        2005,2007,2007,2012,
        2013,2011,2011) 
IV = c("AV","AV","AV","AV","AV","AV","EV","AE","EV","TS","CL","AE","AE")
PubType<-c(1,1,1,1,1,1,0,1,1,0,1,0,0) 
Baum<-c(0,0,0,0,1,1,1,1,1,1,0,0,0) 
M_IV<-c(0,0,0,0,0,0,0,0,0,0,1,0,0) 
M_DV<-c(0,0,0,0,0,0,0,0,0,1,0,0,0) 
Dep_n<-c(19,25,19,27,41,31,22,32,32,21,71,14,23) 
Con_n<-c(19,25,18,22,38,31,22,29,33,21,71,14,44) 
d<-c(1.31,0.11,0.72,-0.13,
     0.45,0.5,0.63,0.52,0.54,0.16,-0.09,-0.23,-0.05) 
d_v<-c(0.13,0.08,0.12,0.08,
       0.04,0.06,0.08,0.05,0.06,0.09,0.03,0.14,0.07) 
d_se<-sqrt(d_v)
df<-(Dep_n+Con_n)-2
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_v
g_se<-sqrt(g_v)
powCalc=pwr.t2n.test(g, n1=Dep_n, n2=Con_n)
pow=powCalc$power
ci=ci(d, d_se)
p=ci$p

WM=data.frame(ID,Author,Exp,Year,IV,M_IV,M_DV,PubType,
              Baum,Dep_n,Con_n,d,d_v,d_se,g,g_v,g_se,pow,p)

##########################################################

#ALL

#For these analyses, effect szes derived from the same study but using different
#outcome variables have been aggregated (i.e., 
#MuravenS_2006_4, Barber_2011_1)

#aggregation (MuravenS = 1; Barber = 2)
#Note that MuravenS has different Dep_Ns for the different datasets. This 
#is because 19 more people were pooled in Dep for IA but not S.

id = c(1,1,2,2)
d = c(subset(IA$d,IA$Author=="MuravenS"), subset(S$d,S$Author=="MuravenS"),
      subset(IA$d,paste0(IA$Author,IA$Exp)=="Barber1"), subset(S$d,S$Author=="Barber"))
d_v = c(subset(IA$d_v,IA$Author=="MuravenS"), subset(S$d_v,S$Author=="MuravenS"),
        subset(IA$d_v,paste0(IA$Author,IA$Exp)=="Barber1"), subset(S$d_v,S$Author=="Barber"))
n.1 = c(subset(IA$Dep_n,IA$Author=="MuravenS"), subset(S$Dep_n,S$Author=="MuravenS"),
        subset(IA$Dep_n,paste0(IA$Author,IA$Exp)=="Barber1"), subset(S$Dep_n,S$Author=="Barber"))
n.2 = c(subset(IA$Con_n,IA$Author=="MuravenS"), subset(S$Con_n,S$Author=="MuravenS"),
        subset(IA$Con_n,paste0(IA$Author,IA$Exp)=="Barber1"), subset(S$Con_n,S$Author=="Barber"))
dat=data.frame(id,d,d_v,n.1,n.2)
agged = agg(id,d,d_v,n.1,n.2,cor = .5,data = dat)

d=agged$es
d_var=agged$var
d_se=sqrt(d_var)
n_1 = c(mean(c(dat$n.1[1],dat$n.1[2])),mean(c(dat$n.1[3],dat$n.1[4])))
n_2 = c(mean(c(dat$n.2[1],dat$n.2[2])),mean(c(dat$n.2[3],dat$n.2[4])))
df=c((mean(c(dat$n.1[1],dat$n.1[2]))+mean(c(dat$n.2[1],dat$n.2[2]))-2),
     (mean(c(dat$n.1[3],dat$n.1[4]))+mean(c(dat$n.2[3],dat$n.2[4]))-2))
j=1-(3/(4*df-1))
g<-j*d
g_v<-j^2*d_var
g_se<-sqrt(g_v)

powCalc=pwr.t2n.test(g, n1=n_1, n2=n_2)
aggPow=powCalc$power

ci=ci(d, d_se) 
aggP=ci$p

aggM_IV = c(0,0)
aggM_DV = c(1,1)
aggPubType = c(1,0)
aggBaum = c(1,0)

ag = data.frame(g,g_v,g_se,n_1,n_2,aggM_IV,aggM_DV,
                aggPubType,aggBaum,aggPow,aggP)

g_ALL = c(FC$g,
          HG$g,
          subset(IA$g,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
          IP$g,
          PA$g,
          subset(S$g,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
          ST$g,
          WM$g,
          ag$g)

g_v_ALL = c(FC$g_v,
            HG$g_v,
            subset(IA$g_v,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
            IP$g_v,
            PA$g_v,
            subset(S$g_v,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
            ST$g_v,
            WM$g_v,
            ag$g_v)

g_se_ALL = c(FC$g_se,
             HG$g_se,
             subset(IA$g_se,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
             IP$g_se,
             PA$g_se,
             subset(S$g_se,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
             ST$g_se,
             WM$g_se,
             ag$g_se)

Dep_n_ALL = c(FC$Dep_n,
              HG$Dep_n,
              subset(IA$Dep_n,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
              IP$Dep_n,
              PA$Dep_n,
              subset(S$Dep_n,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
              ST$Dep_n,
              WM$Dep_n,
              ag$n_1)

Con_n_ALL = c(FC$Con_n,
              HG$Con_n,
              subset(IA$Con_n,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
              IP$Con_n,
              PA$Con_n,
              subset(S$Con_n,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
              ST$Con_n,
              WM$Con_n,
              ag$n_2)

M_IV_ALL = c(FC$M_IV,
             HG$M_IV,
             subset(IA$M_IV,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
             IP$M_IV,
             PA$M_IV,
             subset(S$M_IV,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
             ST$M_IV,
             WM$M_IV,
             ag$aggM_IV)

M_DV_ALL = c(FC$M_DV,
             HG$M_DV,
             subset(IA$M_DV,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
             IP$M_DV,
             PA$M_DV,
             subset(S$M_DV,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
             ST$M_DV,
             WM$M_DV,
             ag$aggM_DV)

PubType_ALL = c(FC$PubType,
                HG$PubType,
                subset(IA$PubType,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
                IP$PubType,
                PA$PubType,
                subset(S$PubType,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
                ST$PubType,
                WM$PubType,
                ag$aggPubType)

Baum_ALL = c(FC$Baum,
             HG$Baum,
             subset(IA$Baum,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
             IP$Baum,
             PA$Baum,
             subset(S$Baum,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
             ST$Baum,
             WM$Baum,
             ag$aggBaum)

pow_ALL=c(FC$pow,
          HG$pow,
          subset(IA$pow,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
          IP$pow,
          PA$pow,
          subset(S$pow,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
          ST$pow,
          WM$pow,
          ag$aggPow)

p_ALL = c(FC$p,
          HG$p,
          subset(IA$p,paste0(IA$Author,IA$Exp)!="Barber1" & IA$Author!="MuravenS"),
          IP$p,
          PA$p,
          subset(S$p,paste0(S$Author,S$Exp)!="Barber1" & S$Author!="MuravenS"),
          ST$p,
          WM$p,
          ag$aggP)

ALL=data.frame(M_IV_ALL,M_DV_ALL,PubType_ALL,Baum_ALL,g_ALL,g_v_ALL,g_se_ALL,
               Dep_n_ALL, Con_n_ALL,pow_ALL,p_ALL)

