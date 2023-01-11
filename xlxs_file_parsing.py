import pandas as pd
import os

#----- Funktionen -----#
def read_value_from_excel(filename, column, row):
    return pd.read_excel(filename, sheet_name=4, skiprows=row - 1, usecols=column, nrows=1, header=None, names=["Value"]).iloc[0]["Value"]

#----- Programm Ablauf -----#
umsatztFachEinzelHandel = []
jahr, monat = 2013, 7
z = 17

sDir = sorted(os.listdir('Einzelhandel_Umsatz_SH'))

for filename in sDir:
    if filename.startswith("G") and filename.endswith(".xlsx"):
        print(filename)
        umsatztFachEinzelHandel += [(jahr, monat,read_value_from_excel("Einzelhandel_Umsatz_SH/"+filename, "C", z))]
        if monat == 12:
            monat = 1
            jahr += 1
        else:
            monat += 1
        
        if jahr == 2013:
            z = 17
        elif jahr == 2014 and monat == 9:
            z = 15
        elif jahr == 2014 and monat == 10:
            z = 15
        elif jahr == 2015 and (monat == (4 or 5)):
            z = 15
        elif jahr == 2014 and monat < 6:
            z = 15
        elif jahr >= 2014 and monat >= 6:
            z = 16


dataFrameUmsatzt = pd.DataFrame(umsatztFachEinzelHandel, columns =['Jahr', 'Monat', 'Umsatz'])
dataFrameUmsatzt.to_csv("umsatztFachEinzelHandel.csv")