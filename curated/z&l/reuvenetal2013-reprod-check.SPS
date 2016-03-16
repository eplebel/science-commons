compute myFilter=(clinic=2).
filter by myFilter.
execute.

T-TEST
  GROUPS = magavon(1 2)
  /MISSING = ANALYSIS
  /VARIABLES = willingness
  /CRITERIA = CI(.95) .

do if (willingness =1).
compute NoHelpVsHelp=1.
else .
compute NoHelpVsHelp=2.
end if.
execute.

CROSSTABS
  /TABLES=NoHelpVsHelp  BY magavon
  /FORMAT= AVALUE TABLES
  /STATISTIC=CHISQ
  /CELLS= COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL .



compute myFilter=(clinic=1).
filter by myFilter.
execute.
T-TEST
  GROUPS = magavon(1 2)
  /MISSING = ANALYSIS
  /VARIABLES = willingness
  /CRITERIA = CI(.95) .

CROSSTABS
  /TABLES=NoHelpVsHelp  BY magavon
  /FORMAT= AVALUE TABLES
  /STATISTIC=CHISQ
  /CELLS= COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL .


use all.

UNIANOVA
  willingness  BY clinic magavon
  /METHOD = SSTYPE(3)
  /INTERCEPT = INCLUDE
  /EMMEANS = TABLES(clinic) COMPARE ADJ(SIDAK)
  /EMMEANS = TABLES(magavon) COMPARE ADJ(SIDAK)
  /EMMEANS = TABLES(clinic*magavon)
  /PRINT = DESCRIPTIVE ETASQ HOMOGENEITY
  /CRITERIA = ALPHA(.05)
  /DESIGN = clinic magavon clinic*magavon .


CROSSTABS
  /TABLES=NoHelpVsHelp  BY clinic  BY magavon
  /FORMAT= AVALUE TABLES
  /STATISTIC=CHISQ
  /CELLS= COUNT EXPECTED ROW COLUMN
  /COUNT ROUND CELL .
