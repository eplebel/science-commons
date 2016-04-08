library(metafor)
library(plotrix) #for ablineclip function

### to save as png file
#png(filename="vul&pashler.png", res=95, width=1200, height=800, type="cairo")

dat <- read.csv(file = "vul&pashler.csv", header = TRUE)
#dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
dat

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$d, dat$var, xlim=c(-2.5, 1.5), at=c(-.3, -.25, 0, .25, .5, .75, .80),
       cex=1.25, ylim=c(-1, 14), rows=c(11:6, 3:2),
       ilab=dat$N, ilab.xpos=-.75, slab=dat$study
       ,xlab="Effect size (dz) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-2.5, 13, "Studies and Replications",    pos=4)
text( 1.5, 13, "Effect sizes (dz) [95% CI]",  pos=2)
text(-.75, 13, c("N"))

### set par back to the original settings
par(op)
par(op, cex=1,font=3)

### fit random-effects model (use slab argument to define study labels)
res <- rma(yi=dat$d, vi=dat$va, data=dat, subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-.75, cex=1.25, mlab="Random-effects meta-analytic estimate of all replications")
### horizontal separation line
abline(h=0)

### fit random-effects model in subgroups
res.rep1 <- rma(yi=dat$d, vi=dat$var, data=dat, subset=(dat$study.info=="replication1"))

### add summary polygons for the three subgroups
addpoly(res.rep1, row=5, cex=1.25, mlab="Meta-analytic estimate of V&P Immediate condition replications")

#ablineclip(v=.25, y1=-2,y2=21, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
#op <- par(cex=.75, font=1)
#text(.25, .75, "Z&L's r_33% small telescope", col="blue", pos=4)

#dev.off()


