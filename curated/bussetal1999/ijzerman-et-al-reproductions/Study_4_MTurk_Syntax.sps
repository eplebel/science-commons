** Below are first the items that are relevant. These are the eight dilemmas that are measured to probe participants' sexual and emotional jealousy. 
** There were 770 men in this dataset and 792 women. Throughout the study, participants dropped out. We decided to only use those that answered the entire 
** questionnaire. First we created a selection criterion for this (basically only including those that answered the last item, Item22). This means we have 748 males in the sample,
** and 775 females. 


FREQUENCIES VARIABLES=Item22
  /ORDER=ANALYSIS.

USE ALL.
COMPUTE filter_$=(Item22>0).
VARIABLE LABELS filter_$ 'Item22>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.




DESCRIPTIVES VARIABLES=age
  /STATISTICS=MEAN STDDEV MIN MAX.

SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.


** Compute avg SJS Score

SPLIT FILE OFF.
COMPUTE SJS=Mean(item3, item4, item7, item10, item13, item18, item21, item22). 
EXECUTE.

** Below gives also the results. Frequencies are included below to make it a meaningful comparison and have been drawn from the analysis above. Odds ratios were calculated here: http://www.vassarstats.net/odds2x2.html. 
** Cohen's d are calculated here: http://www.polyu.edu.hk/mm/effectsizefaqs/calculator/calculator.html. I am writing the remainder of the results directly in the paper. 

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item3 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item4 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item7 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item10 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item13 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item18 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item21 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item22 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

*** We will now only look for the younger sample (18-30). Exactly the same as above. 

RECODE age (18 thru 30=Copy) (ELSE=SYSMIS) INTO age_young.
EXECUTE.

USE ALL.
COMPUTE filter_$=(Item22>0&age_young>0).
VARIABLE LABELS filter_$ 'Item22>0&age_young>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item3 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item4 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item7 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item10 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item13 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item18 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item21 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item22 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

DESCRIPTIVES VARIABLES=age
  /STATISTICS=MEAN STDDEV MIN MAX.

** Now the older group (50-70)

RECODE age (50 thru 70=Copy) (ELSE=SYSMIS) INTO age_old.
EXECUTE.

USE ALL.
COMPUTE filter_$=(Item22>0&age_old>0).
VARIABLE LABELS filter_$ 'Item22>0&age_old>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SORT CASES  BY Gender.
SPLIT FILE SEPARATE BY Gender.

FREQUENCIES VARIABLES=Item3 Item4 Item7 Item10 Item13 Item18 Item21 Item22
  /ORDER=ANALYSIS.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item3 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item4 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item7 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item10 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item13 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item18 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item21 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

SPLIT FILE OFF.
CROSSTABS
  /TABLES=Item22 BY Gender
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

DESCRIPTIVES VARIABLES=age
  /STATISTICS=MEAN STDDEV MIN MAX.

** Then, an average score is created for these eight dilemmas. 

USE ALL.
COMPUTE filter_$=(Item22>0).
VARIABLE LABELS filter_$ 'Item22>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SPLIT FILE OFF.
COMPUTE SJS=Mean(item3, item4, item7, item10, item13, item18, item21, item22). 
EXECUTE.

** In order to investigate whether the overall score would hold, we also conducted a simple t-test.
** Variances were unequal (p = .023). The differences between groups were significant, p < .001. 

T-TEST GROUPS=Gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=SJS
  /CRITERIA=CI(.95).

** Now examine SOI

RECODE Item6SOI (1=9) (2=8) (3=7) (4=6) (5=5) (6=4) (7=3) (8=2) (9=1) INTO Item6SOIrev.
EXECUTE.

RELIABILITY
  /VARIABLES=Item1SOI Item2SOI Item3SOI Item4SOI Item5SOI Item6SOIrev Item7SOI Item8SOI Item9SOI
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.


COMPUTE SOI_avg=Mean(Item1SOI, Item2SOI, Item3SOI, Item4SOI, Item5SOI, Item6SOIrev, Item7SOI, 
    Item8SOI, Item9SOI).
EXECUTE.

DESCRIPTIVES VARIABLES=SOI_avg
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

*** recode age into dichotomous variable (young vs old)

RECODE age_young (0 thru 100=1) INTO age_dicho.
EXECUTE.


RECODE age_old (0 thru 100=2) INTO age_dicho.
EXECUTE.

*** Only analyzing the heterosexuals; full sample. 


USE ALL.
COMPUTE filter_$=(Item22>0&Q60=2).
VARIABLE LABELS filter_$ 'Item22>0Q60=2 (FILTER)'.
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

*** Only analyzing heterosexuals; older folks


USE ALL.
COMPUTE filter_$=(Item22>0&Q60=2&age_dicho=2).
VARIABLE LABELS filter_$ 'Item22>0Q60=2&age_dicho=2 (FILTER)'.
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

*** Only analyzing heterosexuals; younger folk

USE ALL.
COMPUTE filter_$=(Item22>0&Q60=2&age_dicho=1).
VARIABLE LABELS filter_$ 'Item22>0Q60=2&age_dicho=1 (FILTER)'.
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



