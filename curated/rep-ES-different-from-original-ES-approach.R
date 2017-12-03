###################################################################################################
#rep ES 95% CI includes original ES point estimate approach
#test whether rep ES statistically different from original ES, given sampling error of replication; 
###################################################################################################

myiter=10000 #number of iterations
sample.ES.array = array(0,dim=myiter) #interaction coefficient array of size=myiter
countcrit=0
for (i in 1:myiter)  
{
  if (round(i/100)==i/100) print(i) #just to show progress
  #extract sample of replication size from "true" population treatment condition from original study (observed d=.78)
  treatment.sample <- rnorm(n=120, mean=46.05, sd=16.40) 
  #extract sample of replication size from "true" population control condition from original study
  control.sample <- rnorm(n=120, mean=32.90, sd=17.98) 
  sample.d <- (mean(treatment.sample) - mean(control.sample))/ mean(c(sd(treatment.sample),sd(control.sample)))
  sample.ES.array[i] = sample.d
  if (sample.d <= .55) countcrit=countcrit+1 #if subSample d <= replication effect size, increase counter by 1
}
prob=countcrit/myiter #probability that replication effect size (or smaller) originated from random sampling
print(prob) #p<.0
hist(sample.ES.array)


#conclusion:
#a replication d=.55 (or smaller) for a replication of N=240 is inconsistent with original d=.78 
#i.e., deviation from original effect size is greater than what is expected given sampling error in replication;
#and indeed 95% CI for a replication d=.55 just overlaps d=.78
mes(.55,0,1,1,120,120) #d=.55 +/- .26 [.29, .81]


#########################################################
#Minimum-effect-size APPROACH (LeBel, 2014) (e.g., d_min)
#########################################################
require(pwr)
pwr.t.test(n=148,d=NULL,power=0.95,sig.level=0.05,type="two.sample",alternative="two.sided") 
#In our combined sample, we could reliably (95% power) have detected a d=.42 if it existed

#this is a much simpler and intuitively understandable approach to making sense of our replication results!
#CONCLUSION: we had the sensitivity (at 95% level) to detect an effect as small as d=.42
#An effect smaller than this *COULD* exist, but you would need a much larger N to reliably detect it!! 
#(e.g., an N=600 to reliably detect a d=.30)!!