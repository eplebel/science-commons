library(metafor)
setwd(getwd())

### to save as png file
#png(filename="schnalletal2008a.png", res=95, width=1200, height=800, type="cairo")

dat <- read.csv(file = "schnalletal-replications.csv", header = TRUE)

dat <- escalc(measure="SMD", m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
              n2i=dat$n2i, data=dat, slab=dat$study)
dat
fe.all <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
           n2i=dat$n2i, data=dat, measure="SMD", slab=dat$study)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-5, 2), at=c(-1.5, -1.0, -.50, 0, .50),
       cex=1.25, ylim=c(-1, 14), rows=c(11:6,3:2),
       addfit=FALSE, atransf=FALSE,
       ilab=dat$N, ilab.xpos=-2,
       xlab="Effect size (d) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-5, 13, "Studies and Replications",    pos=4)
text(-2, 13, c("N"))
text( 2, 13, "Effect sizes (d) [95% CI]",  pos=2)


### set par back to the original settings
par(op)

### fit random-effects model (use slab argument to define study labels)
res <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
           n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1.25, mlab="Random-effects meta-analytic estimate (replications only)")
### horizontal separation line
abline(h=0)

### fit random-effects model in the three subgroups
res.rep1 <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
                n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.info=="replication1"))

### add summary polygons for the three subgroups
addpoly(res.rep1, row=5, cex=1.25, mlab="Meta-analytic estimate of replications of SMB's Study 1")

library(pwr)
#Create function to get d that gives 33% power
get.d33=function(n,power) pwr.t.test(n=n,power=power)$d
d33 <- -get.d33(n=22,power=.33) #make it negative because cleanliness priming effect is negative
library(plotrix)
ablineclip(v=d33, y1=-2,y2=12, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
op <- par(cex=.75, font=1)
text(-.47, .65, "SMB's d_33% small telescope", col="blue", pos=2)

#dev.off()



