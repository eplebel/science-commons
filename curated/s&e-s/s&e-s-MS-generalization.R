#RRR1: s&e-s study 4 reps for curation MS (generalization)
library("metafor")

### to save as png file
png(filename="S&E-S-MS-forest-plot-02.png", res=95, width=1200, height=1200, type="cairo")

# Import the data
data <- read.table(textConnection(
 "Lab	Author	Group	Country	Language	N_verbal	N_verbal_excluded	N_verbal_excluded_age	N_verbal_excluded_race	N_verbal_excluded_other	N_verbal_included	N_verbal_correct	N_verbal_foil	N_verbal_miss	N_control	N_control_excluded	N_control_excluded_age	N_control_excluded_race	N_control_excluded_other	N_control_included	N_control_correct	N_control_foil	N_control_miss
1	Schooler & Engstler-Schooler (1990), Study 4	S&E-S STUDY 4	Original	USA	English	37	0	0	0	0	37	18	NA	NA	38	0	0	0	0	38	27	NA	NA
2	Robert B. Michael, Gregory Franco, Mevagh Sanson, Maryanne Garry	ONLINE MTURK - Michael, Franco, Sanson, Garry 	Online	New Zealand	English	313	109	0	0	109	204	112	36	56	313	127	0	0	127	186	91	59	36
3	Victoria K. Alogna, Jamin Halberstadt, Jonathan Jong, Joshua C. Jackson, Cathy Ng	Alogna, Halbertstadt, Jong, Jackson, Ng	Both	New Zealand	English	78	22	0	17	5	56	32	6	18	81	24	0	20	4	57	40	10	7
4	Stacy Birch	Birch	Both	USA	English	69	13	0	13	0	56	37	7	12	71	21	0	21	0	50	33	13	4
5	Angela R. Birt, Philip Aucoin	Birt, Aucoin	Both	Canada	English	53	2	0	2	0	51	17	14	20	52	2	0	2	0	50	18	19	13
6	Maria A. Brandimonte	Brandimonte	Both	Italy	Italian	70	0	0	0	0	70	34	18	18	70	0	0	0	0	70	27	32	11
7	Curt Carlson, Dawn Weatherford, Maria Carlson	Carlson, Weatherford, Carlson	Both	USA	English	84	9	0	0	9	75	32	22	21	79	4	0	0	4	75	42	19	14
8	Kimberly S. Dellapaolera, Brian H. Bornstein	Dellapaolera, Bornstein	Both	USA	English	86	12	0	12	0	74	29	23	22	86	10	0	10	0	76	41	20	15
9	Jean-Francois Delvenne, Charity Brown, Emma Portch, Tara Zaksaite	Delvenne, Brown, Portch, Zaksaite	Both	United Kingdom	English	63	4	0	2	2	59	40	9	10	67	6	0	0	6	61	40	13	8
10	Gerald Echterhoff, René Kopietz	Echterhoff, Kopietz	Both	Germany	German	54	13	10	0	3	41	15	9	17	53	7	4	0	3	46	24	15	7
11	Casey M. Eggleston, Calvin K. Lai, Elizabeth A. Gilbert	Eggleston, Lai, Gilbert	Both	USA	English	93	12	2	0	10	81	40	15	26	78	9	5	1	3	69	39	14	16
12	Daniel L. Greenberg, Marino Mugayar-Baldocchi	Greenberg, Mugayar-Baldocchi	Both	USA	English	59	9	0	9	0	50	24	11	15	60	10	0	10	0	50	28	12	10
13	Andre Kehn, Kimberly Schweitzer, Bradlee W. Gamblin, Kimberly Wiseman, Narina L. Nunez	Kehn, Schweitzer, Gamblin, Wiseman, Nunez	Both	USA	English	73	10	4	6	0	63	33	12	18	75	7	2	5	0	68	39	15	14
14	Chris Koch, Remi Gentry, Jennifer Shaheed, Kelsi Buswell	Koch, Gentry, Shaheed, Buswell	Both	USA	English	54	6	2	4	0	48	26	8	14	54	6	1	5	0	48	22	16	12
15	Nicola Mammarella, Beth Fairfield, Alberto Di Domenico	Mammarella, Fairfield, Di Domenico	Both	Italy	Italian	117	7	2	0	5	110	45	31	34	115	5	0	0	5	110	58	35	17
16	Shannon McCoy, Arielle Rancourt	McCoy, Rancourt	Both	USA	English	75	13	2	11	0	62	26	19	17	73	12	2	10	0	61	35	15	11
17	Abigail A. Mitchell, Marilyn S. Petro	Mitchell, Petro	Both	USA	English	71	9	0	9	0	62	34	11	17	57	6	0	6	0	51	26	9	16
18	Robin Musselman, Michael Colarusso	Musselman, Colarusso	Both	USA	English	65	14	0	14	0	51	12	21	18	59	9	1	8	0	50	20	17	13
19	Christopher R. Poirier, Matthew K. Attaya, Kathleen A. McConnaughy, Jessica E. Pappagianopoulos, Griffin A. Sullivan	Poirer, Attaya, McConnaughy, Pappagianopoulos, Sullivan	Both	USA	English	56	1	0	0	1	55	24	12	19	59	4	0	0	4	55	31	12	12
20	Eva Rubínová, Marek Vranka, Štěpán Bahník	Rubínová, Vranka, Bahník	Both	Czech Republic	Czech	80	12	0	0	12	68	36	17	15	58	8	0	0	8	50	23	18	9
21	Kyle J. Susa, Jessica K. Swanner, Christian A. Meissner	Susa, Swanner, Meissner	Both	USA	English	69	14	0	13	1	55	23	11	21	76	21	0	18	3	55	23	18	14
22	W. Burt Thompson	Thompson	Both	USA	English	66	16	2	11	3	50	28	11	11	65	15	1	14	0	50	21	18	11
23	Joanna Ulatowska, Aleksandra Cislak	Ulatowska, Cislak	Both	Poland	Polish	59	4	0	0	4	55	40	4	11	68	13	2	0	11	55	38	7	10
24	Kimberley A. Wade, Ulrike Körner, Melissa F. Colloff, Melina A. Kunar	Wade, Körner, Colloff, Kunar	Both	United Kingdom	English	60	0	0	0	0	60	34	15	11	60	0	0	0	0	60	39	4	17
25	Simon Chu, John E. Marsh, Faye Skelton	Chu, Marsh, Skelton	Study1	United Kingdom	English	50	0	0	0	0	50	27	7	16	51	0	0	0	0	51	32	6	13
26	John E. Edlund, Austin Lee Nichols	Edlund, Nichols	Study1	USA	English	64	13	5	9	0	51	28	15	8	70	9	1	8	0	61	26	23	12
27	Fiona Gabbert, Tim R. Valentine	Gabbert, Valentine	Study1	United Kingdom	English	83	28	6	22	0	55	34	6	15	83	30	9	21	0	53	31	7	15
28	Fabio P. Leite	Leite	Study1	USA	English	63	11	1	7	3	52	20	21	11	65	15	1	4	10	50	28	17	5
29	Alex H. McIntyre, Stephen R. H. Langton, Peter J. B. Hancock	McIntyre, Langton, Hancock	Study1	United Kingdom	English	54	2	2	0	0	52	37	7	8	57	6	5	1	0	51	37	10	4
30	Robert B. Michael, Gregory Franco, Mevagh Sanson, Maryanne Garry	Michael, Franco, Sanson, Garry	Study1	New Zealand	English	184	97	0	67	30	87	49	20	18	191	93	0	55	38	98	55	30	13
31	Matthew A. Palmer, Aaron Drummond, James D. Sauer, Daniel V. Zuj, Lauren Hall, Liam Satchell, Glenys Holt, Miriam Rainsford	Palmer et al	Study1	USA	English	65	9	4	5	0	56	32	13	11	58	7	6	1	0	51	30	11	10
32	Verkoeijen, P. P. J. L., Bouwmeester, S., Zwaan, R. A.	Verkoeijen, Bouwmeester, Zwaan	Study1	Netherlands	Dutch	56	5	0	1	4	51	26	14	11	59	5	0	5	0	54	30	12	12
33	Christopher A. Was, Dale Hirsch, Rachel Todaro, Connie Romig	Was, Hirsch, Todaro, Romig	Study1	USA	English	71	4	0	4	0	67	36	11	20	71	3	0	3	0	68	38	16	14
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
#Author=as.character(Author)
#data$Author = Author
Group <- data$Group
#VerbalAccuracy <- 100*round(V_Hit/V_Included,3)
#ControlAccuracy <- 100*round(C_Hit/C_Included,3)


###############################################################
### FOREST PLOT WITH META-ANALYSIS ACROSS REPLICATION STUDIES
###############################################################

### random-effects model meta-analysis that includes all replications, Mturk, and original
res.all <- rma(measure="RD", ai=V_Hit, bi=V_Wrong, ci=C_Hit, di=C_Wrong, data=data, slab=paste(Author))
#rep.plot used to order reps in increasing order of precision (to find top 23 most precise - because too many to plot nicely!)
rep.plot <- data[2:33,]
rownames(rep.plot) <- NULL
res.plot <- rma(measure="RD", ai=rep.plot$N_verbal_correct, bi=(rep.plot$N_verbal_included - rep.plot$N_verbal_correct), ci=rep.plot$N_control_correct, di=(rep.plot$N_control_included - rep.plot$N_control_correct), data=rep.plot)

### Sets the default font size and aligns left
op <- par(cex=.75, font=4)
### decrease margins so the full space is used and set the font size for the forest plot
par(mar=c(4,4,1,2))
par(cex=1, font=1)

### Create the forest plot. 
### Rows specify the rows in which the subsets of studies appear.
### addfit=false eliminates the meta-analytic result for now. We'll recalculate it below
### in order to exclude the original data and mTurk replication.
#forest(res.all, xlim=c(-3,2), at=c(-.60, -.40, -.20, 0, .20, .40, .60), 
#       addfit=FALSE, atransf=FALSE,
#       ylim=c(-1, 37), rows=c(34:2),
#       psize=1, pch=c(1, rep(15, 32)), order=c(1,order(-res.plot$vi)+1), #used to find top 23 most precise reps
#       xlab="Verbal Overshadowing Effect", mlab="Random Effects Model")


data.top23 <- read.table(textConnection(
 "Lab	Author	Group	Country	Language	N_verbal	N_verbal_excluded	N_verbal_excluded_age	N_verbal_excluded_race	N_verbal_excluded_other	N_verbal_included	N_verbal_correct	N_verbal_foil	N_verbal_miss	N_control	N_control_excluded	N_control_excluded_age	N_control_excluded_race	N_control_excluded_other	N_control_included	N_control_correct	N_control_foil	N_control_miss
1	Schooler & Engstler-Schooler (1990), Study 4	Schooler & Eng-Schooler (1990) Study 4	Original	USA	English	37	0	0	0	0	37	18	NA	NA	38	0	0	0	0	38	27	NA	NA
2	Robert B. Michael, Gregory Franco, Mevagh Sanson, Maryanne Garry	    Michael et al. (2014, ONLINE) 	Online	New Zealand	English	313	109	0	0	109	204	112	36	56	313	127	0	0	127	186	91	59	36
3	Victoria K. Alogna, Jamin Halberstadt, Jonathan Jong, Joshua C. Jackson, Cathy Ng	    Alogna, Halbertstadt et al. (2014)	Both	New Zealand	English	78	22	0	17	5	56	32	6	18	81	24	0	20	4	57	40	10	7
4	Stacy Birch	    Birch (2014)	Both	USA	English	69	13	0	13	0	56	37	7	12	71	21	0	21	0	50	33	13	4
6	Maria A. Brandimonte	    Brandimonte (2014)	Both	Italy	Italian	70	0	0	0	0	70	34	18	18	70	0	0	0	0	70	27	32	11
7	Curt Carlson, Dawn Weatherford, Maria Carlson	    Carlson, Weatherford et al. (2014)	Both	USA	English	84	9	0	0	9	75	32	22	21	79	4	0	0	4	75	42	19	14
8	Kimberly S. Dellapaolera, Brian H. Bornstein	    Dellapaolera & Bornstein (2014)	Both	USA	English	86	12	0	12	0	74	29	23	22	86	10	0	10	0	76	41	20	15
9	Jean-Francois Delvenne, Charity Brown, Emma Portch, Tara Zaksaite	    Delvenne, Brown et al. (2014)	Both	United Kingdom	English	63	4	0	2	2	59	40	9	10	67	6	0	0	6	61	40	13	8
11	Casey M. Eggleston, Calvin K. Lai, Elizabeth A. Gilbert	    Eggleston, Lai, & Gilbert (2014)	Both	USA	English	93	12	2	0	10	81	40	15	26	78	9	5	1	3	69	39	14	16
13	Andre Kehn, Kimberly Schweitzer, Bradlee W. Gamblin, Kimberly Wiseman, Narina L. Nunez	    Kehn, Schweitzer et al. (2014)	Both	USA	English	73	10	4	6	0	63	33	12	18	75	7	2	5	0	68	39	15	14
15	Nicola Mammarella, Beth Fairfield, Alberto Di Domenico	    Mammarella, Fairfield et al. (2014)	Both	Italy	Italian	117	7	2	0	5	110	45	31	34	115	5	0	0	5	110	58	35	17
16	Shannon McCoy, Arielle Rancourt	    McCoy & Rancourt (2014)	Both	USA	English	75	13	2	11	0	62	26	19	17	73	12	2	10	0	61	35	15	11
17	Abigail A. Mitchell, Marilyn S. Petro	    Mitchell & Petro (2014)	Both	USA	English	71	9	0	9	0	62	34	11	17	57	6	0	6	0	51	26	9	16
18	Robin Musselman, Michael Colarusso	    Musselman & Colarusso (2014)	Both	USA	English	65	14	0	14	0	51	12	21	18	59	9	1	8	0	50	20	17	13
19	Christopher R. Poirier, Matthew K. Attaya, Kathleen A. McConnaughy, Jessica E. Pappagianopoulos, Griffin A. Sullivan	    Poirer, Attaya et al. (2014)	Both	USA	English	56	1	0	0	1	55	24	12	19	59	4	0	0	4	55	31	12	12
20	Eva Rubínová, Marek Vranka, Štěpán Bahník	    Rubínová, Vranka, & Bahník (2014)	Both	Czech Republic	Czech	80	12	0	0	12	68	36	17	15	58	8	0	0	8	50	23	18	9
21	Kyle J. Susa, Jessica K. Swanner, Christian A. Meissner	    Susa, Swanner, & Meissner (2014)	Both	USA	English	69	14	0	13	1	55	23	11	21	76	21	0	18	3	55	23	18	14
23	Joanna Ulatowska, Aleksandra Cislak	    Ulatowska & Cislak (2014)	Both	Poland	Polish	59	4	0	0	4	55	40	4	11	68	13	2	0	11	55	38	7	10
24	Kimberley A. Wade, Ulrike Körner, Melissa F. Colloff, Melina A. Kunar	    Wade, Körner et al. (2014)	Both	United Kingdom	English	60	0	0	0	0	60	34	15	11	60	0	0	0	0	60	39	4	17
26	John E. Edlund, Austin Lee Nichols	    Edlund & Nichols (2014)	Study1	USA	English	64	13	5	9	0	51	28	15	8	70	9	1	8	0	61	26	23	12
27	Fiona Gabbert, Tim R. Valentine	    Gabbert & Valentine (2014)	Study1	United Kingdom	English	83	28	6	22	0	55	34	6	15	83	30	9	21	0	53	31	7	15
29	Alex H. McIntyre, Stephen R. H. Langton, Peter J. B. Hancock	    McIntyre, Langton, & Hancock (2014)	Study1	United Kingdom	English	54	2	2	0	0	52	37	7	8	57	6	5	1	0	51	37	10	4
30	Robert B. Michael, Gregory Franco, Mevagh Sanson, Maryanne Garry	    Michael et al. (2014)	Study1	New Zealand	English	184	97	0	67	30	87	49	20	18	191	93	0	55	38	98	55	30	13
33	Christopher A. Was, Dale Hirsch, Rachel Todaro, Connie Romig	    Was, Hirsch et al. (2014)	Study1	USA	English	71	4	0	4	0	67	36	11	20	71	3	0	3	0	68	38	16	14
"), header=TRUE, sep = "\t")

res.top23 <- rma(measure="RD", ai=data.top23$N_verbal_correct, bi=(data.top23$N_verbal_included - data.top23$N_verbal_correct), ci=data.top23$N_control_correct, di=(data.top23$N_control_included - data.top23$N_control_correct), data=data.top23, slab=paste(data.top23$Author))
#rep.plot used to order reps in increasing order of precision (to find top 23 most precise - because too many to plot nicely!)
rep.plot <- data.top23[2:24,]
rownames(rep.plot) <- NULL
res.plot <- rma(measure="RD", ai=rep.plot$N_verbal_correct, bi=(rep.plot$N_verbal_included - rep.plot$N_verbal_correct), ci=rep.plot$N_control_correct, di=(rep.plot$N_control_included - rep.plot$N_control_correct), data=rep.plot)


forest(res.top23, xlim=c(-3,2), at=c(-.60, -.40, -.20, 0, .20, .40), 
       addfit=FALSE, atransf=FALSE,
       ylim=c(-1, 27), rows=c(24, 22:0), cex=1.5,
       psize=1, pch=c(1, rep(15, 23)), order=c(1,order(-res.plot$vi)+1),
       xlab="Verbal Overshadowing Effect [95% CI]", mlab="Random Effects Model")

### switch to bold, bigger font for headers and then add the headers
par(font=2, cex=1.5)
#text(-3, 26, "Study", pos=4)
#text(2, 26, "Difference [95% CI]", pos=2)
#text(-3, c(39, 14), c("Completed Both RRR Studies", "Completed RRR Study 1 Only"), pos=4)
abline(h=-.75)


### Create a subset of the data that excludes The Schooler data and renumber it
repdata <- data[2:33,]
rownames(repdata) <- NULL
### run a meta-analysis on just the replication studies
repres <- rma(measure="RD", ai=repdata$N_verbal_correct, bi=(repdata$N_verbal_included - repdata$N_verbal_correct), ci=repdata$N_control_correct, di=(repdata$N_control_included - repdata$N_control_correct), data=repdata)
### add a polygon to the Forest plot showing the meta-analytic effect of the replication studies
addpoly(repres, atransf=FALSE, row=-1.3, cex=1.0, mlab="")
par(op, cex=1.25, font=3) #italic
text(-2.88, -1.3, "Meta-analytic estimate of replications", pos=4)

### set font size and format back to default back to the original settings
par(op)

### Print the results of the meta-analysis to the console
repres

dev.off()