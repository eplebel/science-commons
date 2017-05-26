library(metafor)

### Buss et al. (1999) replications FOREST PLOT
png(filename="bussetal-MS-forest-plot-01.png", res=95, width=1250, height=450, type="cairo")
dat <- read.csv(file = "bussetal1999-reps.csv", header = TRUE)
fe.all <- rma(yi=dat$yi, vi=dat$vi, data=dat, slab=dat$study)
### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-6, 5.5), at=c(-.5, 0, .5, 1., 1.5, 2),
       cex=1.5, ylim=c(-1, 6), rows=c(3:0),
       addfit=FALSE,
       xlab="Cohen's d [95% CI]", psize=1, pch=dat$study.symbol)
### set par back to the original settings
par(op, cex=1.5, font=3)
### add summary estimate to the bottom
res <- rma(yi=dat$yi, vi=dat$vi, data=dat,  
           subset=(dat$study.type=="replication"), slab=dat$study)
addpoly(res, row=-.9, cex=1.25, mlab="", efac=1.5)
text(-5.7, -1, "Meta-analytic estimate of replications", pos=4)
abline(h=-.5)
dev.off()


### Shackelford et al. (2004) replications FOREST PLOT
png(filename="bussetal-MS-forest-plot-02.png", res=95, width=1250, height=425, type="cairo")
dat <- read.csv(file = "shackelfordetal2004-reps.csv", header = TRUE)
fe.all <- rma(yi=dat$yi, vi=dat$vi, data=dat, slab=dat$study)
### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-6, 4.9), at=c(-.5, 0, .5, 1., 1.5),
       cex=1.5, ylim=c(-1, 5), rows=c(2:0),
       addfit=FALSE,
       xlab="Cohen's d [95% CI]", psize=1, pch=dat$study.symbol)
### set par back to the original settings
par(op, cex=1.5, font=3)
### add summary estimate to the bottom
res <- rma(yi=dat$yi, vi=dat$vi, data=dat,  
           subset=(dat$study.type=="replication"), slab=dat$study)
addpoly(res, row=-.9, cex=1.25, mlab="", efac=1.5)
text(-5.7, -1, "Meta-analytic estimate of replications", pos=4)
abline(h=-.5)
dev.off()