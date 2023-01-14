# Datenaufbereitung Umsatz in Facheinzelhandel SH

# Monatlichen Umsatzt von Nahrungsmittel Facheinzelhandel in SH (auch Bäckerein) --> Datenaufbereitung
umsatzFachEinzelHandelSH <- read_csv("umsatztFachEinzelHandel.csv")
umsatzFachEinzelHandelSH <- select(umsatzFachEinzelHandelSH, "Jahr", "Monat", "Umsatz")
# Create a new column called "Datum"
umsatzFachEinzelHandelSH$Datum <- as.Date(paste(umsatzFachEinzelHandelSH$Jahr, umsatzFachEinzelHandelSH$Monat, "01", sep = "-"), format = "%Y-%m-%d")

# Remove the original Jahr and Monat columns
umsatzFachEinzelHandelSH$Jahr <- NULL
umsatzFachEinzelHandelSH$Monat <- NULL

#grouping the dataframe by year and month
umsatzFachEinzelHandelSH <- umsatzFachEinzelHandelSH %>% 
  group_by(year(Datum), month(Datum))
#selecting the first row of each group
first_row <- umsatzFachEinzelHandelSH %>% 
  slice_head(n=1)
#creating a new data frame with all the days in each month
days <- expand.grid(Jahr=unique(year(umsatzFachEinzelHandelSH$Datum)),Monat=unique(month(umsatzFachEinzelHandelSH$Datum)),Day=1:31)
# converting the above grid to a date format
days$Datum <- as.Date(paste(days$Jahr, days$Monat, days$Day, sep = "-"), format = "%Y-%m-%d")
# Removing the unnecessary columns from days dataframe
days$Jahr<-NULL
days$Monat<-NULL
days$Day<-NULL
#merging the two dataframe
umsatzFachEinzelHandelSH<-left_join(days,first_row,by=c("Datum"))

# Remove the original Jahr and Monat columns
umsatzFachEinzelHandelSH$`year(Datum)` <- NULL
umsatzFachEinzelHandelSH$`month(Datum)` <- NULL
umsatzFachEinzelHandelSH <- umsatzFachEinzelHandelSH %>% 
  filter(Datum >= as.Date("2013-07-01"))
umsatzFachEinzelHandelSH <- umsatzFachEinzelHandelSH %>% 
  filter(Datum < as.Date("2019-07-31"))

umsatzFachEinzelHandelSH <- umsatzFachEinzelHandelSH %>%  
  hotdeck(variable = c("Umsatz"), ord_var = "Datum")

ggplot(umsatzFachEinzelHandelSH) +
  geom_point(aes(x = Datum, y = Umsatz, color = Umsatz_imp))

umsatzFachEinzelHandelSH$Umsatz_imp <- NULL

umsatzFachEinzelHandelSH <- umsatzFachEinzelHandelSH %>%
  rename(UmsatzFEH = Umsatz)

save(umsatzFachEinzelHandelSH, file="umsatzFachEinzelHandelSH.Rda")
