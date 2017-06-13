GET DATA  /TYPE = TXT
 /FILE = 'C:\Users\Etienne\Google Drive\Curate Science\website\science-commons\c
   urated\z&l\earp-et-al-reproductions\Earp-et-al-Study-1.csv'
 /DELCASE = LINE
 /DELIMITERS = ","
 /ARRANGEMENT = DELIMITED
 /FIRSTCASE = 2
 /IMPORTCASE = ALL
 /VARIABLES =
 ParticipNumber F2.1
 Time F1.0
 Condition F1.0
 PostDesire F1.0
 PostPay F3.2
 DoveDesire F1.0
 DovePay F4.2
 ColgateDesire F1.0
 ColgatePay F3.2
 InnocentDesire F1.0
 InnocentPay F4.2
 EnergizeDesire F2.1
 EnergizePay F4.2
 SonyCDDesire F1.0
 SonyCDPay F4.2
 WindexDesire F1.0
 WindexPay F3.2
 DettollDesire F1.0
 DettollPay F3.2
 SnickersDesire F1.0
 SnickersPay F3.2
 SurfDesire F1.0
 SurfPay F3.2
 CleanseDesire F3.2
 CleansePay F5.2
 ControlDesirability F3.2
 Controlpay F6.2
 .
CACHE.
EXECUTE.
T-TEST
  GROUPS = Condition(1 2)
  /MISSING = ANALYSIS
  /VARIABLES = CleanseDesire
  /CRITERIA = CI(.95) .
