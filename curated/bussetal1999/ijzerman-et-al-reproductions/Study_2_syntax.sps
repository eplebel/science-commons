** Below are first the items that are relevant. These are the eight dilemmas that are measured to probe participants' sexual and emotional jealousy. 
** Subsequently, the frequencies are provided per dilemma. I first split the file by gender. This way, percentages can be seen as to which is found more distressing (the focus is on sexual jealousy in the paper). In Study 1, for 
** one participant, gender was missing. This person was thus (obviously) ommitted from the analyses. 

SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.

** Below gives also the results. Frequencies are included below to make it a meaningful comparison and have been drawn from the analysis above. Odds ratios were calculated here: http://www.vassarstats.net/odds2x2.html. 
** Cohen's d are calculated here: http://www.polyu.edu.hk/mm/effectsizefaqs/calculator/calculator.html. 
** Item 3: Which would upset or distress you more?
** (A) Imagining your partner enjoying passionate sexual intercourse with that other person.
** (B) Imagining your partner forming a deep emotional attachment to that other person.
** Item 3: sex, men: 58.9%, women: 46.8%
** Item 3: emotion, men: 40.2% (missing 1), women: 53.2%
** p = .074.odds ratio = 1.6649. Chi Square = 3.192, Cohen's d = .25.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item3 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Item 4: Which action would be more difficult for you to forgive?
** (A) Your partner has passionate sexual intercourse with that other person.
** (B) Your partner becomes deeply emotionally attached to that other person.
** Item 4: sex, men:  69.2% , women: 58.5%
** Item 4, emotion, men: 30.8%, women: 40.4% (1 missing)
** p = .140, odds ratio = 1.5493, Chi Square = 2.181, Cohen's d = .21.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item4 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Item 7 : Which aspect of your partner?s involvement would be more likely to lead you to break-up 		with your partner?
** (A) Your partner?s sexual intercourse with that other person.
** (B) Your partner?s emotional attachment to that other person.
** Item 7: sex, men: 62.5%, women: 58.5%
** Item 7: emotion, men: 36.4% (1 missing), women: 41.5%
** p = .562, odds ratio = 1.2182, Chi Square = .462, Cohen's d = .10.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item7 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Item 10. For which action would you be more likely to break-up with your partner?
** (A) Your partner has passionate sexual intercourse with that other person.
** (B) Your partner becomes deeply emotionally attached to that other person.
** Item 10: sex, 61.7%, women: 48.9%
** Item 10: emotion, men: 38.3%, women: 51.1%
** p = .088, odds ratio = 1.6797, Chi Square = 3.295, Cohen's = .26.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item10 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

** Item 13. Which action would be more difficult for you to forgive?
** (A) Your partner has sexual intercourse with the other person, but you are certain that your partner has 	not become emotionally attached to that other person.
** (B) Your partner becomes emotionally attached to the other person, but you are certain that your 	partner has not had sexual intercourse with that other person.
** Item 13, sex, men: 65.4% , women: 62.8%
** Item 13, emotion, men: 32.7% (2 missing variables), women: 37.2%
** p = .331, odds ratio = 1.1864, chi square = .331, Cohen's d = .15.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item13 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Item 18. For which action would you be more likely to break-up with your partner?
** (A) Your partner has sexual intercourse with the other person, but you are certain that your partner has 	not become emotionally attached to that other person.
** (B) Your partner becomes emotionally attached to the other person, but you are certain that your 	partner has not had sexual intercourse with that other person.
** Item 18, sex, 66.4%, women:59.6%
** Item 18, emotion, men: 32.7% (1 item missing), women: 40.4%
** p = .305, odds ratio = 1.3765, chi square = 1.179, Cohen's d = .15. 

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item18 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Item 21. Which aspect of your partner?s involvement would be more difficult for you to forgive?
** (A) Your partner?s sexual intercourse with that other person.
** (B) Your partner?s emotional attachment to that other person.
** Item 21, sex, men: 71,0%, women: 61.7%
** Item 21, emotion, men: 29, women: 38.3%
** p = .179, odds ratio = 1.5217, chi square = 1.958, Cohen's d = .20. 

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item21 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Item 22. Which would upset or distress you more?
** (A) Imagining your partner trying different sexual positions with that other person.
** (B) Imagining your partner falling in love with that other person.
** Item 22: sex, men: 41.1% , women: 22.3%
** Item 22: emotion, men: 58.9%, women: 75.5% (2 missing)
** p = .007, odds ratio = 2.3613 , chi square = 7.528, Cohen's d = .40. 

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item22 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Then, an average score is created for these eight dilemmas. In the paper, this is referred to as SDS. It is SJS here, after the original paper. 

SPLIT FILE OFF.
COMPUTE SJS=Mean(item3, item4, item7, item10, item13, item18, item21, item22). 
EXECUTE.

** In order to investigate whether the overall score would hold, we also conducted a simple t-test.
** Variances in the two group were not equal (p = .013), but the effect was still significant (p = .050, df = 186.569)

SPLIT FILE OFF.
T-TEST GROUPS=Gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=SJS
  /CRITERIA=CI(.95).

DESCRIPTIVES VARIABLES=SOI_avg
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

*** In order to calculate regressions, below the interaction term is calculated between SOI and gender. 

compute io_gender_soi=gender*zsoi_avg.
Execute. 

*** In order to explore the potential moderating effects of SOI, we regress onto gender and the standardized score of SOI. There is a significant effect of SOI onto SJS (p = .012) but a ns effect of gender onto SJS (.322)

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER ZSOI_avg Gender
  /METHOD=ENTER io_gender_soi.

*** Once including the standardized score of SOI, there is no longer an effect of gender. This suggests mediation. 
*** I therefore also checked a regression of gender onto SJS (basically replicating the t-test()

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER Gender.

*** separately including SOI, without the interaction (in order to calculate full mediation). B = -.075, SE = .022. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS 
  /METHOD=ENTER ZSOI_avg.

** Finally, checking for the effect of gender onto SOI (obviously, there can not be an effect of SOI onto gender). There is a strong effect (p < .001). B = =.907, SE -= .129. Sobel Test calculation (via 
** http://www.danielsoper.com/statcalc3/calc.aspx?id=31) indicates that there is full mediation, Sobel's Z = 3.068, p = .002. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT ZSOI_avg 
  /METHOD=ENTER gender.


*** Also tried it for age. We first standardized age again below to fit it into the regression. 

FILTER OFF.
USE ALL.
EXECUTE.

DESCRIPTIVES VARIABLES=Age
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

*** We then computed the interaction term. We also compute the interaction term to compare with SOI. We also checked the range of ages (17-32). 

compute io_age_gender = zage*gender.
Execute. 

compute io_age_soi=zsoi_avg*zage. 
Execute.

compute io_age_soi_gender = zage*gender*zsoi_avg.
Execute. 

FREQUENCIES VARIABLES=Age
  /ORDER=ANALYSIS.


*** First we ran the regressions without soi, including only age and gender. When running this, the effect of gender remains, but also an effect of age and in an interaction effect between age and gender appears. 
*** Older people in general find the emotional attachment worse. This is a unique effect of age, controlled for gender. 

SPLIT FILE OFF.
IF (gender=1) genderre = -1.
IF (gender=2) genderre = 1.
EXECUTE.

compute io_genderre_zage = genderre*zage.
Execute. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER genderre ZAge
  /METHOD=ENTER io_genderre_zage.

*** Now also including SOI. The age/gender interaction does not dissappear through SOI, so the effect obtained above is not a mediation through SOI. There is also no moderation of SOI. However, when excluding 
** gender from the analysis, the effect of age*soi appears. There may be a moderated mediation. Given that this is at an exploratory stage, the moderated mediation will be analyzed in a follow up study (for example, the 
** effect of the interaction term age*soi is at .112, and for a moderated mediation, the study is insufficiently powered).  

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER Gender ZAge ZSOI_avg
  /METHOD=ENTER io_age_gender io_age_soi io_gender_soi
  /METHOD=ENTER io_age_soi_gender.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER  ZAge ZSOI_avg
  /METHOD=ENTER io_age_soi.

** Dummycode gender to use females as reference group. There was no significant effect (p = .237)


SPLIT FILE OFF.
IF (gender=1) genderm = 0.
IF (gender=2) genderm = 1.
EXECUTE.

compute io_age_genderm = zage*genderm.
Execute. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER Genderm ZAge
  /METHOD=ENTER io_age_genderm.

** Dummycode gender to use males as reference group


SPLIT FILE OFF.

IF (gender=1) genderf = -1.
IF (gender=2) genderf = 0.
EXECUTE.

compute io_age_genderf = zage*genderf.
Execute. 

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT SJS
  /METHOD=ENTER Genderf ZAge
  /METHOD=ENTER io_age_genderf.

*** I also checked for the gender effect at low and high age. There is a significant gender effect for the young men and women (.004), but not so for the older ones in our sample (.660). 

COMPUTE ZAgeHigh = Zage-1.
COMPUTE gender.ZAgeHigh = gender*Zagehigh.
Execute.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
	/DEPENDENT = SJS
	/METHOD = ENTER gender ZageHigh
	/METHOD = ENTER gender.ZageHigh.

COMPUTE ZAgeLow = Zage+1.
COMPUTE gender.ZAgeLow = gender*Zagelow.
Execute.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE ZPP
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
	/DEPENDENT = SJS
	/METHOD = ENTER gender Zagelow
	/METHOD = ENTER gender.Zagelow.

