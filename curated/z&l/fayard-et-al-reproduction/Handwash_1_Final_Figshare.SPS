CROSSTABS
  /TABLES=Cond  BY GiftChoice
  /FORMAT= AVALUE TABLES
  /STATISTIC=CHISQ
  /CELLS= COUNT
  /COUNT ROUND CELL
  /METHOD=MC CIN(99) SAMPLES(10000).
