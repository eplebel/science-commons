
#Load the Reliability data frame using the load() function. 
#For example, enter the following where the path preceeding 
#the .RData file corresponds to where the
#data frame files have been saved. 

#load("C:/Users/User'sName/Documents/Data/HG.Rdata")

#Note the direction of the slashes.

#Load necessary package
library(irr)

####################################################################

#Create dataframes 

#PubType, categorical
PubDL=data.frame(Reliability$PubType_D, Reliability$PubType_L)
PubDE=data.frame(Reliability$PubType_D, Reliability$PubType_E)
#Baumeister Affiliates, categorical
BaumDL=data.frame(Reliability$Baum_D, Reliability$Baum_L)
BaumDE=data.frame(Reliability$Baum_D, Reliability$Baum_E)
#IV COde, categorical
IVcode=data.frame(Reliability$IV_Code_D, Reliability$IV_Code_L)
#IV Number, continuous
IVnum=data.frame(Reliability$IV_Number_D, Reliability$IV_Number_L)
#DV Code, categorical
DVcode=data.frame(Reliability$DV_Code_D, Reliability$DV_Code_L)
#DV Number, continuous
DVnum=data.frame(Reliability$DV_Number_D, Reliability$DV_Number_L)
#Depletion n, continuous
Dep_n_DL=data.frame(Reliability$Dep_n_D, Reliability$Dep_n_L)
Dep_n_DE=data.frame(Reliability$Dep_n_D, Reliability$Dep_n_E)
#Control n, continuous
Con_n_DL=data.frame(Reliability$Con_n_D, Reliability$Con_n_L)
Con_n_DE=data.frame(Reliability$Con_n_D, Reliability$Con_n_E)
#Cohen's d, continuous
ES_DL=data.frame(Reliability$ES_D, Reliability$ES_L)
ES_DE=data.frame(Reliability$ES_D, Reliability$ES_E)
#Variance of Cohen's d, continuous
VarDL=data.frame(Reliability$Var_D, Reliability$Var_L)
VarDE=data.frame(Reliability$Var_D, Reliability$Var_E)

#Calculate reliabilities
#DE corresponds to raters 3 and 1
#DL corresponds to raters 3 and 2

#Kappa PubType
kappa2(PubDL)
kappa2(PubDE)

#Kappa Source Lab (Baumeister)
kappa2(BaumDL)
kappa2(BaumDE)

#Kappa IV code
kappa2(IVcode)
#ICC IV number
icc(IVnum)

#Kappa DV code
kappa2(DVcode)
#ICC DV number
icc(DVnum)

#ICC Depletion n
icc(Dep_n_DL)
icc(Dep_n_DE)

#ICC Control n
icc(Con_n_DL)
icc(Con_n_DE)

#ICC Cohen's d
icc(ES_DL)
icc(ES_DE)

#ICC variance
icc(VarDL)
icc(VarDE)