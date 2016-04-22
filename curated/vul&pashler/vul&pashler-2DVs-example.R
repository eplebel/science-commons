library(metafor)
library(plotrix) #for ablineclip function

### to save as png file
#png(filename="vul&pashler.png", res=95, width=1200, height=800, type="cairo", bg="transparent")

dat <- read.csv(file = "vul&pashler-2DVs-example.csv", header = TRUE)
#dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
#dat

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$d, dat$var, xlim=c(-2.5, 1.5), at=c(-.15, 0, .25, .5, .75, .80),
       cex=1.40, ylim=c(0, 14.5), rows=c(11.5:10.5, 9:8, 6.5:5.5, 4:3),
       ilab=cbind(as.character(dat$study.outcome),dat$N), ilab.xpos=c(-.85,-.35), slab=dat$study
       ,xlab="Effect size (dz) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-2.5, 13.2, "Studies and Replications",    pos=4)
text( 1.5, 13.2, "Effect sizes (dz) [95% CI]",  pos=2)
text(c(-.85,-.35), 13.2, c("Outcome","N"))

### set par back to the original settings
par(op)
par(op, cex=1,font=3)

### fit random-effects model
#res <- rma(yi=dat$d, vi=dat$va, data=dat, subset=(dat$study.type=="replication"))
### add summary estimate to the bottom
#addpoly(res, row=-.75, cex=1.25, mlab=NA)
#text(-2.2, -.75, "Random-effects meta-analytic estimate of all replications",pos=4)
### horizontal separation line
abline(h=2.25)

### fit random-effects model in subgroups
res.rep1 <- rma(yi=dat$d, vi=dat$var, data=dat, subset=(dat$study.info=="replication1"))
res.rep2 <- rma(yi=dat$d, vi=dat$var, data=dat, subset=(dat$study.info=="replication2"))

### add summary polygons for the three subgroups
addpoly(res.rep1, row=1.5, cex=1.25, mlab=NA)
addpoly(res.rep2, row=0.5, cex=1.25, mlab=NA)
text(-2.35, 1.5, "Meta-analytic estimate of V&P replications, DV1: Immediate",pos=4,cex=1.25)
text(-2.35, 0.5, "Meta-analytic estimate of V&P replications, DV2: Delayed",pos=4,cex=1.25)

#ablineclip(v=.25, y1=-2,y2=21, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
#op <- par(cex=.75, font=1)
#text(.25, .75, "Z&L's r_33% small telescope", col="blue", pos=4)

#dev.off()


