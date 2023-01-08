# Umsatzdaten Vorbereitung

# lade Daten
load("umsatzDT.Rda")
pj_umsatz <- umsatzDT

## --- Umsatz-DF optimieren und Daten zusammenstellen --- ##

# Aus Long-Format ein Wide-Format machen -> Umsatz für jede Warengruppe als Spalte
pj_umsatz_wide <- spread(pj_umsatz, Warengruppe, Umsatz)

# Wochentag hinzufügen (in neuer Spalte von pj_umsatz)
pj_umsatz_wide$Wochentag <- weekdays(pj_umsatz_wide$Datum)


# Warengruppen Spalten benennen und 
# auf fehlende Werte überprüfen
# Saisonbrot fehlende Werte (NA) durch 0 ersetzen, da es an den Tagen keinen Umsatz durch Saisonbrot gab
pj_umsatz_wide <- pj_umsatz_wide %>%
  rename("Brot" = `1`,
         "Brötchen" = `2`,
         "Croissant" = `3`,
         "Konditorei" = `4`, 
         "Kuchen" = `5`,
         "Saisonbrot" = `6`) %>%
  mutate_at(vars(Saisonbrot), ~replace(., is.na(.), 0))

# auf NA überprüfen
pj_umsatz_na <- pj_umsatz_wide %>%
  aggr(combined=TRUE, numbers=TRUE)

# Imputation Konditorei Umsatz. 
# Donor-based imputation nach Sortierung (Datum) und Domäne (Wochentag) 
pj_umsatz_wide <- pj_umsatz_wide %>%  
  hotdeck(variable = "Konditorei",
          ord_var = "Datum",
          domain_var = "Wochentag")

# auf NA überprüfen
pj_umsatz_na <- pj_umsatz_wide %>%
  aggr(combined=TRUE, numbers=TRUE)

# imputierte Daten graphisch überprüfen
ggplot(pj_umsatz_wide) +
  geom_point(aes(x=Datum, y=Konditorei, color=Konditorei_imp))

# final umbenennen
pj_umsatz <- pj_umsatz_wide

# speichern
save(pj_umsatz, file = "pj_umsatz.Rda")
