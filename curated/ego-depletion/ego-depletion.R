library(metafor)
library(plotrix) #for ablineclip function
library(compute.es)

#effect size calculations
#gaillot et al. (2007) study 7
r.gaillotetal2007 <- fes(5.04,31,30)
r.cesario.corker <- fes(.122,60,59)
r.wang.dvorak <- fes(15.61, 31,30)
r.lange.eggert <- fes(1.12, 35,35)
r.schmeicheletal <- tes(3.87, 12, 12) #total # correct
r.pondetal <- tes(1.97, 65, 63) #from g=.35 from Carter et al.'s (2015) meta-analysis Table 1
r.schmeichel2007 <- mes(32.88, 34.68, 4.15, 5.5, 41, 38) #total target words (OSPAN only)
r.healyetal <- mes(54.3, 69.8, 12.2, 11.4, 19,19) #% of target words

r.carter.mccullough.sucralose <- mes(39.8, 40.4, 6.8, 5.2, 45, 47)
r.carter.mccullough.sucralose$r
r.carter.mccullough.unsweetened <- mes(41.54, 39.38, 6.6, 5.9, 26, 24)
r.carter.mccullough.unsweetened$r
#weighted average of sucralose and unsweetened control conditions
r.carter.mccullough = (r.carter.mccullough.sucralose$r * r.carter.mccullough.sucralose$N.total + r.carter.mccullough.unsweetened$r * r.carter.mccullough.unsweetened$N.total)/ (r.carter.mccullough.sucralose$N.total + r.carter.mccullough.unsweetened$N.total)
r.lurquinetal <- tes(-1.46, 100,100)
r.muravenetal <- mes(563, 758, 240, 280, 17, 17)
r.murtagh.todd <- mes(628.88, 633.68, 354.42, 302.82, 26,25)
r.sripadaetal <- tes(2.38, 24,23)


### to save as png file
#png(filename="b&s2012.png", res=95, width=1200, height=800, type="cairo")

dat <- read.csv(file = "b&s2012-replications(sorted).csv", header = TRUE)
dat <- escalc(measure="COR", ri=dat$r, ni=dat$N, data=dat, slab=dat$study)
dat

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$yi, dat$vi, xlim=c(-2.5, 1.5), at=c(-.3, -.25, 0, .25, .5, .75, .80),
       cex=1.25, ylim=c(-1, 22), rows=c(19:5, 2:1),
       ilab=dat$N, ilab.xpos=-.75
       ,xlab="Effect size (r) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.25, font=3)
text(-2.5, 21, "Studies and Replications",    pos=4)
text( 1.5, 21, "Effect sizes (r) [95% CI]",  pos=2)
text(-.75, 21, c("N"))

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
res.rep1 <- rma(yi=dat$yi, vi=dat$vi, data=dat, measure="COR", subset=(dat$study.info=="replication1"))

### add summary polygons for the three subgroups
addpoly(res.rep1, row=4, cex=1.25, mlab="Meta-analytic estimate of B&S Study 1 replications")

#ablineclip(v=.25, y1=-2,y2=21, col="blue", lty="dashed", lwd=.25) #Simonsohn's small telescope line
#op <- par(cex=.75, font=1)
#text(.25, .75, "Z&L's r_33% small telescope", col="blue", pos=4)

#dev.off()


