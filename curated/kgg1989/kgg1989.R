library(metafor)
library(plotrix) #for ablineclip function
library(compute.es)
#png(filename="kgg1989.png", res=95, width=1300, height=2600, type="cairo")

#effect size calculations
kgg1989 <- fes(1.58,35,30) #Δd interaction effect size based on hartgerink et al (2015, Sup6 File)
kgg1989.deltad = -.69 - (-.16) #Δd = d_males - d_females (playboy effect Δd = -.53 larger for males)
kgg1989.deltad.var = kgg1989$var.d #pooled variance extracted from interaction F-value (may not be exacty right)

dat <- read.csv(file = "kgg1989.csv", header = TRUE)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(dat$delta.d, dat$var, xlim=c(-6, 3.5), at=c(-1.25, -1.0, -.5, 0, .5, 1.0),
       cex=1.5, ylim=c(-1, 7), rows=c(4:1),
       ilab=dat$N, ilab.xpos=-3, slab=dat$study, efac=.4
       ,xlab="Effect size (Δd) [95% CI]", psize=1, pch=dat$study.symbol)
op <- par(cex=1.5, font=2)
text(-6, 6, "Studies and Replications",    pos=4)
text(3.2, 6, "Effect sizes (Δd) [95% CI]",  pos=2)
text(-3, 6, c("N"))

### set par back to the original settings
par(op)
par(op, cex=1,font=3)
### fit random-effects model 
res <- rma(yi=dat$delta.d, vi=dat$var, data=dat, measure="SMD", subset=(dat$study.type=="replication"),
           slab=dat$study)
### add summary estimate to the bottom
addpoly(res, row=-.5, cex=1.2, mlab=NA, efac=.4)
text(-5.7,-.5,"Random-effects meta-analytic estimate of all replications:",pos=4)
### horizontal separation line
abline(h=0)

#dev.off()




### Graphing interaction plots
### to save as png file
#png(filename="kgg1989-interaction-01.png", res=95, width=1000, height=800, type="cairo")

plotsegraph <- function(loc, value, sterr, wiskwidth, color = "grey", linewidth = 2) {
  
  w <- wiskwidth/2
  segments(x0 = loc, x1 = loc, y0 = value - sterr, y1 = value + sterr, col = color, 
           lwd = linewidth)
  segments(x0 = loc - w, x1 = loc + w, y0 = value + sterr, y1 = value + sterr, 
           col = color, lwd = linewidth)  # upper whiskers
  segments(x0 = loc - w, x1 = loc + w, y0 = value - sterr, y1 = value - sterr, 
           col = color, lwd = linewidth)  # lower whiskers
}

#Kenrick et al (1989) Study 2
love.control.men <- 98.8
love.nudes.men <- 87.2
se.love.control.men <- 6
se.love.nudes.men <- 6
love.control.women <- 85.0
love.nudes.women <- 82.3
se.love.control.women <- 5.8
se.love.nudes.women <- 5.8
par(cex.main = 1.5, mar = c(5, 6, 4, 5) + 0.1, mgp = c(3.5, 1, 0), cex.lab = 1.5, 
    font.lab = 2, cex.axis = 1.3, bty = "n", las = 1)
x <- c(1, 2, 3, 4)
plot(x, c(-10, -10, -10, -10), type = "p", ylab = "", xlab = " ", cex = 1.5, 
     ylim = c(77, 104), xlim = c(1, 4), lwd = 2, pch = 5, axes = F, main = " ")
axis(1, at = c(1.5, 2.5), labels = c("Control", "Opposite-sex nudes"))
#mtext("Word Frequency", side = 1, line = 3, cex = 1.5, font = 2)
axis(2, pos = 1.2)
par(las = 0)
mtext(expression("Rubin Love scores"), side = 2, line = -.5, cex = 1.5, font = 2)
x <- c(1.5, 2.5)
points(x, c(love.control.men, love.nudes.men), cex = 2, lwd = 2, pch = 19)
plot.errbars <- plotsegraph(x, c(love.control.men, love.nudes.men), c(se.love.control.men, se.love.nudes.men), 0.1, color = "black")  #0.1 = wiskwidth
lines(c(1.5, 2.5), c(love.control.men, love.nudes.men), lwd = 2, type = "c", lty="dashed")
x <- c(1.5, 2.54) #to add x-axis jitter to disambiguate overlapping CIs
points(x, c(love.control.women, love.nudes.women), cex = 2, lwd = 2, pch = 21)
plot.errbars <- plotsegraph(x, c(love.control.women, love.nudes.women), c(se.love.control.women, se.love.nudes.women), 0.1, color = "black")  #0.1 = wiskwidth
lines(c(1.5, 2.54), c(love.control.women, love.nudes.women), lwd = 2, type = "c", lty="dashed")
points(2.7, 87.2, pch = 19, lwd = 2, cex = 2)
text(2.75, 87.2, "Men", cex = 1.2, font = 1, adj = 0)
points(2.7, 82.3, pch = 21, lwd = 2, cex = 2)
text(2.75, 82.3, "Women", cex = 1.2, font = 1, adj = 0)

#Balzarini et al. Study 1
png(filename="kgg1989-interaction-02.png", res=95, width=1000, height=800, type="cairo")
love.control.men <- 89.19
love.nudes.men <- 92.48
se.love.control.men <- 16.21 / sqrt(64)
se.love.nudes.men <- 17.75 / sqrt(60)
love.control.women <- 95.22
love.nudes.women <- 93.51
se.love.control.women <- 15.79 / sqrt(58)
se.love.nudes.women <- 17.98 / sqrt(41)
par(cex.main = 1.5, mar = c(5, 6, 4, 5) + 0.1, mgp = c(3.5, 1, 0), cex.lab = 1.5, 
    font.lab = 2, cex.axis = 1.3, bty = "n", las = 1)
x <- c(1, 2, 3, 4)
plot(x, c(-10, -10, -10, -10), type = "p", ylab = "", xlab = " ", cex = 1.5, 
     ylim = c(77, 104), xlim = c(1, 4), lwd = 2, pch = 5, axes = F, main = " ")
axis(1, at = c(1.5, 2.5), labels = c("Control", "Opposite-sex nudes"))
#mtext("Word Frequency", side = 1, line = 3, cex = 1.5, font = 2)
axis(2, pos = 1.2)
par(las = 0)
mtext(expression("Rubin Love scores"), side = 2, line = -.5, cex = 1.5, font = 2)
x <- c(1.5, 2.5)
points(x, c(love.control.men, love.nudes.men), cex = 2, lwd = 2, pch = 19)
plot.errbars <- plotsegraph(x, c(love.control.men, love.nudes.men), c(se.love.control.men, se.love.nudes.men), 0.1, color = "black")  #0.1 = wiskwidth
lines(c(1.5, 2.5), c(love.control.men, love.nudes.men), lwd = 2, type = "c", lty="dashed")
x <- c(1.5, 2.54) #to add x-axis jitter to disambiguate overlapping CIs
points(x, c(love.control.women, love.nudes.women), cex = 2, lwd = 2, pch = 21)
plot.errbars <- plotsegraph(x, c(love.control.women, love.nudes.women), c(se.love.control.women, se.love.nudes.women), 0.1, color = "black")  #0.1 = wiskwidth
lines(c(1.5, 2.54), c(love.control.women, love.nudes.women), lwd = 2, type = "c", lty="dashed")
points(2.7, 87.2, pch = 19, lwd = 2, cex = 2)
text(2.75, 87.2, "Men", cex = 1.2, font = 1, adj = 0)
points(2.7, 82.3, pch = 21, lwd = 2, cex = 2)
text(2.75, 82.3, "Women", cex = 1.2, font = 1, adj = 0)

dev.off()
