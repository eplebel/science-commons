GET DATA  /TYPE = TXT
 /FILE = 'C:\Users\Etienne\Google Drive\Curate Science\website\science-commons\curated\bem2011\galak-et-al'+
 '-reproductions\CorrectingThePastData-02.csv'
 /DELCASE = LINE
 /DELIMITERS = ","
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 experiment F1.0
 condition_type A2
 participantid F2.1
 sensationseeking F3.2
 bored F1.0
 enjoysamemovies_reverseCoded F1.0
 practice_hits F2.1
 control_hits F2.1
 total F2.1
 practice_minus_control F1.0
 practice_plus_control F2.1
 DR_score F3.2
 DR_score_perc F5.2
 V15 F1.0
 .
CACHE.
EXECUTE.
SAVE OUTFILE='C:\Users\Etienne\Google Drive\Curate Science\website\science-commo
   ns\curated\bem2011\galak-et-al-reproductions\CorrectingThePastData.sav'
 /COMPRESSED.


compute myFilter=(experiment=1).
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

compute myFilter=(experiment=2).
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

compute myFilter=(experiment=3).
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

compute myFilter=(experiment=4).
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

compute myFilter=(experiment=5).
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

compute myFilter=(experiment=6 AND condition_type='te').
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

compute myFilter=(experiment=7).
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .

***Reproduction of Study 6's positive control (i.e., traditional practice effect)***.
compute myFilter=(experiment=6 AND condition_type='pr').
filter by myFilter.
execute.
T-TEST
  /TESTVAL = 0
  /MISSING = ANALYSIS
  /VARIABLES = DR_score_perc
  /CRITERIA = CI(.95) .
