library(metafor)
library(plotrix) #for ablineclip function
library(compute.es)

#effect size calculations
gaillotetal2007study7 <- fes(5.04,31,30)
d.gaillotetal2007study7 = gaillotetal2007study7$d
v.gaillotetal2007study7 = gaillotetal2007study7$var.d
cesario.corker2010 <- fes(.122,60,59)
d.cesario.corker2010 = cesario.corker2010$d
v.cesario.corker2010 = cesario.corker2010$var.d
wang.dvorak2010 <- fes(15.61, 31,30)
d.wang.dvorak2010 = wang.dvorak2010$d
v.wang.dvorak2010 = wang.dvorak2010$var.d
lange.eggert2014study1 <- fes(1.12, 35,35)
d.lange.eggert2014study1 = lange.eggert2014study1$d
v.lange.eggert2014study1 = lange.eggert2014study1$var.d  #update ES calc for these 4 studies

schmeicheletal2003study1 <- tes(3.87, 12, 12) #total # correct
d.schmeicheletal2003study1 = schmeicheletal2003study1$d
v.schmeicheletal2003study1 = schmeicheletal2003study1$var.d
d.pondetal2011study3 = .35 #from g=.35 from Carter et al.'s (2015) meta-analysis Table 1
v.pondetal2011study3 = .07 #from v=.07 from Carter et al.'s (2015) meta-analysis Table 1
schmeichel2007study1 <- mes(32.88, 34.68, 4.15, 5.5, 41, 38) #total target words (OSPAN only)
d.schmeichel2007study1 = schmeichel2007study1$d
v.schmeichel2007study1 = schmeichel2007study1$var.d
healyetal2011study1 <- mes(54.3, 69.8, 12.2, 11.4, 19,19) #% of target words
d.healyetal2011study1 = healyetal2011study1$d
v.healyetal2011study1 = healyetal2011study1$var.d
carter.mccullough.sucralose <- mes(39.8, 40.4, 6.8, 5.2, 45, 47)
carter.mccullough.unsweetened <- mes(41.54, 39.38, 6.6, 5.9, 26, 24)
#weighted average for d and v of sucralose and unsweetened control conditions
d.carter.mccullough2013 = (carter.mccullough.sucralose$d * carter.mccullough.sucralose$N.total + carter.mccullough.unsweetened$d * carter.mccullough.unsweetened$N.total)/ (carter.mccullough.sucralose$N.total + carter.mccullough.unsweetened$N.total)
v.carter.mccullough2013 = (carter.mccullough.sucralose$var.d * carter.mccullough.sucralose$N.total + carter.mccullough.unsweetened$var.d * carter.mccullough.unsweetened$N.total)/ (carter.mccullough.sucralose$N.total + carter.mccullough.unsweetened$N.total)
lurquinetal2016 <- tes(1.46, 100,100)
d.lurquinetal2016 = lurquinetal2016$d
v.lurquinetal2016 = lurquinetal2016$var.d
muravenetal1998study2 <- mes(563, 758, 240, 280, 17, 17)
d.muravenetal1998study2 = muravenetal1998study2$d
v.muravenetal1998study2 = muravenetal1998study2$var.d
murtagh.todd2004study2 <- mes(628.88, 633.68, 354.42, 302.82, 26,25)
d.murtagh.todd2004study2 = murtagh.todd2004study2$d
v.murtagh.todd2004study2 = murtagh.todd2004study2$var.d
sripadaetal2014 <- tes(2.38, 24,23)
d.sripadaetal2014 = sripadaetal2014$d
v.sripadaetal2014 = sripadaetal2014$var.d
#RRR4 ego depletion: 24 replication effect sizes (& var) as calculated from their own RRR-metaanalysisRTV_incl.R file

### to save as png file
png(filename="ego-depletion.png", res=95, width=1200, height=1200, type="cairo")

dat <- read.csv(file = "ego-depletion(sorted).csv", header = TRUE)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$d, dat$var, xlim=c(-6, 2), at=c(-2.5, -2, -1.5, -1.0, -.5, 0, .5, .75),
       cex=1, ylim=c(-1, 51), rows=c(46:45,43:42,37:36,34:33,31:29,27:3),
       ilab=dat$N, ilab.xpos=-3, slab=dat$study
       ,xlab="Effect size (d) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=2)
text(-6, 50, "Studies and Replications",    pos=4)
text( 2, 50, "Effect sizes (d) [95% CI]",  pos=2)
text(-3, 50, c("N"))
op <- par(cex=1.15, font=3)
text(-6, 47.5, "Prediction 1: Self-control relies on glucose",    pos=4)
text(-6, 38.5, "Prediction 2: Self-control impairs further self-control (ego depletion)",    pos=4)

### set par back to the original settings
par(op)
par(op, cex=1,font=3)

### fit random-effects model 
res <- rma(yi=dat$d, vi=dat$var, data=dat, measure="SMD", subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1, mlab=NA)
text(-5.7,-1,"Random-effects meta-analytic estimate of all replications:",pos=4)
### horizontal separation line
abline(h=0)

### fit random-effects model in subgroups
res.rep.pred1 <- rma(yi=dat$d, vi=dat$var, data=dat, measure="SMD", subset=(dat$study.info=="replication1"|dat$study.info=="replication2"))
res.rep.pred2 <- rma(yi=dat$d, vi=dat$var, data=dat, measure="SMD", subset=(dat$study.info=="replication3"|dat$study.info=="replication4"|dat$study.info=="replication5"|dat$study.info=="replication6"))

### add summary polygons for the three subgroups
addpoly(res.rep.pred1, row=40.5, cex=1, efac=.8, mlab=NA)
addpoly(res.rep.pred2, row=1.5, cex=1, mlab=NA)
text(-5.7, 40.5, "Meta-analytic estimate of Prediction 1 replications:",pos=4)
text(-5.7, 1.5, "Meta-analytic estimate of Prediction 2 replications:",pos=4)

#ablineclip(v=.25, y1=-2,y2=21, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
#op <- par(cex=.75, font=1)
#text(.25, .75, "Z&L's r_33% small telescope", col="blue", pos=4)

dev.off()


