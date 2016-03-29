
#The following was used to aggregate multiple effect sizes 
#coming from the same outcome task (e.g., reaction time and accuracy).
#This was done with d and d_v. The aggregated values were 
#then used in the dataframes script. 


#Load the necessary packages (make sure each is downloaded first)
library(MAd)

##################################

#IA 
#3, 4, and 5 are by Holmqvist 2008. 6 is Darowski 2010.

id<-c(3,3,4,4,5,5,6,6)
d<-c(-.21,.17,-.1,.3,-.11,-.15,1.11, -.02)
d_v<-c(.07,.07,.09,.09,.05,.05,.16,.14)
n.1<-c(33,33,51,51,74,74,16,16)
n.2<-c(29,29,15,15,27,27,13,13) 
IA_agg<-data.frame(id, d, d_v, n.1, n.2)
IA_agged=agg(id,d,d_v,n.1,n.2, cor = .5, 
             data=IA_agg)

##################################

#IP
#Baumeister 1998 exp 1 (id 1), Geeraert 2013 exp 1 (id 2), 
#Geeraert 2013 exp 2 (id 3), Geeraert 2007 exp 1b (id 4)

id<-c(1,1,2,2,3,3,4,4)
d<-c(1.83, .98,.92, 1.2,.31, 1.12,.57, .5)
d_var<-c(.09,.07,.15,.16,.13,.15,.1,.09)
n.1<-c(25, 25, 15, 15,15,15, 24, 24)
n.2<-c(44,42,15,15,15, 15,20, 20) 
IP_agg<-data.frame(id, d, d_var, n.1, n.2)
IP_agged=agg(id,d,d_var,n.1,n.2, cor = .5, data=IP_agg)

##################################

#S

#YostM_2009_1 and YostM_2013_1. 
#Different from others because corr between RT 
#interference and acc was available.
c_id<-c(1, 1) 
c_d<-c(.2, -.01)
c_d_var<-c(.02, .02)
c_n.1<-c(129, 129) 
c_n.2<-c(122, 122) 
c_agg<-data.frame(c_id, c_d, c_d_var, c_n.1, c_n.2)
agg(c_id,c_d,c_d_var,c_n.1,c_n.2, cor = .01, data=c_agg)

c_id<-c(2, 2)
c_d<-c(-.09, -.19)
c_d_var<-c(.04, .04)
c_n.1<-c(45, 45)
c_n.2<-c(45, 45)
c_agg<-data.frame(c_id, c_d, c_d_var, c_n.1, c_n.2)
agg(c_id,c_d,c_d_var,c_n.1,c_n.2, cor = 0, data=c_agg)
#Correlation actually -.18, but the function won't take negative values. Rather
#than make some assumption and change the sign of one effect and then the sign
#of the correlation, just changed it to 0. 

#Cessario 2011 AND GailliotB 2007c (assumes cesario estimate of .44 correlation between
#Stroop RT and ACC is good)
c_id<-c(2, 2, 4, 4)
c_d<-c(.1, .41, .48, .81)
c_d_var<-c(.07, .07, .13, .14)
c_n.1<-c(31, 31, 16, 16)
c_n.2<-c(30, 30, 15, 15) 
c_agg<-data.frame(c_id, c_d, c_d_var, c_n.1, c_n.2)
c_agged=agg(c_id,c_d,c_d_var,c_n.1,c_n.2, cor = .44, data=c_agg)

#Davisson 2009 = 1
#Myers 2010 = 2; XuH 2012 = 3; HedgecockV 2012 = 4,
#Barber 2011 = 5
id<-c(1,1,2, 2,3, 3,4, 4,5, 5)
d<-c(.04,.49,-.05, -.14,.71, .62,.5, -.59,.01, .02)
d_v<-c(.05,.05,.08, .08,.09, .09,.07, .07,.11, .11)
n.1<-c(37,37,24, 24,24, 24,30, 30,18, 18)
n.2<-c(40,40,26, 26,23, 23,30, 30,18, 18) 
S_agg<-data.frame(id, d, d_v, n.1, n.2)
S_agged=agg(id,d,d_v,n.1,n.2, cor = .5, data=S_agg)


##################################
#ST
#KlaphakeS_2012_1.1a to 1.4b, Schmeichel_2003_1 and 3
id<-c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8,10,10,10,11,11,11)
Dep_n<-c(10,10,10,11,11,10,19,19,20,19,20,20,20,20,20,20,19,20,13,13,14,14,14,14,12,12,12,18,18,18)
Con_n<-c(10,11,11,10,10,9,19,20,20,38,20,20,20,20,20,20,20,20,14,14,14,13,13,13,12,12,12,18,18,18)
d<-c(-0.46,-0.26,-0.27,-0.14,-0.18,-0.14,0.52,0.83,-0.01,-0.36,0.27,0.22,0.54,0.4,0.37,0.24,-0.52,0.34,0.58,0.53,0.17,0.68,1.05,-0.12,1.62,1.42,0.97,0.9,-0.3,1.41)
d_v<-c(0.21,0.19,0.19,0.19,0.19,0.21,0.11,0.11,0.1,0.08,0.1,0.1,0.1,0.1,0.1,0.1,0.11,0.1,0.15,0.15,0.14,0.16,0.17,0.15,0.22,0.21,0.19,0.12,0.11,0.14)

ST1_agg<-data.frame(id, d, d_v, Dep_n, Con_n)

agg(id,d,d_v,Dep_n, Con_n, cor = .5, data=ST1_agg)

#ConverseD_2009 3a and 3b
id<-c(14,14,15,15)
Dep_n<-c(15,15,15,15)
Con_n<-c(15,15,15,15)
d<-c(0.48,0.63,-0.18,-0.43)
d_v<-c(0.14,0.14,0.13,0.14)

ST2_agg<-data.frame(id, d, d_v, Dep_n, Con_n)

agg(id,d,d_v,Dep_n, Con_n, cor = .5, data=ST2_agg)


##################################

#WM

#Based the CarterM_2013_1 data, the average correlation between longest set, 
#number of sets, number of words in full sets, and total words was .85
#Schmeichel_2007_1a and 1b, schmeichel_2005_3, Schmeichel_2007_4
id<-c(5,5,5,5,6,6,6,6,7,7,7,7,9,9,9,9)
d<-c(.37, .55, .51, .37, .52, .48, .48, .53, .77, .57, .52, .64, .51, .79, .78, .07)
d_var<-c(.05, .05, .05, .05, .07, .07, .07, .07, .1, .09, .09, .1, .06, .07, .07, .06)
n.1<-c(41, 41, 41, 41, 31, 31, 31, 31, 22, 22, 22, 22, 33, 33, 32, 33)
n.2<-c(38, 38, 38, 38, 31, 31, 31, 31, 22, 22, 22, 22, 33, 33, 32, 33) 
WM1_agg<-data.frame(id, d, d_var, n.1, n.2)
agg(id,d,d_var,n.1,n.2, cor = .85, data=WM1_agg)

#Schmeichel_2007_2, cor = .5 as default
id<-c(8, 8)
d<-c(.2, .83)
d_var<-c(.07, .07)
n.1<-c(32, 32)
n.2<-c(29, 29) 
WM2_agg<-data.frame(id, d, d_var, n.1, n.2)
agg(id,d,d_var,n.1,n.2, cor = .5, data=WM2_agg)

#KlaphakeS, cor = .81 based on the CarterM_2013_1 data
id<-c(11, 11, 11)
d<-c(0, .22, .26)
d_var<-c(.1, .1, .1)
n.1<-c(21, 21, 21)
n.2<-c(21, 21, 21) 
WM3_agg<-data.frame(id, d, d_var, n.1, n.2)
agg(id,d,d_var,n.1,n.2, cor = .81, data=WM3_agg)





