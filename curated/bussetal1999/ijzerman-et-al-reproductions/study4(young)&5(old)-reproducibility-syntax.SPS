
USE ALL.
COMPUTE filter_$=(Item22>0&age_young>0).
VARIABLE LABELS filter_$ 'Item22>0&age_young>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
T-TEST GROUPS=Gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=SJS
  /CRITERIA=CI(.95).



USE ALL.
COMPUTE filter_$=(Item22>0&age_old>0).
VARIABLE LABELS filter_$ 'Item22>0&age_old>0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

T-TEST GROUPS=Gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=SJS
  /CRITERIA=CI(.95).


