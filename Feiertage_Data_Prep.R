
# Package, mit dem JSON Format in R Format übertragen werden kann
install.packages("jsonlite")
library(jsonlite)
library(tidyverse)


# Feiertage Daten importieren von Website mittels URL
# Jahr und Ländercode können am Ende der URL eingegeben werden 
# Vektor mit den ausgewählten Jahren, für die die Feiertage importiert werden sollen
jahr <- c(2013:2019)

# die Variable feiertageSH enthält alle Feiertage des Zeitraums
feiertageSH <- as.data.frame(NULL)

for (i in jahr) {
  feiertageJahr <- fromJSON(paste("https://feiertage-api.de/api/?jahr=", i, "&nur_land=SH", sep = ""))
  feiertage <- do.call(rbind.data.frame, feiertageJahr)
  feiertageSH <- rbind(feiertageSH, feiertage)
}

# Daten bereinigen: 
# spalte mit feiertag = 1 hinzufügen,
# Spalte mit Feiertagname hinzufügen (könnte vielleicht auch nützlich sein?
feiertageSH <- feiertageSH %>%
  mutate(feiertag = 1, 
         feiertagName = row.names(feiertageSH)) %>%
  select(datum, feiertagName, feiertag)

# unnötige Spaltennamen entfernen 
rownames(feiertageSH) <- c() 


save(feiertageSH, file = "feiertageSH.Rda")
