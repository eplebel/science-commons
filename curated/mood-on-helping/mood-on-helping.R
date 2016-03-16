library(metafor)
### to save as png file
#png(filename="schnalletal2008a.png", res=95, width=1200, height=800, type="cairo")

#direct input of data approach
header <- c("study"                            ,"s.type","s.info","s.symbol","ai","bi","ci","di","N")
s1 <- c("Isen & Levin (1972) Study 2"          ,"orig"  ,"orig1" ,1         ,14  ,2   ,1   ,24  ,41)
s2 <- c("       Blevins & Murphy (1974)"       ,"rep"   ,"rep1"  ,15        ,6   ,9   ,15  ,20  ,50)
s3 <- c("Levin & Isen (1975) Study 1"          ,"orig"  ,"orig2" ,1         ,10  ,1   ,4   ,9   ,24)
s4 <- c("       Weyant & Clark (1977) Study 1" ,"rep"   ,"rep2"  ,15        ,6   ,10  ,2   ,14  ,32)
s5 <- c("       Weyant & Clark (1977) Study 2" ,"rep"   ,"rep2"  ,15        ,12  ,42  ,15  ,37  ,106)
dat <- rbind.data.frame(s1,s2,s3,s4,s5)
colnames(dat) <- header
dat$s.symbol <- as.numeric(as.character(dat$s.symbol)) #workaround for now
dat$ai <- as.numeric(as.character(dat$ai))
dat$bi <- as.numeric(as.character(dat$bi))
dat$ci <- as.numeric(as.character(dat$ci))
dat$di <- as.numeric(as.character(dat$di))
dat$N <- as.numeric(as.character(dat$N))

re.all <- rma(ai=dat$ai, bi=dat$bi, ci=dat$ci, di=dat$di, data=dat, measure="RD", 
              slab=dat$study)

### decrease margins so the full space is used
op <- par(cex=1, font=1)
par(mar=c(4,4,1,2))

### set up forest plot (rows argument used to specify exactly in which rows outcomes will be plotted)
forest(re.all, xlim=c(-4, 3), at=c(-.50, 0, .50, 1.0, 1.5),
       cex=1.25, ylim=c(-1, 10), rows=c(7:6,4:2),
       addfit=FALSE, atransf=FALSE,
       ilab=dat$N, ilab.xpos=-1,
       xlab="Effect size (RD) [95% CI]", psize=1, pch=dat$s.symbol)
op <- par(cex=1.25, font=3)
text(-4, 9, "Studies and Replications",    pos=4)
text(-1, 9, c("N"))
text( 3, 9, "Effect sizes (RD) [95% CI]",  pos=2)


### set par back to the original settings
par(op, cex=1,font=3)

### fit random-effects model (use slab argument to define study labels)
re.reps <- rma(ai=dat$ai, bi=dat$bi, ci=dat$ci, di=dat$di, data=dat, measure="RD", 
                subset=(dat$s.type=="rep"), slab=dat$study)
### add summary estimate to the bottom
addpoly(re.reps, row=-1, cex=1.25, mlab="Random-effects meta-analytic estimate (replications only)")
### horizontal separation line
abline(h=0)

### fit random-effects model in subgroups
res.rep2 <- rma(ai=dat$ai, bi=dat$bi, ci=dat$ci, di=dat$di, data=dat, measure="RD", 
                subset=(dat$s.info=="rep1"))

### add summary polygons for the three subgroups
addpoly(res.rep2, row=1, cex=1.25, mlab="Meta-analytic estimate of replications of L&I's Study 1")


#dev.off()


