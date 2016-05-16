full.data <- read.csv("https://osf.io/5dsj8/?action=download")
data <- subset(full.data, full.data$Excluded == 0) #ignore excluded Ps
correct <- data$Lineup_Choice == 6
data <- cbind(data,correct)
verbal.identification.rate <- sum(subset(data$correct, data$Condition == "Experimental")) / length(subset(data$correct, data$Condition == "Experimental"))
control.identification.rate <- sum(subset(data$correct, data$Condition == "Control")) / length(subset(data$correct, data$Condition == "Control"))
effect.size = verbal.identification.rate - control.identification.rate
cat("VERBAL condition identification rate  =",verbal.identification.rate, "\n")
cat("CONTROL condition identification rate =",control.identification.rate, "\n")
cat("Verbal overshadowing effect size =", effect.size, "\n")
chisq <- chisq.test(subset(data$correct, data$Condition == "Experimental"),subset(data$correct, data$Condition == "Control"))
cat("Pearson's Chi-squared test of observed difference, X^2(1) =", chisq$statistic, ", p-value =", chisq$p.value, "\n")
Input =("Value     Verbal  Control 
 Correct  25    31  
 Incorrect  25    19 ")
Matriz = as.matrix(read.table(textConnection(Input),header=TRUE, row.names=1))
par(bg=NA)
barplot(Matriz, beside=TRUE, legend=TRUE, ylim=c(0, 35),xlab="Experimental Condition", ylab="Number of Ps", cex.axis=1.5, cex.names=1.5, col = c("green", "red"))
cat("***ACTIVE SAMPLE EVIDENCE***", "\n")
height.sex.diff <- t.test(subset(data$Confidence, data$Condition == "Experimental")+.8,subset(data$Confidence, data$Condition == "Control"))
cat("On average, MALES taller than FEMALES, t(98) = ", height.sex.diff$statistic, ", p-value = ", height.sex.diff$p.value, "\n")