** This is the Qualtrics data file. I first removed one participant in which was stated 'test'. Then, I selected participants that completely filled in the SJS questionnaire. 

FREQUENCIES VARIABLES=Item25
  /ORDER=ANALYSIS.

USE ALL.
COMPUTE filter_$=(Item25>0).
VARIABLE LABELS filter_$ 'Item25>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.



** Below are first the items that are relevant. These are the eight dilemmas that are measured to probe participants' sexual and emotional jealousy. 
** There were only 18 men in this dataset and 69 women. 

SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.



SPLIT FILE OFF.
COMPUTE SJS=Mean(item3, item4, item7, item10, item13, item18, item21, item22). 
EXECUTE.

** Below gives also the results. Frequencies are included below to make it a meaningful comparison and have been drawn from the analysis above. Odds ratios were calculated here: http://www.vassarstats.net/odds2x2.html. 
** Cohen's d are calculated here: http://www.polyu.edu.hk/mm/effectsizefaqs/calculator/calculator.html. 
** Item 3: Which would upset or distress you more?
** (A) Imagining your partner enjoying passionate sexual intercourse with that other person.
** (B) Imagining your partner forming a deep emotional attachment to that other person.
** Item 3: sex, men: 77.8% , women: 13.0%
** Item 3: emotion, men: 22.2%, women: 87%
** p < .001 .odds ratio = 23.333, Chi Square = 30.761 Cohen's d = 1.4791. 

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
** Item 4: sex, men: 77.8% , women: 42%
** Item 4, emotion, men: 22.2%, women: 58%
** p = .008, odds ratio = 4.8276, Chi Square = 7.299 Cohen's d = 0.5916.

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
** Item 7: sex, men: 77.8%, women: 40.6%
** Item 7: emotion, men: 22.2%, women: 59.4%
** p = .007 .odds ratio = 5.125, Chi Square = 7.911, Cohen's d = 0.6325. 

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
** Item 10: sex: 66.7 , women: 43.5%
** Item 10: emotion, men: 33.3  women: 56.5%
** p = .112 .odds ratio = 2.6, Chi Square = 3.074, Cohen's d = 0.3827.

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
** Item 13, sex, men: 72.2  , women: 49.3%
** Item 13, emotion, men: 27.8, women: 50.7%
** p = .112 .odds ratio = 18.3077, Chi Square = 3.026 Cohen's d = 0.3796.

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
** Item 18, sex, men: 67.7 , women: 50.7%
** Item 18, emotion, men: 33.3, women: 49.3%
** p = .292, odds ratio = 1.9429, Chi Square = 1.461, Cohen's d = 0.3796.

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
** Item 21, sex, men: 77.8 , women: 36.2%
** Item 21, emotion, men: 22.2, women: 63.8%
** p = .003, .odds ratio = 6.16, Chi Square = 9.963, Cohen's d = 0.7192.

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
** Item 22: sex, men: 44.4  , women: 8.7%
** Item 22: emotion, men: 55.6, women: 91.3%
** p = .001, .odds ratio = 8.4, Chi Square = 13.512, Cohen's d = 0.8576. 

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item22 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.


** Then, an average score is created for these eight dilemmas. 

SPLIT FILE OFF.
COMPUTE SJS=Mean(item3, item4, item7, item10, item13, item18, item21, item22). 
EXECUTE.

** In order to investigate whether the overall score would hold, we also conducted a simple t-test.
** Variances were equal (p = .397). The differences between groups were significant, p < .001. 

USE ALL.
COMPUTE filter_$=(Item25>0).
VARIABLE LABELS filter_$ 'Item25>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


T-TEST GROUPS=Gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=SJS
  /CRITERIA=CI(.95).


DESCRIPTIVES VARIABLES=age
  /STATISTICS=MEAN STDDEV MIN MAX.

