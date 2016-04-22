### to save as png file
png(filename="kgg1989.png", res=95, width=1000, height=800, type="cairo")


plotsegraph <- function(loc, value, sterr, wiskwidth, color = "grey", linewidth = 2) {
  
  w <- wiskwidth/2
  segments(x0 = loc, x1 = loc, y0 = value - sterr, y1 = value + sterr, col = color, 
           lwd = linewidth)
  segments(x0 = loc - w, x1 = loc + w, y0 = value + sterr, y1 = value + sterr, 
           col = color, lwd = linewidth)  # upper whiskers
  segments(x0 = loc - w, x1 = loc + w, y0 = value - sterr, y1 = value - sterr, 
           col = color, lwd = linewidth)  # lower whiskers
}

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
     ylim = c(75, 105), xlim = c(1, 4), lwd = 2, pch = 5, axes = F, main = " ")
axis(1, at = c(1.5, 2.5), labels = c("Control", "Opposite-sex nudes"))
#mtext("Word Frequency", side = 1, line = 3, cex = 1.5, font = 2)
axis(2, pos = 1.2, )
par(las = 0)
mtext(expression("Rubin Love scores"), side = 2, line = -.5, cex = 1.5, font = 2)
x <- c(1.5, 2.5)
points(x, c(love.control.men, love.nudes.men), cex = 1.5, lwd = 2, pch = 19)
plot.errbars <- plotsegraph(x, c(love.control.men, love.nudes.men), c(se.love.control.men, se.love.nudes.men), 0.1, color = "black")  #0.1 = wiskwidth
lines(c(1.5, 2.5), c(love.control.men, love.nudes.men), lwd = 2, type = "c", lty="dashed")
x <- c(1.5, 2.52) #to add x-axis jitter to disambiguate overlapping CIs
points(x, c(love.control.women, love.nudes.women), cex = 1.5, lwd = 2, pch = 21)
plot.errbars <- plotsegraph(x, c(love.control.women, love.nudes.women), c(se.love.control.women, se.love.nudes.women), 0.1, color = "black")  #0.1 = wiskwidth
lines(c(1.5, 2.52), c(love.control.women, love.nudes.women), lwd = 2, type = "c", lty="dashed")

points(2.7, 87.2, pch = 19, lwd = 2, cex = 1.5)
text(2.75, 87.2, "Men", cex = 1.2, font = 1, adj = 0)
points(2.7, 82.3, pch = 21, lwd = 2, cex = 1.5)
text(2.75, 82.3, "Women", cex = 1.2, font = 1, adj = 0)

dev.off()
