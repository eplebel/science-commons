library(metafor)

### BEM (2011) STUDY 8 REPLICATION FOREST PLOT
### to save as png file
png(filename="bem2011-study8-reps-forest-plot.png", res=95, width=1250, height=600, type="cairo")
dat <- read.csv(file = "bem-study8-reps.csv", header = TRUE)
dat <- escalc(measure="MN", mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, slab=dat$study)
dat
fe.all <- rma(mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, measure="MN", slab=dat$study)
### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-22, 18), at=c(-7,-6,-4,-2,0,2,4,5.5),
       cex=1.5, ylim=c(-1, 6.5), rows=c(4:0),
       addfit=FALSE, atransf=FALSE,
       xlab="Effect size (DR%) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.5, font=3)
### set par back to the original settings
par(op, cex=1.5, font=3)
### fit random-effects model (use slab argument to define study labels)
res <- rma(mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, measure="MN", 
           subset=(dat$study.type=="replication"), slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1.25, mlab="")
text(-20.5, -1, "Meta-analytic estimate of replications", pos=4)
### horizontal separation line
abline(h=-.5)
dev.off()


### BEM (2011) STUDY 9 REPLICATION FOREST PLOT
### to save as png file
png(filename="bem2011-study9-reps-forest-plot.png", res=95, width=1250, height=800, type="cairo")
dat <- read.csv(file = "bem-study9-reps.csv", header = TRUE)
dat <- escalc(measure="MN", mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, slab=dat$study)
dat
fe.all <- rma(mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, measure="MN", slab=dat$study)
### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-26, 18), at=c(-7,-6,-4,-2,0,2,4,6,7),
       cex=1.5, ylim=c(-1, 9.5), rows=c(7:0),
       addfit=FALSE, atransf=FALSE,
       xlab="Effect size (DR%) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.5, font=3)
### set par back to the original settings
par(op, cex=1.5, font=3)
### fit random-effects model (use slab argument to define study labels)
res <- rma(mi=dat$mi, sdi=dat$sdi, ni=dat$ni, data=dat, measure="MN", 
           subset=(dat$study.type=="replication"), slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1.25, mlab="")
text(-24.5, -1, "Meta-analytic estimate of replications", pos=4)
### horizontal separation line
abline(h=-.5)
dev.off()