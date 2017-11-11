#CODE for 95% CIs for various EFFECT SIZEs

#95% CIs for between-subjects cohen's d
require(compute.es)
tes(2.26,28,28)
tes(0.221, 110,109)
tes(0.358, 125,108)



#95% CIs for eta-square effect size (for between- and within-subjects designs)
library(MBESS)
Lims <- conf.limits.ncf(F.value = 6.91, conf.level = 0.95, df.1 <- 1, df.2 <- 79)
Lower.lim <- Lims$Lower.Limit/(Lims$Lower.Limit + df.1 + df.2 + 1)
Upper.lim <- Lims$Upper.Limit/(Lims$Upper.Limit + df.1 + df.2 + 1)
Lower.lim
Upper.lim




#other stuff that was useful in curating effect sizes
require(metafor)
escalc

dat <- escalc(measure="SMD", ai = 53.1, bi = 46.9, n1i=100)

require(pwr)
pwr.t2n.test(n1=600,n2=300,sig.level=.05,power=.80)


require(lsr)
oneSampleTTest(x=53.1, 50, one.sided=FALSE, conf.level=.95 )

mes(27.78, 3.79, 150)

tes (t=2.51, 50, 50)

bem.2011.study1 <- rnorm(n=100, 2.27, 1.17)
t.test(bem.2011.study1, mu=0, conf.level=0.95)
res(.34, n=29)
res(.05, n=396)

mes(3.92, 3.73, 1.46, 1.57, 48, 52)
tes(t=2.45, 24, 24)

chies(3.85, 37)

#CI for RP:P social psych studies replicability rate
prop.test(14, 55)
#CI for ML1 social psych studies replicability rate
prop.test(5, 8)
#CI for ML3
prop.test(1, 8)
#CI for SP special issue
prop.test(4, 31)
