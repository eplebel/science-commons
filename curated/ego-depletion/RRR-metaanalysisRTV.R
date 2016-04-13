#AnalysisDir <- 'c:/meta'
### Set Working Directory
#setwd(AnalysisDir)

#import the metafor meta-nalysis R library. You will need to install it first.
require("metafor")

# Import the data
RTVdat<- read.csv("RRR-RTV.csv")
#RTVdat<- RTVdat[order(RTVdat$study),]
### random-effects model meta-analysis 
# modeled after http://www.metafor-project.org/doku.php/tips:assembling_data_smd
effectSizesAll<- escalc(measure="SMD", #standardized mean difference
                     m1i= Ego.Depletion.Mean, m2i= Control.Mean,
                     sd1i=Ego.Depletion.Std.Dev, sd2i= Control.Std.Dev,
                     n1i=Ego.Depletion.Sample.size, n2i=Control.Sample.size,
                     data= RTVdat)
#(RTVdat$Ego.Depletion.Mean - RTVdat$Control.Mean) / RTVdat$Ego.Depletion.Std.Dev

write.csv(effectSizesAll, file="RRR4-effect-sizes.csv")
#then i sorted in Excel, reversed signs, & copy-pasted into ego-depletion.csv file; i know, BAD FORM!!!

res <- rma(data=effectSizesAll, yi,vi,  method="REML", slab=paste(Study.name))

#res <- rma(measure="RD", method="REML")

#For a standard random-effects model, we need to add random effects for the trials, which can be done with:
#  rma.mv(yi, vi, random = ~ 1 | trial, data=dat)

###############################################################
### FOREST PLOT WITH META-ANALYSIS ACROSS REPLICATION STUDIES
###############################################################

### Create the forest plot. 
### Rows specify the rows in which the subsets of studies appear.
### addfit=false eliminates the meta-analytic result for now. We'll first not calculate that
### so we can create a forest plot that includes all the studies, even the original, and
### then we'll calculate the meta-analysis based just on the RRR studies.

### decrease margins so the full space is used and set the font size for the forest plot
par(mar=c(4,4,1,2))
par(cex=.8, font=1)

#Create a forest plot that includes the original study
forest(res,
       ilab=cbind(RTVdat$Ego.Depletion.Mean, RTVdat$Control.Mean),
       addfit=FALSE, #Don't include polygon because that would include original
       ilab.xpos=c(-1.5,-1.2), #ylim=c(-1, 47) 
       #xlim=c(-10,7)
       #xlim=c(-12,5)
       #xlim=c(-12,8)
#      xlim=c(-5,2.5)
      xlim=c(-3.5,2.5), psize=1, 

)
par("usr") #reveals xlims? http://r.789695.n4.nabble.com/tweaking-forest-plot-metafor-package-td4636818.html

### Create a subset of the data that excludes Sripada et al. and renumber it
RRRdat <- subset(RTVdat,Study != 0)
rownames(repdata) <- NULL

# modeled after http://www.metafor-project.org/doku.php/tips:assembling_data_smd
effectSizesRRR<- escalc(measure="SMD", #standardized mean difference
                        m1i= Ego.Depletion.Mean, m2i= Control.Mean,
                        sd1i=Ego.Depletion.Std.Dev, sd2i= Control.Std.Dev,
                        n1i=Ego.Depletion.Sample.size, n2i=Control.Sample.size,
                        data= RRRdat)
### run a meta-analysis on just the RRR studies
res <- rma(data=effectSizesRRR, yi,vi,  method="REML", slab=paste(Study.name))

### add a polygon to the Forest plot showing the meta-analytic effect of the replication studies
addpoly(res, atransf=FALSE, row=0, cex=1.0, mlab="Meta-analytic effect for replications only")


abline(h=0.45)
