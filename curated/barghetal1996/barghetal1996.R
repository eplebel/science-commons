library(metafor)

### to save as png file
png(filename="barghetal1996.png", res=95, width=1000, height=500, type="cairo")

#from t(28)=2.86, d = 1.04
barghetal2a.sd = (sqrt(15) * (.98/2.86)) / sqrt(2)
#from t(28)=2.16, d = .79
barghetal2b.sd = (sqrt(15) * (.97/2.16)) / sqrt(2)
#from  F(1, 27) = 2.47, p = .13
hulletal1a.sd = (sqrt(15) * (.95/sqrt(2.47))) / sqrt(2)
#from F(1, 36) = 2.95, p = .09
hulletal1b.sd = (sqrt(20) * (1.00/sqrt(2.95))) / sqrt(2)

dat <- read.csv(file = "barghetal1996-replications.csv", header = TRUE)

dat <- escalc(measure="SMD", m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
              n2i=dat$n2i, data=dat, slab=dat$study)
dat
fe.all <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
           n2i=dat$n2i, data=dat, measure="SMD", slab=dat$study)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-5, 4), at=c(-.75, -.50, 0, .50, 1.0, 1.5, 2.0),
       cex=1.25, ylim=c(-1, 10), rows=c(7:1),
       addfit=FALSE, atransf=FALSE,
       ilab=dat$N, ilab.xpos=-1.5,
       xlab="Effect size (d) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-5, 9, "Studies and Replications",    pos=4)
text(-1.5, 9, c("N"))
text( 4, 9, "Effect sizes (d) [95% CI]",  pos=2)


### set par back to the original settings
par(op, cex=1, font=3)

### fit random-effects model (use slab argument to define study labels)
res <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
           n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1.25, mlab="Random-effects meta-analytic estimate of replications")
### horizontal separation line
abline(h=-.5)

### fit random-effects model in the three subgroups
#res.rep1 <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
#                n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.info=="replication1"))

### add summary polygons for the three subgroups
#addpoly(res.rep1, row=5, cex=1.25, mlab="Meta-analytic estimate of replications of SMB's Study 1")

library(pwr)
#Create function to get d that gives 33% power
get.d33=function(n,power) pwr.t.test(n=n,power=power)$d
d33 <- get.d33(n=30,power=.33) #make it negative because cleanliness priming effect is negative
library(plotrix)
ablineclip(v=d33, y1=-2,y2=8, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
op <- par(cex=.75, font=1)
text(.4, .15, "Bargh et al.'s d_33% small telescope", col="blue", pos=4)
#my alternative interpretation to d_33%=.40, is d_95% replications *could* have detected = .29
d95_reps = pwr.t.test(n=302,power=.95)$d

dev.off()



