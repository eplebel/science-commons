
#DATA COLADA[42] - ACCEPTING THE NULL - Correlation between Small Telescopes results and Bayesian Analysis of Replications
		#UPDATED FOR POST [47], ADDED LINES 29-31 
#Using data for the Reproducibility Project (2015) this code computes the correlation between the p-value testing the null that the true effect size is big enough to give
#the original 33% power, and the Bayes Factor for replications. 


    
  library("pwr")    #Load (and install if needed) libraries for power and for CI computation
  #Load summary table with results from the Reproducibility project, obtained from  Alex Etz post
  #http://alexanderetz.com/2015/08/30/the-bayesian-reproducibility-project/
    repro = read.csv("http://opim.wharton.upenn.edu/~uws/BlogAppendix/Colada42/Summay%20by%20Alex%20Etz%20of%20Reproducibility%20Project.csv")  # read csv file 

  #"Attach" the dataset, so i can refer to variables without saying repro$x each time, I can just say x and R knows what I mean
    attach(repro)

  #Create function to get d that gives  33% power
      get.d33=function(n,power) pwr.t.test(n=n,power=power)$d         
  #Apply function to compute d33 in every study
      d33=mapply(get.d33,n=N_orig/2, power=1/3)
  #Convert r to d  
      d_rep=2*r_rep/(sqrt(1-r_rep**2))
      d_ori=2*r_orig/(sqrt(1-r_orig**2))
  #Compute p-value testing null that d=d33
      t_rep=d_rep/2*sqrt(N_rep)                      #Confert the d fro teh repcliation into t-statistic
      p33=pt(t_rep,df=N_rep-2,ncp=sqrt(N_rep/4)*d33) #Compute probability of at least as extreme a value, if the null of d=d33 were true
                                                     #This uses the noncentral t distribution with ncp=sqrt(n/2)*d
                                                     #n/2 is per cell, we have N total, so assuming two-sample tests it is N/4
	#Share accept null when 
      sum(p33<.05)/length(p33)     #25% with small telescopes
      sum(bfRep<1/3)/length(bfRep) #38% with Bayesian
	  
	  
    #Correlation between p-value for null of d=d33 and BayesFactor for replciation among all replications
      cor(bfRep,p33,method='spearman')
    #Among subset of "failed" replications, p>..05
      cor(bfRep[rep_pval>.05],p33[rep_pval>.05],method='spearman')
      
    #Print Study 7 mentioned in the blogpost, from Alex Etz posted results
      repro[Study.=="7",]  #BF accepts null, at BF=.05 it is  <<1/3
    #Small Telescopes calculations
      d33[Study.=="7"]   #d33 is d=.31
      p33[Study.=="7"]   #Do not reject the null that d=d33, p=.46
      
      
      
  