# Projektaufgaben ACTC
#
# Lade notwendige Pakete
install.packages("tidyr")
library(tidyr)
library(ggplot2)
library(dplyr)

# Lade Daten
load("wetterDT.Rda")
load("umsatzDT.Rda")
load("kiwoDT.Rda")
load("feiertageHS.Rda")
load("wettercodes.Rda")

# Infos zu Daten
# Warengruppen: 
# 1 = Brot, 2 = Brötchen 3 = Croissant
# 4 = Konditorei, 5 = Kuchen, 6 = Saisonbrot
# Wetterdaten:
# Mittlerer Bewölkungsgrad am Tag (0 = min, 8 = max)
# MIttlere Temperatur in C
# Mittlere Windgeschwindigkeit in m/s
# Wettercode (http://www.seewetter-kiel.de/seewetter/daten_symbole.htm)
# und in der Datei wettercodes.Rda

# Variablen zuweisen (ggf. überflüssig)
pj_wetter <- wetterDT
pj_kiwo <- kiwoDT
pj_umsatz <- umsatzDT
pj_feier <- feiertageSH
pj_wettercodes <- wettercodes

# Erste Betrachtung der Daten
hist(pj_wetter$Wettercode)
summary(pj_wetter)
summary(pj_kiwo)
summary(pj_umsatz)
summary(pj_feier)

# Wetterdaten aufbereiten - Wettercode
# Verteilung betrachten
# Als Histogramm
ggplot(pj_wetter, aes(x = as.factor(Wettercode))) + geom_histogram(stat = "count")

# --- NEBENAUFGABE START ---
# Analysieren, welche Wettercodes in welcher Häufigkeit auftreten
# damit diese zu weniger Klassen zusammengefasst werden können

# Als Dateframe (absolute Anzahl pro Klasse)
pj_wcode <- pj_wetter %>%
  group_by(Wettercode) %>%
  summarise(n = n()) 

# Die Spalten umbenennen
names(pj_wcode) <- c("Code", "Anzahl")

# Wettercodes und Verteilung zusammenfügen
wcode_freq <- merge(pj_wettercodes, pj_wcode, by = "Code")

# An dieser Stelle überlegen, wie die Codes mit geringer Verteilung
# sinnvoll zu größeren Einheiten zusammengefasst werden können.
# Wie kann die in R umgesetzt werden, es müssen einzelne Codes durch
# einen anderen Wert ersetzt werden

# --- NEBENAUFGABE ENDE ---

# --- Wettercodes zusammenfassen ---
# Zunächst eine neue Variable (Spalte) im df pj_wetter anlegen und mit dem bestehenden Code füllen
pj_wetter$Wettercode_neu <- pj_wetter$Wettercode

# Jetzt einzelne Codes ersetzen, z.B. um allgemeinen Schneefall abzubilden
pj_wetter$Wettercode_neu[pj_wetter$Wettercode_neu == 69|
                           pj_wetter$Wettercode_neu == 72|
                           pj_wetter$Wettercode_neu == 73|
                           pj_wetter$Wettercode_neu == 75] <- paste("Schneefall")


#Niederschlag/Nebel/Gewitter zuende
NiederschlagEnde <- c(20, 21, 22, 25, 26, 28, 29)
pj_wetter$Wettercode_neu[pj_wetter$Wettercode %in% NiederschlagEnde] <-
  paste("Niederschlag/Nebel/Gewitter Ende")

#Nebel
Nebel <- c(43, 45, 47, 49)
pj_wetter$Wettercode_neu[pj_wetter$Wettercode %in% Nebel] <- paste("Nebel")

#Sprühregen
Sprühregen <- c(51, 53, 55, 58)
pj_wetter$Wettercode_neu[pj_wetter$Wettercode %in% Sprühregen] <- paste("Sprühregen")

#Regen
Regen <- c(60, 61, 63, 65, 68, 69)
pj_wetter$Wettercode_neu[pj_wetter$Wettercode %in% Regen] <- paste("Regen")

#Schauer
Schauer <- c(80, 81, 85)
pj_wetter$Wettercode_neu[pj_wetter$Wettercode %in% Schauer] <- paste("Schauer")
  
#Gewitter                         
Gewitter <- c(91, 95, 13, 17)
pj_wetter$Wettercode_neu[pj_wetter$Wettercode %in% Gewitter] <- paste("Gewitter")


# --- Umsatz-DF optimieren und Daten zusammenstellen ---
# Aus Long-Format ein Wide-Format machen
pj_umsatz_wide <- spread(pj_umsatz, Warengruppe, Umsatz)
summary(pj_umsatz_wide)

# Wochentag hinzufügen (in neuer Spalte von pj_umsatz)
pj_umsatz_wide$Wochentag <- weekdays(pj_umsatz_wide$Datum)

# Merge erstellt automatisch die Schnittmenge
pj_umsatz_wetter <- merge(pj_umsatz_wide, pj_wetter, by="Datum")

# Der Zusatz all.x = TRUE sorgt dafür, dass keine Zeilen weggelöscht werden
pj_um_we_ki <- merge(pj_umsatz_wetter, pj_kiwo, by="Datum", all.x = TRUE)
summary(pj_um_we_ki)

# Jetzt alle weiteren Datensätze hinzufügen, z.B. Feiertage etc.
# ...

