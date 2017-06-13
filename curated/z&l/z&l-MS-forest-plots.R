library(metafor)

### Z&L (2006) STUDY 2 REPLICATIONS FOREST PLOT
### to save as png file
png(filename="z&l-study2-reps-forest-plot.png", res=95, width=1200, height=750, type="cairo")
dat <- read.csv(file = "z&l-study2-replications.csv", header = TRUE)
dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
dat
### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$yi, dat$vi, xlim=c(-3, 2.1), at=c(-.35, -.25, 0, .25, .5, .76),
       cex=1.5, ylim=c(-1, 8.5), rows=c(6:0),
       xlab="Effect size (r) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
### set par back to the original settings
par(op)
par(op, cex=1.25, font=3)
### fit fixed-effects model (use slab argument to define study labels)
res <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.type=="replication"),
           slab=dat$study, method="FE")
### add summary estimate to the bottom
addpoly(res, row=-.9, cex=1.25, mlab="", efac=1.3)
text(-2.82, -.9, "Current meta-analytic estimate of replications", pos=4)
### horizontal separation line
abline(h=-.5)
dev.off()


### Z&L (2006) STUDY 3 REPLICATIONS FOREST PLOT
### to save as png file
png(filename="z&l-study3-reps-forest-plot.png", res=95, width=1200, height=485, type="cairo")
dat <- read.csv(file = "z&l-study3-replications.csv", header = TRUE)
dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
dat
### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$yi, dat$vi, xlim=c(-3, 2.2), at=c(-.2, 0, .25, .5, .7),
       cex=1.5, ylim=c(-1, 4.5), rows=c(2:0),
       xlab="Effect size (r) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
### set par back to the original settings
par(op)
par(op, cex=1.25, font=3)
### fit fixed-effects model (use slab argument to define study labels)
res <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.type=="replication"),
           slab=dat$study, method="FE")
### add summary estimate to the bottom
addpoly(res, row=-.9, cex=1.25, mlab="", efac=1.5)
text(-2.8, -.9, "Current meta-analytic estimate of replications", pos=4)
### horizontal separation line
abline(h=-.5)
dev.off()
