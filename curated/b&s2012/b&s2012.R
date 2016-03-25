library(metafor)
library(plotrix) #for ablineclip function

### to save as png file
#png(filename="b&s2012.png", res=95, width=1200, height=800, type="cairo")

dat <- read.csv(file = "b&s2012-replications(sorted).csv", header = TRUE)
dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
dat

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$yi, dat$vi, xlim=c(-2.5, 2), at=c(-.5, -.25, 0, .25, .5, .75, 1),
       cex=1.25, ylim=c(-1, 16), rows=c(13:1),
       ilab=dat$N, ilab.xpos=-.75
       ,xlab="Effect size (r) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-2.5, 15, "Studies and Replications",    pos=4)
text( 2, 15, "Effect sizes (r) [95% CI]",  pos=2)
text(-.75, 15, c("N"))

### set par back to the original settings
par(op)
par(op, cex=1,font=3)

### fit random-effects model (use slab argument to define study labels)
res <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-.75, cex=1.25, mlab="Random-effects meta-analytic estimate of all replications")
### horizontal separation line
abline(h=0)

### fit random-effects model in subgroups
#res.rep1 <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.info=="replication1"))

### add summary polygons for the three subgroups
#addpoly(res.rep1, row=2, cex=1.25, mlab="Meta-analytic estimate of B&S Study 1 replications")

#ablineclip(v=.25, y1=-2,y2=21, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
#op <- par(cex=.75, font=1)
#text(.25, .75, "Z&L's r_33% small telescope", col="blue", pos=4)

#dev.off()


