library(metafor)
library(plotrix) #for ablineclip function

### to save as png file
#png(filename="z&l.png", res=95, width=1200, height=800, type="cairo")

require(compute.es)
#target effect is positively coded: unethical act causes greater desire for cleaning compared to ethical act/control

#Zhong & Liljenquist (2006) Study 2
fes(6.99,14,13)
#Gamez et al. (2011) Study 2
fes(.05,18,18)
#Earp et al. (2014) Study 1
tes(.03, 76,77 )
#Earp et al. (2014) Study 2
tes(-.79, 74,74 )
#Earp et al. (2014) Study 3
tes(-1.83, 131, 131)
#Siev (2012) Study 1
tes(-.7338, 165,170) #average of 5 t-values for 5 different products
#Siev (2012) Study 2
tes(-.93, 60,48)

#Zhong & Liljenquist (2006) Study 3
chies(4.57, 32)
#Gamez et al. (2011) Study 3
chies(.99, 45)
#Fayard et al. (2009) Study 1
chies(.23, 210)

#Zhong & Liljenquist (2006) Study 4
chies(5.02, 45)
#Gamez et al. (2011) Study 4
chies(1.04, 28)
#Fayard et al. (2009) Study 2
fes(.01,58,57) #continuous measure of volunteer behavior (in mins) instead of dichotomous yes/no
#Reuven et al. (2013)
tes(2.19, 15,14) #non-OCD control Ps only; yields d=.81 whereas d=.54 reported ??? (perhaps incorrect t-value)




dat <- read.csv(file = "https://raw.githubusercontent.com/eplebel/science-commons/master/curated/z%26l/z%26l-replications.csv", header = TRUE)
dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
dat

### decrease margins so the full space is used
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$yi, dat$vi, xlim=c(-2.5, 2), at=c(-.5, -.25, 0, .25, .5, .75, 1),
       cex=1.25, ylim=c(-1, 23), rows=c(20:14,11:9,6:3),
       ilab=dat$N, ilab.xpos=-.75
       ,xlab="Effect size (r) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-2.5, 22, "Studies and Replications",    pos=4)
text( 2, 22, "Effect sizes (r) [95% CI]",  pos=2)
text(-.75, 22, c("N"))

### set par back to the original settings
par(op)

### fit fixed-effects model (use slab argument to define study labels)
res <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.type=="replication"),
           slab=dat$study, method="FE")
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1.25, mlab="Fixed-effect meta-analytic estimate (replications only)")
### horizontal separation line
abline(h=0)

### fit fixed-effects model in the three subgroups
res.rep1 <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.info=="replication1"),
                method="FE")
res.rep2 <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.info=="replication2"),
                method="FE")
res.rep3 <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.info=="replication3"),
                method="FE")

### add summary polygons for the three subgroups
addpoly(res.rep1, row=13, cex=1.25, mlab="Meta-analytic estimate of Study 2 replications")
addpoly(res.rep2, row= 8, cex=1.25, mlab="Meta-analytic estimate of Study 3 replications")
addpoly(res.rep3, row= 2, cex=1.25, mlab="Meta-analytic estimate of Study 4 replications")

ablineclip(v=.25, y1=-2,y2=21, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
op <- par(cex=.75, font=1)
text(.25, .75, "Z&L's r_33% small telescope", col="blue", pos=4)

#dev.off()


