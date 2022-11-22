
# Package, mit dem JSON Format in R Format übertragen werden kann
install.packages("jsonlite")
library(jsonlite)
library(tidyverse)


# Feiertage Daten importieren von Website mittels URL
# Jahr und Ländercode können am Ende der URL eingegeben werden 
# Vektor mit den ausgewählten Jahren, für die die Feiertage importiert werden sollen
jahr <- c(2013:2019)

# die Variable feiertageSH soll alle Feiertage des Zeitraums enthalten
# erstmal leeren df erstellen
feiertageSH <- as.data.frame(NULL)

# for loop, um die Feiertage aus allen Jahren herunterzuladen und zusammen in der Variable feiertageSH abzuspeichern
for (i in jahr) {
  feiertageJahr <- fromJSON(paste("https://feiertage-api.de/api/?jahr=", i, "&nur_land=SH", sep = ""))
  feiertage <- do.call(rbind.data.frame, feiertageJahr)
  feiertageSH <- rbind(feiertageSH, feiertage)
}

# Daten bereinigen: 
# Spalte mit feiertag = 1 hinzufügen,
# Spalte mit Feiertagname hinzufügen (könnte vielleicht auch nützlich sein?)
feiertageSH <- feiertageSH %>%
  mutate(feiertag = 1, 
         feiertagName = row.names(feiertageSH)) %>%
  select(datum, feiertagName, feiertag)

# unnötige Spaltennamen entfernen 
rownames(feiertageSH) <- c() 


#Dastensatz abspeichern
save(feiertageSH, file = "feiertageSH.Rda")
