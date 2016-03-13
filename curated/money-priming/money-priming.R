library(metafor)
setwd(getwd())

### to save as png file
#png(filename="moneyPriming.png", res=95, width=1200, height=800, type="cairo")

dat <- read.csv(file = "money-priming-replications.csv", header = TRUE)
dat <- escalc(measure="SMD", m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
              n2i=dat$n2i, data=dat, slab=dat$study)
dat
fe.all <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
              n2i=dat$n2i, data=dat, measure="SMD", slab=dat$study)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(fe.all, xlim=c(-4, 3), at=c(-.75,-.50, 0, .50, 1.00, 1.50, 1.75),
       cex=.75, ylim=c(-1, 57), rows=c(54:52, 49:12, 9:8, 6:5, 3:2),
       addfit=FALSE, atransf=FALSE,
       ilab=dat$N, ilab.xpos=-1.5,
       xlab="Effect size (d) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-4, 56, "Studies and Replications",    pos=4)
text(-1.5, 56, c("N"))
text( 3, 56, "Effect sizes (d) [95% CI]",  pos=2)


### set par back to the original settings
par(op)

### fit random-effects model (use slab argument to define study labels)
res <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
           n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-1, cex=1, mlab="Random-effects meta-analytic estimate (replications only)")
### horizontal separation line
abline(h=0)

### fit random-effects model in the three subgroups
res.rep1 <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
                n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.info=="replication1"))
res.rep2 <- rma(m1i=dat$m1i, sd1i=dat$sd1i, n1i=dat$n1i, m2i=dat$m2i, sd2i=dat$sd2i, 
                n2i=dat$n2i, data=dat, measure="SMD", subset=(dat$study.info=="replication2"))

### add summary polygons for the three subgroups
addpoly(res.rep1, row=51, cex=.75, mlab="Meta-analytic estimate of replications of VMG's Study 3")
addpoly(res.rep2, row=11, cex=.75, mlab="Meta-analytic estimate of replications of CVBW's Study 1")


#dev.off()


