* Encoding: windows-1252.
***********************************  Study 1 Analyses ***********************************.
***** Recode & Compute.
Compute 	J1wpm =	58	/tJ1*60.
Compute 	J2wpm =	115	/tJ2*60.
Compute 	J3wpm =	114	/tJ3*60.
Compute 	J4wpm =	125	/tJ4*60.
Compute 	J5wpm =	92	/tJ5*60.
Compute 	J6wpm =	63	/tJ6*60.
EXE.
COUNT IERptJ=J1wpm J2wpm J3wpm J4wpm J5wpm J6wpm (676 thru Highest).
EXECUTE.
VARIABLE LABELS IERptJ "IER based on count of fast Page Time on moral Judgment items".
Freq IERptJ.

***** IER scale per Huang, Bowling, Liu & Li (2014, JBP).
RECODE IER1 (1=0)(2=0)(3 thru 5=1) INTO IER1cut.
RECODE IER2 (1=0)(2=0)(3 thru 5=1) INTO IER2cut.
RECODE IER3r (1=1)(2=1)(3=1)(4 thru 5=0) INTO IER3cut.
RECODE IER4 (1=0)(2=0)(3 thru 5=1) INTO IER4cut.
RECODE IER5 (1=0)(2=0)(3 thru 5=1) INTO IER5cut.
EXE.
RELIABILITY
  /VARIABLES=IER1cut IER2cut IER3cut IER4cut IER5cut
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE
  /SUMMARY=TOTAL.

Compute IERcuts = mean(IER1cut to IER5cut).
EXE.
VARIABLE LABELS IERcuts "IER scale score per Huang, Bowling, Liu, & Li (2014) approach".
Freq IERcuts.

Corr IERptJ IERcuts.

***** Final sample after excluding rapid IER and QC.suspect.
Compute S1Cases = 1.
IF IERptJ >=2 S1Cases = 0.
IF QC.suspect = 1 S1Cases = 0.
EXE.

***** Descriptives.
Filter by S1Cases.
Freq Cond.
Desc Age Male.
Freq white black asian hispanic nativeam.

***** Reliability of Composite rating.
RELIABILITY
  /VARIABLES=J1 J2 J3 J4 J5 J6
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE
  /SUMMARY=TOTAL MEANS.
Compute Js = mean(J1, J2, J3, J4, J5, J6).
EXE.

***** Overall Effect of Cleanliness, replicating Johnson et al., 2014 and Lee.
T-TEST GROUPS=Cond(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=Js J1 J2 J3 J4 J5 J6
  /CRITERIA=CI(.95).

***** Emotion as DV.
T-TEST GROUPS=Cond(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=emo.relaxed emo.angry emo.happy emo.sad emo.afraid emo.depressed emo.disgusted emo.upset 
    emo.confused
  /CRITERIA=CI(.95).

*** Median split on Duration.
Freq Duration.
IF Duration <=811 ResEff = 0.
IF Duration > 811 ResEff = 1.
EXE.
Freq ResEff.

***** Effect of Cleanliness at low ResEff.
SORT CASES  BY ResEff.
SPLIT FILE SEPARATE BY ResEff.
T-TEST GROUPS=Cond(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=Js J1 J2 J3 J4 J5 J6 
  /CRITERIA=CI(.95).
SPLIT FILE OFF.

********** 2R Using Duration as continuous moderator.
DESCRIPTIVES VARIABLES=Duration
  /STATISTICS=MEAN STDDEV KURTOSIS SKEWNESS.
Compute gcDuration = Duration - 882.3879.
Compute DurationxCond = gcDuration * Cond.
EXE.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Js
  /METHOD=ENTER Cond gcDuration
  /METHOD=ENTER DurationxCond.

********** 1R Using Duration as dich moderator.
UNIANOVA Js BY Cond ResEff
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(Cond*ResEff)
  /PRINT=ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN= ResEff Cond Cond*ResEff
  /emmeans = tables (Cond*ResEff) compare (Cond).

*** 1R explored but not reported: Extreme group on Duration, lowest 33%.
IF  S1Cases = 1 and Duration <=714 ResEffz = 0.
IF  S1Cases = 1 and Duration >=917 ResEffz = 1.
EXE.
Freq ResEffz.


********* Supplementary Analysis based on more stringent cutoffs for IER cases. 
IF IERptJ = 0 and IERCuts < .5 and QC.suspect = 0 S1Stringent = 1.
EXE.
Filter by S1Stringent.
Freq cond.

***** Supp: Overall Effect of Cleanliness, replicating Johnson et al., 2014 and Lee.
T-TEST GROUPS=Cond(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=Js J1 J2 J3 J4 J5 J6
  /CRITERIA=CI(.95).

Freq Duration.
IF Duration <=827 ResEffsupp = 0.
IF Duration > 827 ResEffsupp = 1.
EXE.
Freq ResEffsupp.

***** Supp: Effect of Cleanliness at low ResEff.
SORT CASES  BY ResEffsupp.
SPLIT FILE SEPARATE BY ResEffsupp.
T-TEST GROUPS=Cond(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=Js J1 J2 J3 J4 J5 J6 
  /CRITERIA=CI(.95).
SPLIT FILE OFF.

