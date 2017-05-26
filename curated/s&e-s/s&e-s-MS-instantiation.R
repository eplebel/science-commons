#RRR2: s&e-s study 1 reps for curation MS (original instantiation)
library("metafor")
#setwd(getwd())

### to save as png file
png(filename="S&E-S-MS-forest-plot-01.png", res=95, width=1200, height=1200, type="cairo")

# Import the data
data <- read.table(textConnection(
 "Lab	Author	Group	Country	Language	N_verbal	N_verbal_excluded	N_verbal_excluded_age	N_verbal_excluded_race	N_verbal_excluded_other	N_verbal_included	N_verbal_correct	N_verbal_foil	N_verbal_miss	N_control	N_control_excluded	N_control_excluded_age	N_control_excluded_race	N_control_excluded_other	N_control_included	N_control_correct	N_control_foil	N_control_miss
1 Schooler & Engstler-Schooler (1990), Study 1	Schooler & Eng-Schooler (1990) Study 1	Original	USA	English	44	0	0	0	0	44	17	16	11	44	0	0	0	0	44	28	10	6
12  Daniel L. Greenberg, Marino Mugayar-Baldocchi	    Greenberg & M-Baldocchi (2014)	Both	USA	English	37	7	0	7	0	30	15	7	8	38	8	0	7	1	30	19	8	3
14  Chris Koch, Remi Gentry, Jennifer Shaheed, Kelsi Buswell	    Koch, Gentry et al. (2014)	Both	USA	English	35	5	1	3	1	30	11	9	10	32	2	1	1	0	30	14	8	8
5 Angela R. Birt, Philip Aucoin	    Birt & Aucoin (2014)	Both	Canada	English	33	3	0	3	0	30	8	13	9	32	1	0	1	0	31	16	7	8
18  Robin Musselman, Michael Colarusso	    Musselman & Colarusso (2014)	Both	USA	English	38	8	0	8	0	30	7	10	13	40	10	0	10	0	30	14	12	4
22  W. Burt Thompson	    Thompson (2014)	Both	USA	English	51	13	1	12	0	38	20	5	13	51	12	1	11	0	39	24	6	9
16  Shannon McCoy, Arielle Rancourt	    McCoy & Rancourt (2014)	Both	USA	English	45	4	1	3	0	41	13	7	21	44	3	1	2	0	41	19	8	14
11  Casey M. Eggleston, Calvin K. Lai, Elizabeth A. Gilbert	    Eggleston, Lai, & Gilbert (2014)	Both	USA	English	49	6	1	0	5	43	15	8	20	44	3	0	0	3	41	15	17	9
19  Christopher R. Poirier, Matthew K. Attaya, Kathleen A. McConnaughy, Jessica E. Pappagianopoulos, Griffin A. Sullivan	    Poirer et al. (2014)	Both	USA	English	46	2	0	1	1	44	13	13	18	49	8	0	0	8	41	24	9	8
10  Gerald Echterhoff, René Kopietz	    Echterhoff & Kopietz (2014)	Both	Germany	German	58	15	10	0	5	43	15	8	20	66	20	15	0	5	46	26	11	9
13  Andre Kehn, Kimberly Schweitzer, Bradlee W. Gamblin, Kimberly Wiseman, Narina L. Nunez	    Kehn et al. (2014)	Both	USA	English	55	6	1	5	0	49	23	7	19	58	8	1	7	0	50	24	13	13
6 Maria A. Brandimonte	    Brandimonte (2014)	Both	Italy	Italian	50	0	0	0	0	50	23	7	20	50	0	0	0	0	50	24	17	9
17  Abigail A. Mitchell, Marilyn S. Petro	    Mitchell & Petro (2014)	Both	USA	English	57	11	0	9	2	46	13	13	20	52	6	1	2	3	46	22	11	13
3 Victoria K. Alogna, Jamin Halberstadt, Jonathan Jong, Joshua C. Jackson, Cathy Ng	    Alogna et al. (2014)	Both	New Zealand	English	70	20	0	20	0	50	25	7	18	67	17	0	17	0	50	31	15	4
9 Jean-Francois Delvenne, Charity Brown, Emma Portch, Tara Zaksaite	    Delvenne, Brown et al. (2014)	Both	United Kingdom	English	48	2	0	1	1	46	13	10	23	50	2	0	1	1	48	26	11	11
23  Joanna Ulatowska, Aleksandra Cislak	    Ulatowska & Cislak (2014)	Both	Poland	Polish	51	4	0	0	4	47	27	8	12	55	8	0	0	8	47	35	7	5
15  Nicola Mammarella, Beth Fairfield, Alberto Di Domenico	    Mammarella et al. (2014)	Both	Italy	Italian	50	0	0	0	0	50	15	13	22	54	4	4	0	0	50	26	8	16
4 Stacy Birch	    Birch (2014)	Both	USA	English	83	30	1	25	4	53	27	13	13	73	19	1	14	4	54	36	10	8
20  Eva Rubínová, Marek Vranka, Štěpán Bahník	    Rubínová, Vranka, & Bahník (2014)	Both	Czech Republic	Czech	56	4	0	0	4	52	16	19	17	54	4	0	0	4	50	17	20	13
21  Kyle J. Susa, Jessica K. Swanner, Christian A. Meissner	    Susa, Swanner, & Meissner (2014)	Both	USA	English	53	3	0	3	0	50	11	10	29	58	8	0	8	0	50	23	13	14
24  Kimberley A. Wade, Ulrike Körner, Melissa F. Colloff, Melina A. Kunar	    Wade, Körner et al. (2014)	Both	United Kingdom	English	61	1	0	0	1	60	26	19	15	60	0	0	0	0	60	36	19	5
8 Kimberly S. Dellapaolera, Brian H. Bornstein	    Dellapaolera & Bornstein (2014)	Both	USA	English	82	10	0	10	0	72	26	25	21	82	15	0	15	0	67	38	13	16
7 Curt Carlson, Dawn Weatherford, Maria Carlson	    Carlson et al. (2014)	Both	USA	English	81	6	4	0	2	75	32	26	17	79	4	3	0	1	75	50	12	13
2 Robert B. Michael, Gregory Franco, Mevagh Sanson, Maryanne Garry	    Michael et al. (2014, ONLINE)	Online	New Zealand	English	302	98	0	0	98	204	94	47	63	313	130	0	0	130	183	104	49	30
"), header=TRUE, sep = "\t")

# Rename the relevant variables from the data file for ease of understanding the code
V_Hit <- data$N_verbal_correct
V_FA <- data$N_verbal_foil
V_Miss <- data$N_verbal_miss
V_Included <- data$N_verbal_included
V_Wrong <- V_Included - V_Hit
C_Hit <- data$N_control_correct
C_FA <- data$N_control_foil
C_Miss <- data$N_control_miss
C_Included <- data$N_control_included
C_Wrong <- C_Included - C_Hit
Author <- data$Author
Group <- data$Group

###############################################################
### FOREST PLOT WITH META-ANALYSIS ACROSS REPLICATION STUDIES
###############################################################

### fixed-effects model meta-analysis that includes all replications, Mturk, and original
res <- rma(measure="RD", ai=V_Hit, bi=V_Wrong, ci=C_Hit, di=C_Wrong, data=data, slab=paste(Author), method="FE")

### Sets the default font size and aligns left
op <- par(cex=.75, font=4)

### decrease margins so the full space is used and set the font size for the forest plot
par(mar=c(4,4,1,2))
par(cex=1, font=1)

### Create the forest plot. 
### Rows specify the rows in which the subsets of studies appear.
### addfit=false eliminates the meta-analytic result for now. We'll recalculate it below
### in order to exclude the original data and mTurk replication.
forest(res, xlim=c(-3,2), at=c(-.60, -.40, -.20, 0, .20), 
       addfit=FALSE, atransf=FALSE,
       rows=c(23:0), ylim=c(-1, 26), cex=1.5,
       psize=1, pch=c(1, rep(15, 23)), 
       xlab="Verbal Overshadowing Effect [95% CI]", mlab="Random Effects Model")

#used additional parameter 'order=order(-res$vi),' to re-order in increasing levels of precision

### switch to bold, bigger font for headers and then add the headers
par(font=2, cex=1.5)
#text(-3, 25, "Study", pos=4)
#text(2, 25, "Difference [95% CI]", pos=2)
abline(h=-.75)



### Create a subset of the data that excludes The Schooler data and renumber it
repdata <- data[2:24,]
rownames(repdata) <- NULL

### run a meta-analysis on just the replication studies
repres <- rma(measure="RD", ai=repdata$N_verbal_correct, bi=(repdata$N_verbal_included - repdata$N_verbal_correct), ci=repdata$N_control_correct, di=(repdata$N_control_included - repdata$N_control_correct), data=repdata, method="FE")

### add a polygon to the Forest plot showing the meta-analytic effect of the replication studies
addpoly(repres, atransf=FALSE, row=-1.3, cex=1, mlab="")
par(op, cex=1.25, font=3) #italic
text(-2.88, -1.3, "Meta-analytic estimate of replications", pos=4)

### set font size and format back to default back to the original settings
par(op)


### report the meta-analysis results
repres

dev.off()