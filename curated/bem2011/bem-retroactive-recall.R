library(metafor)

### to save as png file
#png(filename="bem2011-study8-reps-forest-plot.png", res=95, width=1200, height=800, type="cairo")


dat <- read.csv(file = "bem-study8-reps.csv", header = TRUE)

#CIs are way to small@#@#%
dat <- escalc(measure="MN", mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, slab=dat$study)
dat
fe.all <- rma(mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, measure="MN", slab=dat$study)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-5, 4), at=c(-1.5, -1, -.50, 0, .50, 1.0, 1.5, 2.0, 2.5),
       cex=1.25, ylim=c(-1, 8), rows=c(5:1),
       addfit=FALSE, atransf=FALSE,
       ilab=dat$N, ilab.xpos=-2.5,
       xlab="Effect size (DR%) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-5, 7, "Studies and Replications",    pos=4)
text(-1.5, 7, c("N"))
text( 4, 7, "Effect sizes (DR%) [95% CI]",  pos=2)


### set par back to the original settings
par(op, cex=1, font=3)

### fit random-effects model (use slab argument to define study labels)
res <- rma(mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, measure="MN", 
           subset=(dat$study.type=="replication"), slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1.25, mlab="Random-effects meta-analytic estimate of replications")
### horizontal separation line
abline(h=-.5)



#dev.off()



