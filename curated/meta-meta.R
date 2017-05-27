library(metafor)


### to save as png file
#png(filename="meta-meta-forest-plot.png", res=95, width=1250, height=600, type="cairo")
dat <- read.csv(file = "social.rep.rate.meta-meta.csv", header = TRUE)
dat <- escalc(measure="PR", xi=dat$num.eff.replicable, ni=dat$total.effects, data=dat, slab=dat$meta.study)
dat
meta.meta <- rma(xi=dat$num.eff.replicable, ni=dat$total.effects, data=dat, measure="PR", slab=dat$.meta.study)

### decrease margins so the full space is used
op <- par(cex=1.25, font=1)
par(mar=c(4,4,1,2))
### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(meta.meta,slab=dat$meta.study,
       xlim=c(-2.25,2), xlab="Replicability rate [95% CIs]",
       mlab="Meta-meta-analytic estimate",
       psize=1.25,showweights = FALSE, at=c(0,.25,.50,.75,1.0),
        ilab=cbind(dat$num.eff.replicable, dat$total.effects),
        ilab.xpos=c(-.8,-.4))

op <- par(cex=1, font=3)
text(c(-1.1,-.57), 7.5, c("Num.Replicable", "Total.Reps"),pos=4)

# replicable = qualitative judgment of replication effect wrt p < .05
#   and similarity of effect size compared to original



#dev.off()
